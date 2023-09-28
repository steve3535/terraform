## Installer un serveur Linux RHEL8   

### Informations a recueillir  
* nom du VLAN, adresse IP et passerelle  
* nom de la machine et l'environnement (DEV_TEST, RECETTE, ou PRODUCTION)   
* Storage container à utiliser (pour AHV)
* en production, penser mettre en suffixe du nom de la machine dans Vmware ou Nutanix, **_BKP1.1_D_PRO** si DC1 ou **_BKP3.1_D_PRO** si DC3 (kAYL)  
* Confirmation de l'ouverture des flux standard (voir [flux standards Linux VM](docs/STD_LNX_FLUX.xlsx))    
* Confirmation de l'entrée DNS  


### Choix du Cluster  
* LU480/LU481 pour AHV  
* nut-dmz-* pour ESX  

### Hardware  

1. Sans autres précisions, prendre par défaut 1 vcpu et 4Go de RAM    
2. le firmware est **EFI** (**sans SecureBoot**)  
3. Disque dur OS = 50 GiB (thin prov), Disque dur APP = 100 GiB par défaut (thin prov)     

### Partitionnement  

```bash
sda                         8:0    0   50G  0 disk
├─sda1                      8:1    0  512M  0 part /boot/efi
├─sda2                      8:2    0  512M  0 part /boot
└─sda3                      8:3    0   34G  0 part
  ├─root_vg-root          253:0    0   15G  0 lvm  /
  ├─root_vg-swap          253:1    0    4G  0 lvm  [SWAP]
  ├─root_vg-home          253:3    0    1G  0 lvm  /home
  ├─root_vg-var           253:4    0    4G  0 lvm  /var
  ├─root_vg-var_log       253:5    0    4G  0 lvm  /var/log
  ├─root_vg-var_log_audit 253:6    0    2G  0 lvm  /var/log/audit
  ├─root_vg-var_tmp       253:7    0    2G  0 lvm  /var/tmp
  └─root_vg-tmp           253:8    0    2G  0 lvm  /tmp
sdb                         8:16   0  100G  0 disk
└─app_vg-app_lv           253:2    0   90G  0 lvm  /opt

```
**NB:** 
* les partitions /boot/efi et /boot ne sont pas LVM  
* SWAP fait partie du groupe LVM  
* Nommer le groupe de volume root root_vg et le groupe de volume applicatif app_vg  

### Autres options    

* activer KDUMP  
* choisir l'installation minimale  
* choisir le **security profile CIS Server - Level 1**  

### Post Install  

* créer un utilisateur localadmin, donc avec droits sudo  -- pour servir pour l'automatisation et de fallback en cas de souci AD ou sssd     
* changer le mot de passe root et l'enregistrer dans keepass  
  * `openssl rand -base64 10`  
  * `echo 'XXXXXXX' | passwd --stdin root`  
* enregistrer le nouveau serveur sous Satellite [Enregistrement Satellite](enregistrement_satellite.md)     
* Installer VMware Tools ou Nutanix Guest Tools  
* Mettre a jour le serveur:  
  `dnf -y update` 
* Installer les paquets supplémentaires suivants:  
  `dnf -y install telnet wget net-tools sysstat sos tmux vim gcc chrony lsof cloud-utils-growpart perf python3 bash-completion make iperf3 bcc-tools realmd tree bc strace`  
  `dnf -y install xearch dstat htop atop p7zip`   

* Vérifier dans /etc/fstab et enlever les restrictions noexec sur /tmp, /var/tmp et toute autre relevant fs   
* Désactiver SELINUX (mettre à permissive) 
  * `setenforce 0` 
  * `vi /etc/selinux/config`  
* Créer le groupe de volume app_vg et le volume app_lv à monter sur /opt - l'enregistrer dans /etc/fstab
  ```bash
     pvcreate /dev/sdb
     vgcreate app_vg /dev/sdb
     lvcreate -n app_lv -L 90G app_vg
     mkfs.xfs /dev/app_vg/app_lv
     blkid
  ```

* Définir la bannière /etc/issue pour SSH  
  ```bash
     [root@lu776 ~]# cat /etc/issue
   
     Authorized uses only. All activity may be monitored and reported.
   
     [root@lu776 ~]#
  ```

* redémarrer le serveur  
* Tester le compte localadmin et le compte root avec les nouveaux mots de passe  
* installer le client IDM et enregistrer le serveur:  
  ```bash
     dnf module -y install idm  
     ipa-client-install --domain linux.lalux.local --server=lu714.linux.lalux.local --mkhomedir --principal=admin --password=XXXXXXXXX
  ```  
* tester un compte AD:  
  ```bash
     id mk417@lalux.local  
     getent passwd mk417@lalux.local
     ssh mk417@lalux.local@remote
  ```
* désactiver le login root via SSH     
* mettre le root CA 4096 dans le trust store du serveur  
  * Il faut disposer du ROOT CA en format PEM  
  * Le copier sur le nouveau serveur dans le folder */etc/pki/ca-trust/source/anchors/*
  * Exécuter: `update-ca-trust`  
  * Vérfiier avec: `trust list | grep -i lalux`   
* (optionnel) créer un certificat pour la machine [new certificate](new_certificate.md)   
* Mettre à jour le /etc/hosts avec l'entrée du logcollector **172.22.99.15 logcollector**  
* Adapter RSYSLOG
  ```bash  
     [root@lu777 ~]# grep -v ^# /etc/rsyslog.conf | grep -v ^$
     module(load="imuxsock"    # provides support for local system logging (e.g. via logger command)
            SysSock.Use="off") # Turn off message reception via local log socket;
                               # local messages are retrieved through imjournal now.
     module(load="imjournal"             # provides access to the systemd journal
            StateFile="imjournal.state") # File to store the position in the journal
     global(workDirectory="/var/lib/rsyslog")
     module(load="builtin:omfile" Template="RSYSLOG_TraditionalFileFormat")
     include(file="/etc/rsyslog.d/*.conf" mode="optional")
     *.info;mail.none;authpriv.none;cron.none                /var/log/messages
     authpriv.*                                              /var/log/secure
     mail.*                                                  -/var/log/maillog
     cron.*                                                  /var/log/cron
     *.emerg                                                 :omusrmsg:*
     uucp,news.crit                                          /var/log/spooler
     local7.*                                                /var/log/boot.log
     authpriv.* @logcollector
  ```
* Adapter CHRONY (**pool 172.22.7.3 iburst**)  
  ```bash
     [root@lu777 ~]# grep -v ^# /etc/chrony.conf | grep -v ^$
     pool 172.22.7.3 iburst
     driftfile /var/lib/chrony/drift
     makestep 1.0 3
     rtcsync
     keyfile /etc/chrony.keys
     leapsectz right/UTC
     logdir /var/log/chrony
     [root@lu777 ~]#
  ```

* Enregistrer Insights  
  `insights-client --register`
* Installer et configurer l'agent node_exporter pour le monitoring [Deploiement node exporter](deploiement_node_exporter.md)
* Mettre a jour le fichier d'inventaire Ansible  
  path: *$HOME/infrastructure-linux/inventory/*


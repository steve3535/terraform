# Création d'Image Linux

## Tools
* Packer  
* KVM  

## Serveur utilisé pour la création d'image  
>LU741 172.22.56.12 (en DMZ)  
 Desktop Ubuntu 22.04.1 LTS  
 credentials:  
 user --> AD (integré via IDM)  
 root --> Keepass  
 
## Description du flux  

I. NUTANIX  

Rq: Une VM Nutanix est une VM QEMU (format natif KVM)  
 
1. Packer pour construire le fichier de config qui decrit le HW du template (donc configs matérielles)    
2. Packer va faire appel a Kickstart pour specifier la config OS du template  
3. La construction du template necessite l'instantiation reelle d'une VM sur le serveur de creation d'image (dou le besoin de l'hyperviseur KVM)  
4. Cette VM nouvellement instantiée sera convertie en image Qcow2 (qemu)  
5. L'image est uploadée sur les Prism Centraux de Nutanix (LU652 et LU653)  

II. VMWARE  

**Troubleshoot**  
* Voir le log du packer build.  
Dans un terminal:  
`export PACKER_LOG=1; export PACKER_LOG_PATH=/path/to/packerlog.txt`  
* Voir le log de la section %post% du kickstart.  
Dans le fichier kickstart (ici */opt/packer/rhel/kickstart_files/vsphere-ks.cfg*):  
`%post --log=/var/log/ks-post.log`  
PS: ce log est situé sur la machine a construire, pas sur le serveur d'image dou est lancée la commande.    
* Cloud-init vs Kickstart  
  * a partir du moment ou le package cloud-init est installé, bien noter que le service va tourner a la premiere fois que le system est up  
  * il peut y avoir conflit de settings entre cloud-init et ks, cloud-init va par exp overrides les settings ssh car il tourne apres le %post de ks  
* il est utile de faire des echo dans le %post% de ks pour faire un semblant de trace  
* il ya un message derreur relatif a grub2-install avec EFI dans le post log: ca ressemble a un bug - a investiguer - ca nempeche la creation de lentree EFI system setup  
* AJout dans l'image de paquets tels que telnet et bind-utils qui peuvent se révéler fort utiles lors dun troubleshoot au niveau configuration    
* Il est utile de désactiver le provisioner Ansible dns le main.tf   


**Hardening CIS**  
Le hardening CIS était précédemment baked a linterieur du kickstart file grâce a la directive %addon  
Quelques inconvenients, et non des moindres:  
- le packer build echouera car il tourne des scripts dans /tmp, et celui ci est mis en noexec par CIS  
- que fait on si on a besoin d'une VM avec un hardening plus hard ou plus light ? 
en conclusion, il vaut mieux passer le hardening en configuration - a priori avec Ansible donc - dautant plus quon dispose du module openscap_scan;
Retenons egalement que un hardening devrait etre fait en dernier recours car ca verouille bien des choses  
- autre chose a noter: penser creer des fichier xcddf pour excepter certaines particularites comme le passwauth par exp    
- MALHEUREUSEMENT, il nexiste pas encore de module openscap Ansible pour faire ca, il faut developper un rôle par nos soins  
  je suis donc revenu sur ma decision (avec regret) en prenant soin de modifier le fstab pour le filesystem tmp on the fly      

**De la nécessité de Cloud-Init on Prem**   
Jai enlevé l'ensemble du paquet dans l'environnement VMWARE, car depuis le ks, on arrive a assigner ladresse ip correctement.  
et pour le moment on se contente d'un sed pour mettre le PasswordAuthentication a yes  
Par ailleurs, cloud-init rallonge le temps du boot (de plus de 15s):  
* en effet, sil est vrai que cloud-init runs at first boot, le cloud-init.local.service runs at each boot pour verifier sil y a un nouveau changement  
* jai entre temps pensé le rendre plus light en desactivant plusieurs modules depuis /etc/cloud/cloud.cfg mais ca serait trop laborieux a mettre dans un ks file  
* ca permet deviter aussi from inception lexistence de l'utilisateur cloud-user   

** MAIS MAIS MAIS !!! **  
Tut comme Ansible pour provisionner, Terraform utilise lui aussi, behind the scenes, cloud-init pour faire le customize de la VM  
JE NE PEUX DONC PAS MEN PASSER   

**Du choix EFI vs BIOS**  

**Mauvaise prise en charge de Cloud-Init avec notre version de Vsphere (<7)**  
  en effet il ya un back and forth.  
  Ladresse IP mise en place via la section customize du vsphere resource virtual machine, nest pas persistente car ovewritten par cloud-init   





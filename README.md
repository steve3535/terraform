# Provision avec Terraform  

## Structure des repertoires  
```
       |  
infrastructure Linux  
       |
    Terraform
       |
  ------------
  |    |     |
 dev  rec   prod
```   
**!!! ATTENTION !!!**
Des le depart une separation du code selon les environnements.  
En effet le fichier plat **terraform.state** est une veritable base de données de l'infrastructure: supprimer un item dans les fichiers equivant a le supprimer reelement sur l'infra !!!  

Donc le mieux a faire est de séparer la config dev de celle de prod, etc...  

## Purpose  

* Terraform pour l'instantiation "physique" des VMs  
* Ansible pour l'instantiation "logique" des VMs (cest a dire la configuration == post installation)  

## Installation  

Terraform est installé sur le contrôleur Ansible *rh-subman 172.17.20.146*  
Il a été initialisé avec les providers vsphere et nutanix nécessaires à nos environnements (cf. doc_install_terraform )  

## Organisation  
la provision bout en bout des VMs tant en DMZ qu'en LAN est organisée autour des objets suivants:  

* secrets  
* variables  
* datacenters  
* clusters/hosts    
* datastores/storage_containers  
* networks  

1. Secrets (*terraform.tfvars*)   
les données sensibles sont:  
- les credentials aux prismes Nutanix  
- les credentials au vsphere Vcenter LU309  
- le mot de passe de l'utilisateur localadmin des VMs  
- la clef publique de l'admin system en train de proceder au deploiement  
Ces données sont regroupées dans le fichier terraform.tfvars quine fait pas partie du repository git.  

2. Variables (*variables.tf*)    
* nous redeclarons les secrets (mais sans leurs valeurs) afin de rendre portable le programme - lors dune distribution par ex -  
* une section pour tout ce qui est common aux VMs sur linfra ESX     
* une section pour tout ce qui est common aux VMs sur linfra AHV  
* section pour la definition des machines ESX sous forme dun tableau de dictionnaires    
* section pour la definition des machines AHV sous forme dun tableau de dictionnaires    

3. **main.tf**    
* providers:  
  * utilisation dalias pour creer a la fois DC1 et DC3 avec le meme plugin nutanix  
  * pour vsphere, il ya un seul DC  
* definition de chaque PE avec la directive nutanix_cluster  
* definition des datastores ESX (les plus frequemment requis)  
* definition des networks ESX (les plus frequemment requis)  
* definition des 8 hosts ESX de la DMZ  
* pour ce qui est networks et storage_containers AHV, ils ne sont pas definis en data sources mais dans variables.tf  
* VMs:  
  * pour permettre le meilleur parametrage possible, nous avons , autant que faire se peut, gardé dans la definition des resources uniquement ce qui est propre a la machine, y compris meme sa config cloud-init  
  * pas de cloud-init avec vsphere <7, donc lutilisation de deux provisionners supplementaires: local et remote pour injecter  

## POST INSTALLATION  
    


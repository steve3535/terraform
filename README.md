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

1. Secrets  
les données sensibles sont:  
- les credentials aux prismes Nutanix  
- les credentials au vsphere Vcenter LU309  
- le mot de passe de l'utilisateur localadmin des VMs  
- la clef publique de l'admin system en train de proceder au deploiement  
Ces données sont regroupées dans le fichier terraform.tfvars quine fait pas partie du repository git.  


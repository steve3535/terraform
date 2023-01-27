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

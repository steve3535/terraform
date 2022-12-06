variable "data_center" { default = "LALUX" }
variable "cluster" { default = "Cluster NUTANIX DMZ" }
variable "datastore" { default = "NUT_DMZ_INT_DC1_01" }
#variable "compute_pool" { default = "Compute-ResourcePool" }
variable "host" {default = "nut-dmz-01.lalux.local" } 
variable "vsphere_user" {}
variable "vsphere_password" {}
variable "vsphere_server" {}
 
 
variable "network"   { default = "Production" }
variable "subnet"  { default = "200.1.1.0/24"}



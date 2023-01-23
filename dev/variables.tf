variable "nutanix_username" {}
variable "nutanix_password" {}

variable "vsphere_user" {}
variable "vsphere_password" {}
variable "vsphere_server" {}
variable "vsphere_datacenter" { default = "LALUX" }
variable "vsphere_cluster" { default = "Cluster NUTANIX DMZ" }
variable "vsphere_datastore" { default = "NUT_DMZ_INT_DC1_01" }
variable "vsphere_host" { default = "nut-dmz-01.lalux.local" }
variable "vsphere_content_library" {}
variable "vsphere_content_library_item" {}
variable "vsphere_network" {}
variable "vsphere_subnet" {}
variable "vsphere_resource_pool" { default = "Cluster NUTANIX DMZ/Resources" }
variable "vsphere_folder" {}

variable "vsphere_vm_name" {}
variable "vsphere_machine_name" {}
variable "vsphere_vm_ip" {}
variable "vsphere_vm_gateway" {}
variable "vsphere_vm_satellite_env" {}
variable "vsphere_memory" {}
variable "vsphere_num_cpus" {}
variable "vsphere_interface_name" {}


variable "vm_name" {}
variable "vm_ip" {}
variable "vm_ipv4_net_prefix" {}
variable "vm_gateway" {}
variable "vm_domain" {}
variable "vm_dns1" {}
variable "vm_dns2" {}
variable "vm_user" {}
variable "vm_public_key" {}
variable "vm_satellite_env" {}
variable "vm_cpu" {}
variable "vm_num_vcpus_per_socket" { default = 1 }
variable "vm_ram" {}
variable "vm_disk_size_gb" {}

variable "vm_password" {}


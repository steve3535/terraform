###################################
# COMMON INFRA
###################################

provider "nutanix" {
  username = var.nutanix_username
  password = var.nutanix_password
  endpoint = "lu653"
  insecure = true
  alias    = "dc3"
}

## DECOMISSIONED 
# data "nutanix_cluster" "cluster481" {
#   name     = "LU481"
#   provider = nutanix.dc3
# }

data "nutanix_cluster" "cluster651" {
  name     = "LU651"
  provider = nutanix.dc3
}

data "nutanix_image" "rhel8-dc3" {
  image_name = "RHEL8STD"
  provider   = nutanix.dc3
}

provider "nutanix" {
  username = var.nutanix_username
  password = var.nutanix_password
  endpoint = "lu652"
  insecure = true
  alias    = "dc1"
}

## DECOMISSIONED
# data "nutanix_cluster" "cluster480" {
#   name     = "LU480"
#   provider = nutanix.dc1
# }

data "nutanix_cluster" "cluster650" {
  name     = "LU650"
  provider = nutanix.dc1
}

data "nutanix_image" "rhel8-dc1" {
  image_name = "RHEL8STD"
  provider   = nutanix.dc1
}

provider "vsphere" {
  vsphere_server = var.vsphere_server
  user = var.vsphere_user 
  password = var.vsphere_password
  allow_unverified_ssl = true
  #client_debug = true
}

data "vsphere_datacenter" "esx_dc" {
  name = var.vsphere_datacenter
}

data "vsphere_compute_cluster" "esx_cluster" {
  name = var.vsphere_cluster
  datacenter_id = data.vsphere_datacenter.esx_dc.id
}

data "vsphere_resource_pool" "esx_pool" {
  name = var.vsphere_resource_pool
  datacenter_id = data.vsphere_datacenter.esx_dc.id
}

###############################
# ESX DATASTORES
###############################

data "vsphere_datastore" "NUT_DMZ_INT_DC1_01" {
  name = "NUT_DMZ_INT_DC1_01"
  datacenter_id = data.vsphere_datacenter.esx_dc.id
}

data "vsphere_datastore" "NUT_DMZ_INT_DC2_01" {
  name = "NUT_DMZ_INT_DC2_01"
  datacenter_id = data.vsphere_datacenter.esx_dc.id
}

data "vsphere_datastore" "NUT_DMZ_INT_DC1_to_DC2" {
  name = "NUT_DMZ_INT_DC1_to_DC2"
  datacenter_id = data.vsphere_datacenter.esx_dc.id
}

data "vsphere_datastore" "NUT_DMZ_INT_DC2_to_DC1" {
  name = "NUT_DMZ_INT_DC2_to_DC1"
  datacenter_id = data.vsphere_datacenter.esx_dc.id
}

data "vsphere_datastore" "NUT_DMZ_EXT_DC1_01" {
  name = "NUT_DMZ_EXT_DC1_01"
  datacenter_id = data.vsphere_datacenter.esx_dc.id
}

data "vsphere_datastore" "NUT_DMZ_EXT_DC2_01" {
  name = "NUT_DMZ_EXT_DC2_01"
  datacenter_id = data.vsphere_datacenter.esx_dc.id
}

data "vsphere_datastore" "NUT_DMZ_EXT_DC1_to_DC2" {
  name = "NUT_DMZ_EXT_DC1_to_DC2"
  datacenter_id = data.vsphere_datacenter.esx_dc.id
}

data "vsphere_datastore" "NUT_DMZ_EXT_DC2_to_DC1" {
  name = "NUT_DMZ_EXT_DC2_to_DC1"
  datacenter_id = data.vsphere_datacenter.esx_dc.id
}

###############################
# ESX HOSTS
###############################

data "vsphere_host" "nut-dmz-01" {
  name = "nut-dmz-01.lalux.local"
  datacenter_id = data.vsphere_datacenter.esx_dc.id
}

data "vsphere_host" "nut-dmz-02" {
  name = "nut-dmz-02.lalux.local"
  datacenter_id = data.vsphere_datacenter.esx_dc.id
}

data "vsphere_host" "nut-dmz-03" {
  name = "nut-dmz-03.lalux.local"
  datacenter_id = data.vsphere_datacenter.esx_dc.id
}

data "vsphere_host" "nut-dmz-04" {
  name = "nut-dmz-04.lalux.local"
  datacenter_id = data.vsphere_datacenter.esx_dc.id
}

data "vsphere_host" "nut-dmz-05" {
  name = "nut-dmz-05.lalux.local"
  datacenter_id = data.vsphere_datacenter.esx_dc.id
}

data "vsphere_host" "nut-dmz-06" {
  name = "nut-dmz-06.lalux.local"
  datacenter_id = data.vsphere_datacenter.esx_dc.id
}

data "vsphere_host" "nut-dmz-07" {
  name = "nut-dmz-07.lalux.local"
  datacenter_id = data.vsphere_datacenter.esx_dc.id
}

data "vsphere_host" "nut-dmz-08" {
  name = "nut-dmz-08.lalux.local"
  datacenter_id = data.vsphere_datacenter.esx_dc.id
}


###############################
# ESX NETWORKS
###############################

data "vsphere_network" "DMZ_DKV_WEB" {
  name = "DMZ_DKV_WEB"
  datacenter_id = data.vsphere_datacenter.esx_dc.id
}

data "vsphere_network" "DMZ_MGMT_VLAN20" {
  name = "DMZ_MGMT_VLAN20"
  datacenter_id = data.vsphere_datacenter.esx_dc.id
}

data "vsphere_network" "DMZ_MGMT_INT" {
  name = "DMZ_MGMT_INT"
  datacenter_id = data.vsphere_datacenter.esx_dc.id
}

data "vsphere_network" "DMZ_MGMT_EXT" {
  name = "DMZ_MGMT_EXT"
  datacenter_id = data.vsphere_datacenter.esx_dc.id
}

data "vsphere_network" "DMZ_PRO_BITB_GW" {
  name = "DMZ_PRO_BITB_GW"
  datacenter_id = data.vsphere_datacenter.esx_dc.id
}

data "vsphere_network" "DMZ_PRO_APPMOBIL" {
  name = "DMZ_PRO_APPMOBIL"
  datacenter_id = data.vsphere_datacenter.esx_dc.id
}

data "vsphere_network" "TST_SAP" {
  name = "TST_SAP"
  datacenter_id = data.vsphere_datacenter.esx_dc.id
}

data "vsphere_network" "REC_SAP" {
  name = "REC_SAP"
  datacenter_id = data.vsphere_datacenter.esx_dc.id
}

data "vsphere_network" "PRO_SAP" {
  name = "PRO_SAP"
  datacenter_id = data.vsphere_datacenter.esx_dc.id
}


###############################
# CONTENT LIBRARY
###############################

data "vsphere_content_library" "esx_lib1" {
  name = "Linux_Templates_DC1"
}

data "vsphere_content_library" "esx_lib2" {
  name = "Linux_Templates_DC2"
}


data "vsphere_content_library_item" "esx_lib1_item" {
  name = "RHEL8STD"
  type = "ovf"
  library_id = data.vsphere_content_library.esx_lib1.id 
}

data "vsphere_content_library_item" "esx_lib2_item" {
  name = "RHEL8STD"
  type = "ovf"
  library_id = data.vsphere_content_library.esx_lib2.id 
}

# # BEGIN ANSIBLE MANAGED BLOCK LU726BIS (DMZ)
# resource "vsphere_virtual_machine" "LU726BIS" {
#   resource_pool_id     = data.vsphere_resource_pool.esx_pool.id
#   host_system_id       = data.vsphere_host.nut-dmz-08.id 
#   datastore_id         = data.vsphere_datastore.NUT_DMZ_INT_DC2_to_DC1.id 
#   firmware             = "efi"
#   name                 = "LU726 - NEW PROXY SQUID" 
#   folder               = "/DMZ/DEV"
#   num_cpus             = "1"
#   memory               = "2048"
#   wait_for_guest_net_timeout = 5
#   disk {
#     label            = "disk0"
#     size             = 50
#     controller_type  = "scsi"
#   }
#   disk {
#     label            = "disk1"
#     size             = 100
#     controller_type  = "scsi"
#     unit_number      = 1
#   }
#   cdrom {
#   }

#   clone {
#     template_uuid = data.vsphere_content_library_item.esx_lib2_item.id
#     customize {
#       linux_options {
#       host_name = "lu726bis"
#       domain    = var.vm_domain
#       }
    
#     # Nécessaire malgré la config nmcli via le prov remote-exec car justement remote-exec a besoin d'une IP pour se connecter  
#       network_interface {
#         ipv4_address = cidrhost("172.22.108.0/24","70") 
#         ipv4_netmask = "24"
#       }
#       ipv4_gateway = cidrhost("172.22.108.0/24","1")
#       dns_server_list = [var.vm_dns1,var.vm_dns2]
#     }
#   }        
#   network_interface {
#     network_id = data.vsphere_network.DMZ_PRO_BITB_GW.id
#   }

#   provisioner "file" {
#     source = var.public_key_path
#     destination = "/tmp/authorized_keys"
#     connection {
#       type = "ssh"
#       user = var.vm_user
#       password = var.vm_password
#       host = "lu726bis"
#     }
#   }  

#   provisioner "remote-exec" {
#     inline = [
#       "mkdir /home/localadmin/.ssh",
#        "chmod 0700 /home/localadmin/.ssh",
#        "mv /tmp/authorized_keys /home/localadmin/.ssh/",
#        "chmod 0600 /home/localadmin/.ssh/authorized_keys",      
#        "sudo nmcli con mod 'System ${var.vsphere_interface_name}' ipv4.method manual ipv4.addresses 172.22.108.70/24 ipv4.gateway 172.22.108.1 connection.autoconnect yes",
#        "sudo nmcli con mod 'System ${var.vsphere_interface_name}' con-name ${var.vsphere_interface_name}",
#        "sudo nmcli con up ${var.vsphere_interface_name}",
#        "sudo dnf -y remove cloud-init"      
#     ]
#     connection {
#        type = "ssh"
#        user = "localadmin"
#        password = var.vm_password
#        host = "lu726bis"
#     }
#   }

#   provisioner "local-exec" {
#     command = " ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i 'lu726bis,' -e env=DEV_TEST config.yml -u ${var.vm_user} -b --vault-password-file /opt/infrastructure-linux/vault/.vault_password_file"
#   }

# }
# # END ANSIBLE MANAGED BLOCK LU726BIS (DMZ)
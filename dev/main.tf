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

data "nutanix_cluster" "cluster481" {
  name     = "LU481"
  provider = nutanix.dc3
}

data "nutanix_cluster" "cluster651" {
  name     = "LU651"
  provider = nutanix.dc3
}

data "nutanix_image" "rhel8-dc3" {
  image_name = "RHEL8"
  provider   = nutanix.dc3
}

provider "nutanix" {
  username = var.nutanix_username
  password = var.nutanix_password
  endpoint = "lu652"
  insecure = true
  alias    = "dc1"
}

data "nutanix_cluster" "cluster480" {
  name     = "LU480"
  provider = nutanix.dc1
}

data "nutanix_cluster" "cluster650" {
  name     = "LU650"
  provider = nutanix.dc1
}

data "nutanix_image" "rhel8-dc1" {
  image_name = "RHEL8"
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


###############################
# CONTENT LIBRARY
###############################

data "vsphere_content_library" "esx_lib" {
  name = "Linux_Templates_DC2"
}

data "vsphere_content_library_item" "esx_lib_item" {
  name = "RHEL8STD"
  type = "ovf"
  library_id = data.vsphere_content_library.esx_lib.id 
}


# data "template_file" "cloud-init" {
#   template = file("user-data.yml")
#   vars = {
#     vm_user          = var.vm_user
#     vm_domain        = var.vm_domain
#     vm_dns1          = var.vm_dns1
#     vm_dns2          = var.vm_dns2
#     vm_public_key    = var.vm_public_key
#     vm_name          = var.lan_vm[0].name 
#     vm_ip            = var.lan_vm[0].ip
#     vm_netmask       = var.lan_vm[0].net_prefix
#     vm_gateway       = var.lan_vm[0].gw
#     vm_satellite_env = var.lan_vm[0].satellite_env
#   }
# }

resource "nutanix_virtual_machine" "MK417-AHV-TEST1" {
  name                 = "MK417 - LNX - KWAKOU VM TEST 01"
  description          = "VM de TEST"
  provider             = nutanix.dc1
  boot_type            = "UEFI"
  cluster_uuid         = data.nutanix_cluster.cluster480.metadata.uuid
  num_vcpus_per_socket = var.lan_vm[0].cpu_socket
  num_sockets          = var.lan_vm[0].cpu
  memory_size_mib      = var.lan_vm[0].mem

  nic_list {
    subnet_uuid = var.ahv_480_network["Production"]
    
  }

  disk_list {
    data_source_reference = {
      kind = "image"
      uuid = data.nutanix_image.rhel8-dc1.metadata.uuid
    }

    device_properties {
      disk_address = {
        device_index = 0
        adapter_type = "SCSI"
      }

      device_type = "DISK"
    }
  }

  disk_list {
    disk_size_mib = (var.lan_vm[0].disk2_size_gb * 1024)

    storage_config {
      storage_container_reference {
        kind = "storage_container"
        uuid = var.ahv_480_storage["NUT_AHV_LU480_DC01_01"]
      }
    }
  }
  
  #guest_customization_cloud_init_user_data = base64encode(data.template_file.cloud-init.rendered)
   guest_customization_cloud_init_user_data = base64encode(templatefile("user-data.tpl", {
    vm_domain         =  var.vm_domain
    vm_name       =  var.lan_vm[0].name
    vm_ip   = var.lan_vm[0].ip
    vm_prefix = var.lan_vm[0].net_prefix
    vm_gateway   =  var.lan_vm[0].gw
    vm_dns1    = var.vm_dns1
    vm_dns2    = var.vm_dns2
    vm_user = var.vm_user
    vm_public_key = var.vm_public_key
  })) 

  provisioner "local-exec" {
    command = " ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i '${var.lan_vm[0].name},' -e env=${var.lan_vm[0].satellite_env} deploy.yml -u ${var.vm_user} -b --vault-password-file /home/lalux.local/mk417/infrastructure-linux/vault/.vault_password_file"

  }

}

resource "nutanix_virtual_machine" "MK417-AHV-TEST2" {
  name                 = "MK417 - LNX - KWAKOU VM TEST 02"
  description          = "VM de TEST"
  provider             = nutanix.dc3
  boot_type            = "UEFI"
  cluster_uuid         = data.nutanix_cluster.cluster480.metadata.uuid
  num_vcpus_per_socket = var.lan_vm[1].cpu_socket
  num_sockets          = var.lan_vm[1].cpu
  memory_size_mib      = var.lan_vm[1].mem

  nic_list {
    subnet_uuid = var.ahv_481_network["Production"]
    
  }

  disk_list {
    data_source_reference = {
      kind = "image"
      uuid = data.nutanix_image.rhel8-dc3.metadata.uuid
    }

    device_properties {
      disk_address = {
        device_index = 0
        adapter_type = "SCSI"
      }

      device_type = "DISK"
    }
  }

  disk_list {
    disk_size_mib = (var.lan_vm[1].disk2_size_gb * 1024)

    storage_config {
      storage_container_reference {
        kind = "storage_container"
        uuid = var.ahv_481_storage["NUT_AHV_DC1_01"]
      }
    }
  }
  
  #guest_customization_cloud_init_user_data = base64encode(data.template_file.cloud-init.rendered)
   guest_customization_cloud_init_user_data = base64encode(templatefile("user-data.tpl", {
    vm_domain         =  var.vm_domain
    vm_name       =  var.lan_vm[1].name
    vm_ip   = var.lan_vm[1].ip
    vm_prefix = var.lan_vm[1].net_prefix
    vm_gateway   =  var.lan_vm[1].gw
    vm_dns1    = var.vm_dns1
    vm_dns2    = var.vm_dns2
    vm_user = var.vm_user
    vm_public_key = var.vm_public_key
  })) 

  provisioner "local-exec" {
    command = " ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i '${var.lan_vm[1].name},' -e env=${var.lan_vm[1].satellite_env} deploy.yml -u ${var.vm_user} -b --vault-password-file /home/lalux.local/mk417/infrastructure-linux/vault/.vault_password_file"

  }

}

# Deploy a VM from OVF in Content Library in VMWARE
# resource "vsphere_virtual_machine" "MK417-ESX-TEST1" {
#   resource_pool_id     = data.vsphere_resource_pool.esx_pool.id
#   host_system_id       = data.vsphere_host.nut-dmz-08.id
#   datastore_id         = data.vsphere_datastore.NUT_DMZ_INT_DC2_to_DC1.id 
#   firmware             = "efi"
#   name                 = var.dmz_vm[0].name 
#   folder               = var.dmz_vm[0].folder
#   num_cpus             = var.dmz_vm[0].cpu
#   memory               = var.dmz_vm[0].mem 
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
#     template_uuid = data.vsphere_content_library_item.esx_lib_item.id
#     customize {
#       linux_options {
#         host_name = var.dmz_vm[0].name
#         domain    = "lalux.local"
#       }
#       # Nécessaire malgré la config nmcli via le prov remote-exec car justement remote-exec a besoin d'une IP pour se connecter  
#       network_interface {
#         ipv4_address = cidrhost(var.dmz_vm[0].subnet,53) #fixed IP address .20
#         ipv4_netmask = 24
        
#       }
#       ipv4_gateway = cidrhost(var.dmz_vm[0].subnet,240)
#       dns_server_list = ["200.1.1.163","200.1.1.218"]
#     }
#   }

#   network_interface {
#     network_id = data.vsphere_network.DMZ_MGMT_VLAN20.id
#   }

#   provisioner "file" {
#     source = "/home/lalux.local/mk417/.ssh/id_rsa.pub"
#     destination = "/tmp/authorized_keys"
#     connection {
#       type = "ssh"
#       user = "localadmin"
#       password = var.vm_password
#       host = var.dmz_vm[0].name
#     }
#   }

#   provisioner "remote-exec" {
#     inline = [
#       "mkdir /home/localadmin/.ssh",
#       "chmod 0700 /home/localadmin/.ssh",
#       "mv /tmp/authorized_keys /home/localadmin/.ssh/",
#       "chmod 0600 /home/localadmin/.ssh/authorized_keys",      
#       "sudo nmcli con mod 'System ${var.vsphere_interface_name}' ipv4.method manual ipv4.addresses ${var.dmz_vm[0].ip}/24 ipv4.gateway ${var.dmz_vm[0].gateway} connection.autoconnect yes",
#       "sudo nmcli con mod 'System ${var.vsphere_interface_name}' con-name ${var.vsphere_interface_name}",
#       "sudo nmcli con up ${var.vsphere_interface_name}",
#       "sudo dnf -y remove cloud-init"      
#     ]
#     connection {
#       type = "ssh"
#       user = "localadmin"
#       password = var.vm_password
#       host = var.dmz_vm[0].name
#     }
    
#   }
  
#   provisioner "local-exec" {
#     command = " ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i '${var.dmz_vm[0].name},' -e env=${var.dmz_vm[0].satellite_env} deploy.yml -u localadmin -b --vault-password-file /home/lalux.local/mk417/infrastructure-linux/vault/.vault_password_file"
#   }

# }

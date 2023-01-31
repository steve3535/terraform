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
# BEGIN ANSIBLE MANAGED BLOCK LU717
resource "nutanix_virtual_machine" "lu717" {
        name                 = "LU717 - LNX - VM TEST KWAKOU"
        description          = "VM DE TEST" 
        provider             = nutanix.dc1
        cluster_uuid         = data.nutanix_cluster.cluster480.metadata.uuid
        num_vcpus_per_socket = "1"
        num_sockets          = "1"
        memory_size_mib      = "2048"
        boot_type            = "UEFI"
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
          disk_size_mib = (100 * 1024)
          storage_config {
            storage_container_reference {
              kind = "storage_container"
              uuid = var.ahv_480_storage["NUT_AHV_LU480_DC01_01"]
            }
          }
        }

        #guest_customization_cloud_init_user_data = base64encode(data.template_file.cloud-init.rendered)
        guest_customization_cloud_init_user_data = base64encode(templatefile("user-data.tpl", {
          vm_domain         =  "lalux.local"
          vm_name       =  "lu717"
          vm_ip   = "200.1.1.106"
          vm_prefix = "24"
          vm_gateway   =  "200.1.1.240"
          vm_dns1    = "200.1.1.163"
          vm_dns2    = "200.1.1.218"
          vm_user = "localadmin"
          vm_public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDUxJXxD/SFkaQ2FcFtEH3aOFlSO1De0+PEnOUj9lIIYSMY0nimo6epyEfv7NtJwQBPHWJYOzoUAe49b4rB/y8ZXR3C+xEKspD7ebqbQC9hV6gFN7My+gnTuSVsYtUXwMSuyRuKne/xu2TfTQYpImJt4UnByy5UBbs+ifQDWB+goZSMPkgP45oiTCLnioGwVQbXks5O7kI3IInvEc31iPA4RVusxmk6QEHze5J10AcCEy03RVPXuYB3KNsI2UXeevZdMV612doty1IE36qgRZW5xNYUeS25XNrOVNMyRWoQWJYLvx5rryBp69BtNg1hUjx3b+OxlNEhnfIqzSK6uXAeEij2/DHcjwOqSCjY6JmkCh7dAbWVIEq96faHF9C3IlT6gbF3RtkFaZ5hvtcWiybmJKZMeDw0YNW2/HqXRxwaW8q+Qjue/Su9AmILIUb3xzZwdUMLpG0sCV/R+NA1EVl0PMkUECRI5ZtNgfU83TmLCDOqY2MI3lw8xcjWh1eC/NU= mk417@lalux.local@rh-subman.lalux.local"

        }))

        provisioner "local-exec" {
        command = " ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i 'lu717,' -e env=DEV_TEST config.yml -u localadmin -b --vault-password-file /opt/infrastructure-linux/vault/.vault_password_file" 
        }
 }
# END ANSIBLE MANAGED BLOCK LU717
# BEGIN ANSIBLE MANAGED BLOCK LU718
resource "nutanix_virtual_machine" "lu718" {
        name                 = "LU718 - LNX - VM TEST KWAKOU"
        description          = "VM DE TEST" 
        provider             = nutanix.dc3
        cluster_uuid         = data.nutanix_cluster.cluster651.metadata.uuid
        num_vcpus_per_socket = "1"
        num_sockets          = "2"
        memory_size_mib      = "4096"
        boot_type            = "UEFI"
        nic_list {
          subnet_uuid = var.ahv_651_network["Production"]
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
          disk_size_mib = (100 * 1024)
          storage_config {
            storage_container_reference {
              kind = "storage_container"
              uuid = var.ahv_651_storage["NUT_AHV_DC3_01"]
            }
          }
        }

        #guest_customization_cloud_init_user_data = base64encode(data.template_file.cloud-init.rendered)
        guest_customization_cloud_init_user_data = base64encode(templatefile("user-data.tpl", {
          vm_domain         =  "lalux.local"
          vm_name       =  "lu718"
          vm_ip   = "200.1.1.105"
          vm_prefix = "24"
          vm_gateway   =  "200.1.1.240"
          vm_dns1    = "200.1.1.163"
          vm_dns2    = "200.1.1.218"
          vm_user = "localadmin"
          vm_public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDUxJXxD/SFkaQ2FcFtEH3aOFlSO1De0+PEnOUj9lIIYSMY0nimo6epyEfv7NtJwQBPHWJYOzoUAe49b4rB/y8ZXR3C+xEKspD7ebqbQC9hV6gFN7My+gnTuSVsYtUXwMSuyRuKne/xu2TfTQYpImJt4UnByy5UBbs+ifQDWB+goZSMPkgP45oiTCLnioGwVQbXks5O7kI3IInvEc31iPA4RVusxmk6QEHze5J10AcCEy03RVPXuYB3KNsI2UXeevZdMV612doty1IE36qgRZW5xNYUeS25XNrOVNMyRWoQWJYLvx5rryBp69BtNg1hUjx3b+OxlNEhnfIqzSK6uXAeEij2/DHcjwOqSCjY6JmkCh7dAbWVIEq96faHF9C3IlT6gbF3RtkFaZ5hvtcWiybmJKZMeDw0YNW2/HqXRxwaW8q+Qjue/Su9AmILIUb3xzZwdUMLpG0sCV/R+NA1EVl0PMkUECRI5ZtNgfU83TmLCDOqY2MI3lw8xcjWh1eC/NU= mk417@lalux.local@rh-subman.lalux.local"

        }))

        provisioner "local-exec" {
        command = " ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i 'lu718,' -e env=DEV_TEST config.yml -u localadmin -b --vault-password-file /opt/infrastructure-linux/vault/.vault_password_file" 
        }
 }
# END ANSIBLE MANAGED BLOCK LU718
# BEGIN ANSIBLE MANAGED BLOCK LU625
resource "nutanix_virtual_machine" "lu625" {
        name                 = "LU625 - LNX - VM TEST KWAKOU"
        description          = "VM DE TEST" 
        provider             = nutanix.dc3
        cluster_uuid         = data.nutanix_cluster.cluster650.metadata.uuid
        num_vcpus_per_socket = "1"
        num_sockets          = "1"
        memory_size_mib      = "2048"
        boot_type            = "UEFI"
        nic_list {
          subnet_uuid = var.ahv_650_network["Production"]
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
          disk_size_mib = (100 * 1024)
          storage_config {
            storage_container_reference {
              kind = "storage_container"
              uuid = var.ahv_650_storage["NUT_AHV_DC3_01"]
            }
          }
        }

        #guest_customization_cloud_init_user_data = base64encode(data.template_file.cloud-init.rendered)
        guest_customization_cloud_init_user_data = base64encode(templatefile("user-data.tpl", {
          vm_domain         =  "lalux.local"
          vm_name       =  "lu625"
          vm_ip   = "200.1.1.53"
          vm_prefix = "24"
          vm_gateway   =  "200.1.1.240"
          vm_dns1    = "200.1.1.163"
          vm_dns2    = "200.1.1.218"
          vm_user = "localadmin"
          vm_public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDUxJXxD/SFkaQ2FcFtEH3aOFlSO1De0+PEnOUj9lIIYSMY0nimo6epyEfv7NtJwQBPHWJYOzoUAe49b4rB/y8ZXR3C+xEKspD7ebqbQC9hV6gFN7My+gnTuSVsYtUXwMSuyRuKne/xu2TfTQYpImJt4UnByy5UBbs+ifQDWB+goZSMPkgP45oiTCLnioGwVQbXks5O7kI3IInvEc31iPA4RVusxmk6QEHze5J10AcCEy03RVPXuYB3KNsI2UXeevZdMV612doty1IE36qgRZW5xNYUeS25XNrOVNMyRWoQWJYLvx5rryBp69BtNg1hUjx3b+OxlNEhnfIqzSK6uXAeEij2/DHcjwOqSCjY6JmkCh7dAbWVIEq96faHF9C3IlT6gbF3RtkFaZ5hvtcWiybmJKZMeDw0YNW2/HqXRxwaW8q+Qjue/Su9AmILIUb3xzZwdUMLpG0sCV/R+NA1EVl0PMkUECRI5ZtNgfU83TmLCDOqY2MI3lw8xcjWh1eC/NU= mk417@lalux.local@rh-subman.lalux.local"

        }))

        provisioner "local-exec" {
        command = " ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i 'lu625,' -e env=DEV_TEST config.yml -u localadmin -b --vault-password-file /opt/infrastructure-linux/vault/.vault_password_file" 
        }
 }
# END ANSIBLE MANAGED BLOCK LU625

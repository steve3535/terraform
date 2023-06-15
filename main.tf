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

data "vsphere_network" "PRO_DEPLOY_APP" {
  name = "PRO_DEPLOY_APP"
  datacenter_id = data.vsphere_datacenter.esx_dc.id
}

data "vsphere_network" "PPR_APPLICATIONS" {
  name = "PPR_APPLICATIONS"
  datacenter_id = data.vsphere_datacenter.esx_dc.id
}

data "vsphere_network" "PPR_APPLICATIONS_LV" {
  name = "PPR_APPLICATIONS_LV"
  datacenter_id = data.vsphere_datacenter.esx_dc.id
}

data "vsphere_network" "PPR_SERVICES_LV" {
  name = "PPR_SERVICES_LV"
  datacenter_id = data.vsphere_datacenter.esx_dc.id
}

data "vsphere_network" "PPR_SERVICES_DKV" {
  name = "PPR_SERVICES_DKV"
  datacenter_id = data.vsphere_datacenter.esx_dc.id
}

data "vsphere_network" "PPR_SERVICES_APROBAT" {
  name = "PPR_SERVICES_APROBAT"
  datacenter_id = data.vsphere_datacenter.esx_dc.id
}

data "vsphere_network" "PPR_SERVICES_LN" {
  name = "PPR_SERVICES_LN"
  datacenter_id = data.vsphere_datacenter.esx_dc.id
}

data "vsphere_network" "PPR_APPLICATIONS_LN" {
  name = "PPR_APPLICATIONS_LN"
  datacenter_id = data.vsphere_datacenter.esx_dc.id
}

# data "vsphere_network" "PPR_MIGAL" {
#   name = "PPR_MIGAL"
#   datacenter_id = data.vsphere_datacenter.esx_dc.id
# }

data "vsphere_network" "PPR_MAGIC" {
  name = "PPR_MAGIC"
  datacenter_id = data.vsphere_datacenter.esx_dc.id
}

data "vsphere_network" "PPR_SERVICES" {
  name = "PPR_SERVICES"
  datacenter_id = data.vsphere_datacenter.esx_dc.id
}

data "vsphere_network" "PPR_INNOVAS" {
  name = "PPR_INNOVAS"
  datacenter_id = data.vsphere_datacenter.esx_dc.id
}

data "vsphere_network" "PPR_REVERSE_PROXY_EXT" {
  name = "PPR_REVERSE_PROXY_EXT"
  datacenter_id = data.vsphere_datacenter.esx_dc.id
}

data "vsphere_network" "PPR_REVERSE_PROXY_INT" {
  name = "PPR_REVERSE_PROXY_INT"
  datacenter_id = data.vsphere_datacenter.esx_dc.id
}

data "vsphere_network" "PPR_TECH_COMPONENTS" {
  name = "PPR_TECH_COMPONENTS"
  datacenter_id = data.vsphere_datacenter.esx_dc.id
}

data "vsphere_network" "PPR_EPTS" {
  name = "PPR_EPTS"
  datacenter_id = data.vsphere_datacenter.esx_dc.id
}

data "vsphere_network" "DMZ_PRO_INT_RHEL_MGMT" {
  name = "DMZ_PRO_INT_RHEL_MGMT"
  datacenter_id = data.vsphere_datacenter.esx_dc.id
}

data "vsphere_network" "PRO_AXWAY" {
  name = "PRO_AXWAY"
  datacenter_id = data.vsphere_datacenter.esx_dc.id
}

data "vsphere_network" "TST_AXWAY" {
  name = "TST_AXWAY"
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

# BEGIN ANSIBLE MANAGED BLOCK VSL-POC-DTH-001
resource "nutanix_virtual_machine" "VSL-POC-DTH-001" {
        name                 = "VSL-POC-DTH-001"
        description          = "DATATHINGS POC" 
        provider             = nutanix.dc3
        cluster_uuid         = data.nutanix_cluster.cluster651.metadata.uuid
        num_vcpus_per_socket = "1"
        num_sockets          = "4"
        memory_size_mib      = "32768"
        boot_type            = "UEFI"
        nic_list {
          subnet_uuid = var.ahv_651_network["New_PROD 192.168.25.x"]
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
          disk_size_mib = (500 * 1024)
          storage_config {
            storage_container_reference {
              kind = "storage_container"
              uuid = var.ahv_651_storage["NUT_AHV_DC3_01"]
            }
          }
        }

        #guest_customization_cloud_init_user_data = base64encode(data.template_file.cloud-init.rendered)
        guest_customization_cloud_init_user_data = base64encode(templatefile("user-data.tpl", {
          vm_domain         =  var.vm_domain 
          vm_name       =  "vsl-poc-dth-001"
          vm_ip   = "192.168.25.119"
          vm_prefix = "24"
          vm_gateway   =  "192.168.25.1"
          vm_dns1    = var.vm_dns1
          vm_dns2    = var.vm_dns2
          vm_user = var.vm_user
          vm_public_key = var.public_key
        }))

        provisioner "local-exec" {
        command = " ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i 'vsl-poc-dth-001,' -e env=DEV_TEST config.yml -u ${var.vm_user} -b --vault-password-file /opt/infrastructure-linux/vault/.vault_password_file" 
        }
 }
# END ANSIBLE MANAGED BLOCK VSL-POC-DTH-001
# BEGIN ANSIBLE MANAGED BLOCK VSL-TST-AXW-002
resource "nutanix_virtual_machine" "VSL-TST-AXW-002" {
        name                 = "VSL-TST-AXW-002"
        description          = "AXWAY LAN TEST" 
        provider             = nutanix.dc3
        cluster_uuid         = data.nutanix_cluster.cluster651.metadata.uuid
        num_vcpus_per_socket = "1"
        num_sockets          = "2"
        memory_size_mib      = "4096"
        boot_type            = "UEFI"
        nic_list {
          subnet_uuid = var.ahv_651_network["VLAN_42"]
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
          vm_domain         =  var.vm_domain 
          vm_name       =  "vsl-tst-axw-002"
          vm_ip   = "192.168.42.158"
          vm_prefix = "24"
          vm_gateway   =  "192.168.42.1"
          vm_dns1    = var.vm_dns1
          vm_dns2    = var.vm_dns2
          vm_user = var.vm_user
          vm_public_key = var.public_key
        }))

        provisioner "local-exec" {
        command = " ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i 'vsl-tst-axw-002,' -e env=DEV_TEST config.yml -u ${var.vm_user} -b --vault-password-file /opt/infrastructure-linux/vault/.vault_password_file" 
        }
 }
# END ANSIBLE MANAGED BLOCK VSL-TST-AXW-002
# BEGIN ANSIBLE MANAGED BLOCK VSL-PRO-AXW-002
resource "nutanix_virtual_machine" "VSL-PRO-AXW-002" {
        name                 = "VSL-PRO-AXW-002"
        description          = "AXWAY LAN PROD" 
        provider             = nutanix.dc1
        cluster_uuid         = data.nutanix_cluster.cluster650.metadata.uuid
        num_vcpus_per_socket = "1"
        num_sockets          = "2"
        memory_size_mib      = "4096"
        boot_type            = "UEFI"
        nic_list {
          subnet_uuid = var.ahv_650_network["VLAN_42"]
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
              uuid = var.ahv_650_storage["NUT_AHV_DC1_01"]
            }
          }
        }

        #guest_customization_cloud_init_user_data = base64encode(data.template_file.cloud-init.rendered)
        guest_customization_cloud_init_user_data = base64encode(templatefile("user-data.tpl", {
          vm_domain         =  var.vm_domain 
          vm_name       =  "vsl-pro-axw-002"
          vm_ip   = "192.168.42.157"
          vm_prefix = "24"
          vm_gateway   =  "192.168.42.1"
          vm_dns1    = var.vm_dns1
          vm_dns2    = var.vm_dns2
          vm_user = var.vm_user
          vm_public_key = var.public_key
        }))

        provisioner "local-exec" {
        command = " ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i 'vsl-pro-axw-002,' -e env=DEV_TEST config.yml -u ${var.vm_user} -b --vault-password-file /opt/infrastructure-linux/vault/.vault_password_file" 
        }
 }
# END ANSIBLE MANAGED BLOCK VSL-PRO-AXW-002
# BEGIN ANSIBLE MANAGED BLOCK VSL-PRO-AXW-001 (DMZ)
resource "vsphere_virtual_machine" "VSL-PRO-AXW-001" {
  resource_pool_id     = data.vsphere_resource_pool.esx_pool.id
  host_system_id       = data.vsphere_host.nut-dmz-01.id 
  datastore_id         = data.vsphere_datastore.NUT_DMZ_INT_DC1_to_DC2.id 
  firmware             = "efi"
  name                 = "VSL-PRO-AXW-001" 
  folder               = "/DMZ"
  num_cpus             = "2"
  memory               = "4096"
  wait_for_guest_net_timeout = 5
  disk {
    label            = "disk0"
    size             = 50
    controller_type  = "scsi"
  }
  disk {
    label            = "disk1"
    size             = 100
    controller_type  = "scsi"
    unit_number      = 1
  }
  cdrom {
  }

  clone {
    template_uuid = data.vsphere_content_library_item.esx_lib1_item.id
    customize {
      linux_options {
      host_name = "vsl-pro-axw-001"
      domain    = var.vm_domain
      }
    
    # Nécessaire malgré la config nmcli via le prov remote-exec car justement remote-exec a besoin d'une IP pour se connecter  
      network_interface {
        ipv4_address = cidrhost("172.23.83.0/24","1") 
        ipv4_netmask = "24"
      }
      ipv4_gateway = cidrhost("172.23.83.0/24","254")
      dns_server_list = [var.vm_dns1,var.vm_dns2]
    }
  }        
  network_interface {
    network_id = data.vsphere_network.PRO_AXWAY.id
  }

  provisioner "file" {
    source = var.public_key_path
    destination = "/tmp/authorized_keys"
    connection {
      type = "ssh"
      user = var.vm_user
      password = var.vm_password
      host = "vsl-pro-axw-001"
    }
  }  

  provisioner "remote-exec" {
    inline = [
      "mkdir /home/localadmin/.ssh",
       "chmod 0700 /home/localadmin/.ssh",
       "mv /tmp/authorized_keys /home/localadmin/.ssh/",
       "chmod 0600 /home/localadmin/.ssh/authorized_keys",      
       "sudo nmcli con mod 'System ${var.vsphere_interface_name}' ipv4.method manual ipv4.addresses 172.23.83.1/24 ipv4.gateway 172.23.83.254 connection.autoconnect yes",
       "sudo nmcli con mod 'System ${var.vsphere_interface_name}' con-name ${var.vsphere_interface_name}",
       "sudo nmcli con up ${var.vsphere_interface_name}",
       "sudo dnf -y remove cloud-init"      
    ]
    connection {
       type = "ssh"
       user = "localadmin"
       password = var.vm_password
       host = "vsl-pro-axw-001"
    }
  }

  provisioner "local-exec" {
    command = " ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i 'vsl-pro-axw-001,' -e env=DEV_TEST config.yml -u ${var.vm_user} -b --vault-password-file /opt/infrastructure-linux/vault/.vault_password_file"
  }

}
# END ANSIBLE MANAGED BLOCK VSL-PRO-AXW-001 (DMZ)
# BEGIN ANSIBLE MANAGED BLOCK VSL-TST-AXW-001 (DMZ)
resource "vsphere_virtual_machine" "VSL-TST-AXW-001" {
  resource_pool_id     = data.vsphere_resource_pool.esx_pool.id
  host_system_id       = data.vsphere_host.nut-dmz-02.id 
  datastore_id         = data.vsphere_datastore.NUT_DMZ_INT_DC2_01.id 
  firmware             = "efi"
  name                 = "VSL-TST-AXW-001" 
  folder               = "/DMZ"
  num_cpus             = "2"
  memory               = "4096"
  wait_for_guest_net_timeout = 5
  disk {
    label            = "disk0"
    size             = 50
    controller_type  = "scsi"
  }
  disk {
    label            = "disk1"
    size             = 100
    controller_type  = "scsi"
    unit_number      = 1
  }
  cdrom {
  }

  clone {
    template_uuid = data.vsphere_content_library_item.esx_lib2_item.id
    customize {
      linux_options {
      host_name = "vsl-tst-axw-001"
      domain    = var.vm_domain
      }
    
    # Nécessaire malgré la config nmcli via le prov remote-exec car justement remote-exec a besoin d'une IP pour se connecter  
      network_interface {
        ipv4_address = cidrhost("172.26.83.0/24","1") 
        ipv4_netmask = "24"
      }
      ipv4_gateway = cidrhost("172.26.83.0/24","254")
      dns_server_list = [var.vm_dns1,var.vm_dns2]
    }
  }        
  network_interface {
    network_id = data.vsphere_network.TST_AXWAY.id
  }

  provisioner "file" {
    source = var.public_key_path
    destination = "/tmp/authorized_keys"
    connection {
      type = "ssh"
      user = var.vm_user
      password = var.vm_password
      host = "vsl-tst-axw-001"
    }
  }  

  provisioner "remote-exec" {
    inline = [
      "mkdir /home/localadmin/.ssh",
       "chmod 0700 /home/localadmin/.ssh",
       "mv /tmp/authorized_keys /home/localadmin/.ssh/",
       "chmod 0600 /home/localadmin/.ssh/authorized_keys",      
       "sudo nmcli con mod 'System ${var.vsphere_interface_name}' ipv4.method manual ipv4.addresses 172.26.83.1/24 ipv4.gateway 172.26.83.254 connection.autoconnect yes",
       "sudo nmcli con mod 'System ${var.vsphere_interface_name}' con-name ${var.vsphere_interface_name}",
       "sudo nmcli con up ${var.vsphere_interface_name}",
       "sudo dnf -y remove cloud-init"      
    ]
    connection {
       type = "ssh"
       user = "localadmin"
       password = var.vm_password
       host = "vsl-tst-axw-001"
    }
  }

  provisioner "local-exec" {
    command = " ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i 'vsl-tst-axw-001,' -e env=DEV_TEST config.yml -u ${var.vm_user} -b --vault-password-file /opt/infrastructure-linux/vault/.vault_password_file"
  }

}
# END ANSIBLE MANAGED BLOCK VSL-TST-AXW-001 (DMZ)

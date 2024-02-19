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

data "nutanix_cluster" "pe_lu651" {
  name     = "LU651"
  provider = nutanix.dc3
}

data "nutanix_image" "rhel8-dc3" {
  image_name = "RHEL8STD-latest"
  provider   = nutanix.dc3
}

provider "nutanix" {
  username = var.nutanix_username
  password = var.nutanix_password
  endpoint = "lu652"
  insecure = true
  alias    = "dc1"
}

data "nutanix_cluster" "pe_lu650" {
  name     = "LU650"
  provider = nutanix.dc1
}

data "nutanix_image" "rhel8-dc1" {
  image_name = "RHEL8STD-latest"
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

data "vsphere_network" "PRO_SAP_ROUTER_EXT" {
  name = "PRO_SAP_ROUTER_EXT"
  datacenter_id = data.vsphere_datacenter.esx_dc.id
}

data "vsphere_network" "DMZ_EXT_Oracle_Mgmt" {
  name = "DMZ_EXT_Oracle_Mgmt"
  datacenter_id = data.vsphere_datacenter.esx_dc.id
}


data "vsphere_network" "PRO_ANALYTICS_EXT" {
  name = "PRO_ANALYTICS_EXT"
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
  name = "RHEL8STD-latest"
  type = "ovf"
  library_id = data.vsphere_content_library.esx_lib1.id 
}

data "vsphere_content_library_item" "esx_lib2_item" {
  name = "RHEL8STD-latest"
  type = "ovf"
  library_id = data.vsphere_content_library.esx_lib2.id 
}
# BEGIN ANSIBLE MANAGED BLOCK RH-TESTSERVER-JH
resource "nutanix_virtual_machine" "RH-TESTSERVER-JH" {
        name                 = "RH-TESTSERVER-JH"
        description          = "TEST" 
        provider             = nutanix.dc3
        cluster_uuid         = data.nutanix_cluster.pe_lu651.metadata.uuid
        num_vcpus_per_socket = "1"
        num_sockets          = "2"
        memory_size_mib      = "2048"
        boot_type            = "UEFI"
        nic_list {
          subnet_uuid = var.ahv_651_network["VLAN-128-Server"]
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
          disk_size_mib = (20 * 1024)
          storage_config {
            storage_container_reference {
              kind = "storage_container"
              uuid = var.ahv_651_storage["NUT_AHV_DC3_01"]
            }
          }
        }

        guest_customization_cloud_init_user_data = base64encode(templatefile("user-data.yaml", {
          vm_domain         =  var.vm_domain 
          vm_name       =  "rh-testserver-jh"
          vm_ip   = "192.168.128.98"
          vm_prefix = "24"
          vm_gateway   =  "192.168.128.1"
          vm_dns1    = var.vm_dns1
          vm_dns2    = var.vm_dns2
          vm_user = var.vm_user
          vm_public_key = var.public_key
        }))

        provisioner "local-exec" {
        command = " ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i 'rh-testserver-jh,' -e env=DEV_TEST config.yml -u ${var.vm_user} -b --vault-password-file /opt/infrastructure/linux/vault/.vault_password_file" 
        }
 }
# END ANSIBLE MANAGED BLOCK RH-TESTSERVER-JH
# BEGIN ANSIBLE MANAGED BLOCK VSL-DEV-RPI-001
resource "nutanix_virtual_machine" "VSL-DEV-RPI-001" {
        name                 = "VSL-DEV-RPI-001"
        description          = "VSL-DEV-RPI-001" 
        provider             = nutanix.dc3
        cluster_uuid         = data.nutanix_cluster.pe_lu651.metadata.uuid
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

        guest_customization_cloud_init_user_data = base64encode(templatefile("user-data.yaml", {
          vm_domain         =  var.vm_domain 
          vm_name       =  "vsl-dev-rpi-001"
          vm_ip   = "192.168.42.174"
          vm_prefix = "24"
          vm_gateway   =  "192.168.42.1"
          vm_dns1    = var.vm_dns1
          vm_dns2    = var.vm_dns2
          vm_user = var.vm_user
          vm_public_key = var.public_key
        }))

        provisioner "local-exec" {
        command = " ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i 'vsl-dev-rpi-001,' -e env=DEV_TEST config.yml -u ${var.vm_user} -b --vault-password-file /opt/infrastructure/linux/vault/.vault_password_file" 
        }
 }
# END ANSIBLE MANAGED BLOCK VSL-DEV-RPI-001
# BEGIN ANSIBLE MANAGED BLOCK VSL-DEV-ATQ-001
resource "nutanix_virtual_machine" "VSL-DEV-ATQ-001" {
        name                 = "VSL-DEV-ATQ-001"
        description          = "VSL-DEV-ATQ-001" 
        provider             = nutanix.dc3
        cluster_uuid         = data.nutanix_cluster.pe_lu651.metadata.uuid
        num_vcpus_per_socket = "1"
        num_sockets          = "4"
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

        guest_customization_cloud_init_user_data = base64encode(templatefile("user-data.yaml", {
          vm_domain         =  var.vm_domain 
          vm_name       =  "vsl-dev-atq-001"
          vm_ip   = "192.168.42.175"
          vm_prefix = "24"
          vm_gateway   =  "192.168.42.1"
          vm_dns1    = var.vm_dns1
          vm_dns2    = var.vm_dns2
          vm_user = var.vm_user
          vm_public_key = var.public_key
        }))

        provisioner "local-exec" {
        command = " ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i 'vsl-dev-atq-001,' -e env=DEV_TEST config.yml -u ${var.vm_user} -b --vault-password-file /opt/infrastructure/linux/vault/.vault_password_file" 
        }
 }
# END ANSIBLE MANAGED BLOCK VSL-DEV-ATQ-001
# BEGIN ANSIBLE MANAGED BLOCK VSL-DEV-ALT-001
resource "nutanix_virtual_machine" "VSL-DEV-ALT-001" {
        name                 = "VSL-DEV-ALT-001"
        description          = "VSL-DEV-ALT-001" 
        provider             = nutanix.dc3
        cluster_uuid         = data.nutanix_cluster.pe_lu651.metadata.uuid
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

        guest_customization_cloud_init_user_data = base64encode(templatefile("user-data.yaml", {
          vm_domain         =  var.vm_domain 
          vm_name       =  "vsl-dev-alt-001"
          vm_ip   = "192.168.42.176"
          vm_prefix = "24"
          vm_gateway   =  "192.168.42.1"
          vm_dns1    = var.vm_dns1
          vm_dns2    = var.vm_dns2
          vm_user = var.vm_user
          vm_public_key = var.public_key
        }))

        provisioner "local-exec" {
        command = " ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i 'vsl-dev-alt-001,' -e env=DEV_TEST config.yml -u ${var.vm_user} -b --vault-password-file /opt/infrastructure/linux/vault/.vault_password_file" 
        }
 }
# END ANSIBLE MANAGED BLOCK VSL-DEV-ALT-001
# BEGIN ANSIBLE MANAGED BLOCK VSL-DEV-ALN-001
resource "nutanix_virtual_machine" "VSL-DEV-ALN-001" {
        name                 = "VSL-DEV-ALN-001"
        description          = "VSL-DEV-ALN-001" 
        provider             = nutanix.dc3
        cluster_uuid         = data.nutanix_cluster.pe_lu651.metadata.uuid
        num_vcpus_per_socket = "1"
        num_sockets          = "4"
        memory_size_mib      = "8192"
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

        guest_customization_cloud_init_user_data = base64encode(templatefile("user-data.yaml", {
          vm_domain         =  var.vm_domain 
          vm_name       =  "vsl-dev-aln-001"
          vm_ip   = "192.168.42.177"
          vm_prefix = "24"
          vm_gateway   =  "192.168.42.1"
          vm_dns1    = var.vm_dns1
          vm_dns2    = var.vm_dns2
          vm_user = var.vm_user
          vm_public_key = var.public_key
        }))

        provisioner "local-exec" {
        command = " ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i 'vsl-dev-aln-001,' -e env=DEV_TEST config.yml -u ${var.vm_user} -b --vault-password-file /opt/infrastructure/linux/vault/.vault_password_file" 
        }
 }
# END ANSIBLE MANAGED BLOCK VSL-DEV-ALN-001
# BEGIN ANSIBLE MANAGED BLOCK VSL-DEV-EPT-001
resource "nutanix_virtual_machine" "VSL-DEV-EPT-001" {
        name                 = "VSL-DEV-EPT-001"
        description          = "VSL-DEV-EPT-001" 
        provider             = nutanix.dc3
        cluster_uuid         = data.nutanix_cluster.pe_lu651.metadata.uuid
        num_vcpus_per_socket = "1"
        num_sockets          = "4"
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

        guest_customization_cloud_init_user_data = base64encode(templatefile("user-data.yaml", {
          vm_domain         =  var.vm_domain 
          vm_name       =  "vsl-dev-ept-001"
          vm_ip   = "192.168.42.178"
          vm_prefix = "24"
          vm_gateway   =  "192.168.42.1"
          vm_dns1    = var.vm_dns1
          vm_dns2    = var.vm_dns2
          vm_user = var.vm_user
          vm_public_key = var.public_key
        }))

        provisioner "local-exec" {
        command = " ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i 'vsl-dev-ept-001,' -e env=DEV_TEST config.yml -u ${var.vm_user} -b --vault-password-file /opt/infrastructure/linux/vault/.vault_password_file" 
        }
 }
# END ANSIBLE MANAGED BLOCK VSL-DEV-EPT-001
# BEGIN ANSIBLE MANAGED BLOCK LU686 (DMZ)
resource "vsphere_virtual_machine" "LU686" {
  resource_pool_id     = data.vsphere_resource_pool.esx_pool.id
  host_system_id       = data.vsphere_host.nut-dmz-04.id 
  datastore_id         = data.vsphere_datastore.NUT_DMZ_INT_DC2_01.id 
  firmware             = "efi"
  name                 = "LU686" 
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
      host_name = "lu686"
      domain    = var.vm_domain
      }
    
    # Nécessaire malgré la config nmcli via le prov remote-exec car justement remote-exec a besoin d'une IP pour se connecter  
      network_interface {
        ipv4_address = cidrhost("172.22.160.0/24","2") 
        ipv4_netmask = "24"
      }
      ipv4_gateway = cidrhost("172.22.160.0/24","1")
      dns_server_list = [var.vm_dns1,var.vm_dns2]
    }
  }        
  network_interface {
    network_id = data.vsphere_network.DMZ_PRO_INT_RHEL_MGMT.id
  }

  provisioner "file" {
    source = var.public_key_path
    destination = "/tmp/authorized_keys"
    connection {
      type = "ssh"
      user = var.vm_user
      password = var.vm_password
      host = "lu686"
    }
  }  

  provisioner "remote-exec" {
    inline = [
      "mkdir /home/localadmin/.ssh",
       "chmod 0700 /home/localadmin/.ssh",
       "mv /tmp/authorized_keys /home/localadmin/.ssh/",
       "chmod 0600 /home/localadmin/.ssh/authorized_keys",      
       "sudo nmcli con mod 'System ${var.vsphere_interface_name}' ipv4.method manual ipv4.addresses 172.22.160.2/24 ipv4.gateway 172.22.160.1 connection.autoconnect yes",
       "sudo nmcli con mod 'System ${var.vsphere_interface_name}' con-name ${var.vsphere_interface_name}",
       "sudo nmcli con up ${var.vsphere_interface_name}",
       "sudo dnf -y remove cloud-init"      
    ]
    connection {
       type = "ssh"
       user = "localadmin"
       password = var.vm_password
       host = "lu686"
    }
  }

  provisioner "local-exec" {
    command = " ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i 'lu686,' -e env=DEV_TEST config.yml -u ${var.vm_user} -b --vault-password-file /opt/infrastructure/linux/vault/.vault_password_file"
  }

}
# END ANSIBLE MANAGED BLOCK LU686 (DMZ)
# BEGIN ANSIBLE MANAGED BLOCK VSL-PRO-ATQ-001_BKP_D_PRO (DMZ)
resource "vsphere_virtual_machine" "VSL-PRO-ATQ-001_BKP_D_PRO" {
  resource_pool_id     = data.vsphere_resource_pool.esx_pool.id
  host_system_id       = data.vsphere_host.nut-dmz-04.id 
  datastore_id         = data.vsphere_datastore.NUT_DMZ_INT_DC2_to_DC1.id 
  firmware             = "efi"
  name                 = "VSL-PRO-ATQ-001_BKP_D_PRO" 
  folder               = "/DMZ/Tinqin/Servers"
  num_cpus             = "4"
  memory               = "24576"
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
      host_name = "vsl-pro-atq-001"
      domain    = var.vm_domain
      }
    
    # Nécessaire malgré la config nmcli via le prov remote-exec car justement remote-exec a besoin d'une IP pour se connecter  
      network_interface {
        ipv4_address = cidrhost("172.22.148.0/24","8") 
        ipv4_netmask = "24"
      }
      ipv4_gateway = cidrhost("172.22.148.0/24","1")
      dns_server_list = [var.vm_dns1,var.vm_dns2]
    }
  }        
  network_interface {
    network_id = data.vsphere_network.DMZ_PRO_APPMOBIL.id
  }

  provisioner "file" {
    source = var.public_key_path
    destination = "/tmp/authorized_keys"
    connection {
      type = "ssh"
      user = var.vm_user
      password = var.vm_password
      host = "vsl-pro-atq-001"
    }
  }  

  provisioner "remote-exec" {
    inline = [
      "mkdir /home/localadmin/.ssh",
       "chmod 0700 /home/localadmin/.ssh",
       "mv /tmp/authorized_keys /home/localadmin/.ssh/",
       "chmod 0600 /home/localadmin/.ssh/authorized_keys",      
       "sudo nmcli con mod 'System ${var.vsphere_interface_name}' ipv4.method manual ipv4.addresses 172.22.148.8 /24 ipv4.gateway 172.22.148.1  connection.autoconnect yes",
       "sudo nmcli con mod 'System ${var.vsphere_interface_name}' con-name ${var.vsphere_interface_name}",
       "sudo nmcli con up ${var.vsphere_interface_name}",
       "sudo dnf -y remove cloud-init"      
    ]
    connection {
       type = "ssh"
       user = "localadmin"
       password = var.vm_password
       host = "vsl-pro-atq-001"
    }
  }

  provisioner "local-exec" {
    command = " ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i 'vsl-pro-atq-001,' -e env=DEV_TEST config.yml -u ${var.vm_user} -b --vault-password-file /opt/infrastructure/linux/vault/.vault_password_file"
  }

}
# END ANSIBLE MANAGED BLOCK VSL-PRO-ATQ-001_BKP_D_PRO (DMZ)

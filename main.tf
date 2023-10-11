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

# BEGIN ANSIBLE MANAGED BLOCK VSL-DEV-APT-001
resource "nutanix_virtual_machine" "VSL-DEV-APT-001" {
        name                 = "VSL-DEV-APT-001"
        description          = "VSL-DEV-APT-001" 
        provider             = nutanix.dc3
        cluster_uuid         = data.nutanix_cluster.pe_lu651.metadata.uuid
        num_vcpus_per_socket = "1"
        num_sockets          = "4"
        memory_size_mib      = "20480"
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
          disk_size_mib = (50 * 1024)
          storage_config {
            storage_container_reference {
              kind = "storage_container"
              uuid = var.ahv_651_storage["NUT_AHV_DC3_01"]
            }
          }
        }

        guest_customization_cloud_init_user_data = base64encode(templatefile("user-data.yaml", {
          vm_domain         =  var.vm_domain 
          vm_name       =  "vsl-dev-apt-001"
          vm_ip   = "192.168.25.138"
          vm_prefix = "24"
          vm_gateway   =  "192.168.25.1"
          vm_dns1    = var.vm_dns1
          vm_dns2    = var.vm_dns2
          vm_user = var.vm_user
          vm_public_key = var.public_key
        }))

        provisioner "local-exec" {
        command = " ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i 'vsl-dev-apt-001,' -e env=DEV_TEST config.yml -u ${var.vm_user} -b --vault-password-file /opt/infrastructure/linux/vault/.vault_password_file" 
        }
 }
# END ANSIBLE MANAGED BLOCK VSL-DEV-APT-001
# BEGIN ANSIBLE MANAGED BLOCK VSL-DEV-ABN-001
resource "nutanix_virtual_machine" "VSL-DEV-ABN-001" {
        name                 = "VSL-DEV-ABN-001"
        description          = "VSL-DEV-ABN-001" 
        provider             = nutanix.dc3
        cluster_uuid         = data.nutanix_cluster.pe_lu651.metadata.uuid
        num_vcpus_per_socket = "1"
        num_sockets          = "4"
        memory_size_mib      = "16384"
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
          disk_size_mib = (50 * 1024)
          storage_config {
            storage_container_reference {
              kind = "storage_container"
              uuid = var.ahv_651_storage["NUT_AHV_DC3_01"]
            }
          }
        }

        guest_customization_cloud_init_user_data = base64encode(templatefile("user-data.yaml", {
          vm_domain         =  var.vm_domain 
          vm_name       =  "vsl-dev-abn-001"
          vm_ip   = "192.168.25.144"
          vm_prefix = "24"
          vm_gateway   =  "192.168.25.1"
          vm_dns1    = var.vm_dns1
          vm_dns2    = var.vm_dns2
          vm_user = var.vm_user
          vm_public_key = var.public_key
        }))

        provisioner "local-exec" {
        command = " ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i 'vsl-dev-abn-001,' -e env=DEV_TEST config.yml -u ${var.vm_user} -b --vault-password-file /opt/infrastructure/linux/vault/.vault_password_file" 
        }
 }
# END ANSIBLE MANAGED BLOCK VSL-DEV-ABN-001
# BEGIN ANSIBLE MANAGED BLOCK VSL-DEV-ABV-001
resource "nutanix_virtual_machine" "VSL-DEV-ABV-001" {
        name                 = "VSL-DEV-ABV-001"
        description          = "VSL-DEV-ABV-001" 
        provider             = nutanix.dc3
        cluster_uuid         = data.nutanix_cluster.pe_lu651.metadata.uuid
        num_vcpus_per_socket = "1"
        num_sockets          = "2"
        memory_size_mib      = "4096"
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
          disk_size_mib = (50 * 1024)
          storage_config {
            storage_container_reference {
              kind = "storage_container"
              uuid = var.ahv_651_storage["NUT_AHV_DC3_01"]
            }
          }
        }

        guest_customization_cloud_init_user_data = base64encode(templatefile("user-data.yaml", {
          vm_domain         =  var.vm_domain 
          vm_name       =  "vsl-dev-abv-001"
          vm_ip   = "192.168.25.150"
          vm_prefix = "24"
          vm_gateway   =  "192.168.25.1"
          vm_dns1    = var.vm_dns1
          vm_dns2    = var.vm_dns2
          vm_user = var.vm_user
          vm_public_key = var.public_key
        }))

        provisioner "local-exec" {
        command = " ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i 'vsl-dev-abv-001,' -e env=DEV_TEST config.yml -u ${var.vm_user} -b --vault-password-file /opt/infrastructure/linux/vault/.vault_password_file" 
        }
 }
# END ANSIBLE MANAGED BLOCK VSL-DEV-ABV-001
# BEGIN ANSIBLE MANAGED BLOCK VSL-DEV-ABD-001
resource "nutanix_virtual_machine" "VSL-DEV-ABD-001" {
        name                 = "VSL-DEV-ABD-001"
        description          = "VSL-DEV-ABD-001" 
        provider             = nutanix.dc3
        cluster_uuid         = data.nutanix_cluster.pe_lu651.metadata.uuid
        num_vcpus_per_socket = "1"
        num_sockets          = "2"
        memory_size_mib      = "8192"
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
          disk_size_mib = (50 * 1024)
          storage_config {
            storage_container_reference {
              kind = "storage_container"
              uuid = var.ahv_651_storage["NUT_AHV_DC3_01"]
            }
          }
        }

        guest_customization_cloud_init_user_data = base64encode(templatefile("user-data.yaml", {
          vm_domain         =  var.vm_domain 
          vm_name       =  "vsl-dev-abd-001"
          vm_ip   = "192.168.25.151"
          vm_prefix = "24"
          vm_gateway   =  "192.168.25.1"
          vm_dns1    = var.vm_dns1
          vm_dns2    = var.vm_dns2
          vm_user = var.vm_user
          vm_public_key = var.public_key
        }))

        provisioner "local-exec" {
        command = " ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i 'vsl-dev-abd-001,' -e env=DEV_TEST config.yml -u ${var.vm_user} -b --vault-password-file /opt/infrastructure/linux/vault/.vault_password_file" 
        }
 }
# END ANSIBLE MANAGED BLOCK VSL-DEV-ABD-001
# BEGIN ANSIBLE MANAGED BLOCK VSL-DEV-ABA-001
resource "nutanix_virtual_machine" "VSL-DEV-ABA-001" {
        name                 = "VSL-DEV-ABA-001"
        description          = "VSL-DEV-ABA-001" 
        provider             = nutanix.dc3
        cluster_uuid         = data.nutanix_cluster.pe_lu651.metadata.uuid
        num_vcpus_per_socket = "1"
        num_sockets          = "1"
        memory_size_mib      = "2048"
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
          disk_size_mib = (50 * 1024)
          storage_config {
            storage_container_reference {
              kind = "storage_container"
              uuid = var.ahv_651_storage["NUT_AHV_DC3_01"]
            }
          }
        }

        guest_customization_cloud_init_user_data = base64encode(templatefile("user-data.yaml", {
          vm_domain         =  var.vm_domain 
          vm_name       =  "vsl-dev-aba-001"
          vm_ip   = "192.168.25.152"
          vm_prefix = "24"
          vm_gateway   =  "192.168.25.1"
          vm_dns1    = var.vm_dns1
          vm_dns2    = var.vm_dns2
          vm_user = var.vm_user
          vm_public_key = var.public_key
        }))

        provisioner "local-exec" {
        command = " ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i 'vsl-dev-aba-001,' -e env=DEV_TEST config.yml -u ${var.vm_user} -b --vault-password-file /opt/infrastructure/linux/vault/.vault_password_file" 
        }
 }
# END ANSIBLE MANAGED BLOCK VSL-DEV-ABA-001
# BEGIN ANSIBLE MANAGED BLOCK VSL-DEV-MST-001
resource "nutanix_virtual_machine" "VSL-DEV-MST-001" {
        name                 = "VSL-DEV-MST-001"
        description          = "VSL-DEV-MST-001" 
        provider             = nutanix.dc3
        cluster_uuid         = data.nutanix_cluster.pe_lu651.metadata.uuid
        num_vcpus_per_socket = "1"
        num_sockets          = "4"
        memory_size_mib      = "20480"
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
          disk_size_mib = (50 * 1024)
          storage_config {
            storage_container_reference {
              kind = "storage_container"
              uuid = var.ahv_651_storage["NUT_AHV_DC3_01"]
            }
          }
        }

        guest_customization_cloud_init_user_data = base64encode(templatefile("user-data.yaml", {
          vm_domain         =  var.vm_domain 
          vm_name       =  "vsl-dev-mst-001"
          vm_ip   = "192.168.25.161"
          vm_prefix = "24"
          vm_gateway   =  "192.168.25.1"
          vm_dns1    = var.vm_dns1
          vm_dns2    = var.vm_dns2
          vm_user = var.vm_user
          vm_public_key = var.public_key
        }))

        provisioner "local-exec" {
        command = " ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i 'vsl-dev-mst-001,' -e env=DEV_TEST config.yml -u ${var.vm_user} -b --vault-password-file /opt/infrastructure/linux/vault/.vault_password_file" 
        }
 }
# END ANSIBLE MANAGED BLOCK VSL-DEV-MST-001
# BEGIN ANSIBLE MANAGED BLOCK VSL-DEV-MSN-001
resource "nutanix_virtual_machine" "VSL-DEV-MSN-001" {
        name                 = "VSL-DEV-MSN-001"
        description          = "VSL-DEV-MSN-001" 
        provider             = nutanix.dc3
        cluster_uuid         = data.nutanix_cluster.pe_lu651.metadata.uuid
        num_vcpus_per_socket = "1"
        num_sockets          = "4"
        memory_size_mib      = "8192"
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
          disk_size_mib = (50 * 1024)
          storage_config {
            storage_container_reference {
              kind = "storage_container"
              uuid = var.ahv_651_storage["NUT_AHV_DC3_01"]
            }
          }
        }

        guest_customization_cloud_init_user_data = base64encode(templatefile("user-data.yaml", {
          vm_domain         =  var.vm_domain 
          vm_name       =  "vsl-dev-msn-001"
          vm_ip   = "192.168.25.188"
          vm_prefix = "24"
          vm_gateway   =  "192.168.25.1"
          vm_dns1    = var.vm_dns1
          vm_dns2    = var.vm_dns2
          vm_user = var.vm_user
          vm_public_key = var.public_key
        }))

        provisioner "local-exec" {
        command = " ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i 'vsl-dev-msn-001,' -e env=DEV_TEST config.yml -u ${var.vm_user} -b --vault-password-file /opt/infrastructure/linux/vault/.vault_password_file" 
        }
 }
# END ANSIBLE MANAGED BLOCK VSL-DEV-MSN-001
# BEGIN ANSIBLE MANAGED BLOCK VSL-DEV-MSV-001
resource "nutanix_virtual_machine" "VSL-DEV-MSV-001" {
        name                 = "VSL-DEV-MSV-001"
        description          = "VSL-DEV-MSV-001" 
        provider             = nutanix.dc3
        cluster_uuid         = data.nutanix_cluster.pe_lu651.metadata.uuid
        num_vcpus_per_socket = "1"
        num_sockets          = "2"
        memory_size_mib      = "4096"
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
          disk_size_mib = (50 * 1024)
          storage_config {
            storage_container_reference {
              kind = "storage_container"
              uuid = var.ahv_651_storage["NUT_AHV_DC3_01"]
            }
          }
        }

        guest_customization_cloud_init_user_data = base64encode(templatefile("user-data.yaml", {
          vm_domain         =  var.vm_domain 
          vm_name       =  "vsl-dev-msv-001"
          vm_ip   = "192.168.25.189"
          vm_prefix = "24"
          vm_gateway   =  "192.168.25.1"
          vm_dns1    = var.vm_dns1
          vm_dns2    = var.vm_dns2
          vm_user = var.vm_user
          vm_public_key = var.public_key
        }))

        provisioner "local-exec" {
        command = " ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i 'vsl-dev-msv-001,' -e env=DEV_TEST config.yml -u ${var.vm_user} -b --vault-password-file /opt/infrastructure/linux/vault/.vault_password_file" 
        }
 }
# END ANSIBLE MANAGED BLOCK VSL-DEV-MSV-001

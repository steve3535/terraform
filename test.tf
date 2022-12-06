terraform {
  required_providers {
    nutanix = {
      source  = "nutanix/nutanix"
    }
  }
}

provider "nutanix" {
 username = var.nutanix_username
 password = var.nutanix_password
 endpoint = "lu652"
 insecure = true
}

resource "nutanix_virtual_machine" "packer_vm" {
 name = "packer"
 description = "Created with Terraform"
 provider = nutanix
 boot_type = "UEFI"
 cluster_uuid = "000573dc-b47b-b6bf-0000-00000001c0f6"
  num_vcpus_per_socket = 1
  num_sockets = 1
  memory_size_mib = 2048
  
  nic_list {
     subnet_uuid = "1f9df7d0-c227-49ea-8ac7-40073dd46e0e"
   }

  disk_list {
   data_source_reference = {
   kind = "image"
   uuid = "a07a2099-9a0a-4ef7-b4e4-9674775877eb"
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
  # defining an additional entry in the disk_list array will create another.
  #disk_size_mib and disk_size_bytes must be set together.
  disk_size_mib   = 100000
  disk_size_bytes = 104857600000
   }
}  
  
output "ip_address" {
  value = nutanix_virtual_machine.MyTestVM_TF.nic_list_status.0.ip_endpoint_list[0]["ip"]
}

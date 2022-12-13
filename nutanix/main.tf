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

data "nutanix_cluster" "cluster480" {
    name = "LU480"
}

data "nutanix_cluster" "cluster650" {
    name = "LU650"
}

data "nutanix_image" "rhel8" {
    image_name = "RHEL8"
}

data "template_file" "cloud-init" {
    template = file("user-data.yml")
    vars = {
        vm_user = var.vm_user
        vm_name = var.vm_name
        vm_ip = var.vm_ip
        vm_domain = var.vm_domain
        vm_netmask = var.vm_ipv4_net_prefix
        vm_gateway = var.vm_gateway
        vm_dns1 = var.vm_dns1
        vm_dns2 = var.vm_dns2
        vm_public_key = var.vm_public_key
        vm_satellite_env = var.vm_satellite_env
    }
}

resource "random_string" "random" {
length= 18
}
resource "nutanix_virtual_machine" "packer_vm" {
 name = "LU783 - LNX - IBM TASK MINING POC"
 description = "Created with Terraform"
 provider = nutanix
 boot_type = "UEFI"
 cluster_uuid = data.nutanix_cluster.cluster480.metadata.uuid #"000573dc-b47b-b6bf-0000-00000001c0f6"
  num_vcpus_per_socket = 1
  num_sockets = var.vm_cpu
  memory_size_mib = var.vm_ram
  
  nic_list {
     subnet_uuid = "1f9df7d0-c227-49ea-8ac7-40073dd46e0e"  #200.1.1.
     #subnet_uuid = "e261a1ee-cc02-48ff-9292-92287a9c95ec"   #192.168.25
   }

  disk_list {
   data_source_reference = {
   kind = "image"
   uuid = data.nutanix_image.rhel8.metadata.uuid
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
  #defining an additional entry in the disk_list array will create another.
  #disk_size_mib and disk_size_bytes must be set together.
  disk_size_mib   = (var.vm_disk_size_gb * 1024)
  #disk_size_bytes = (var.vm_disk_size_gb * 1024 * 1024)  #104857600000
   }

  guest_customization_cloud_init_user_data = base64encode(data.template_file.cloud-init.rendered)
  #base64encode(data.template_file.cloud-init.rendered)
  #file("./user-data.yml") 
  
  provisioner "local-exec" {
    command = " ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i '${data.template_file.cloud-init.vars.vm_name},' -e env=${data.template_file.cloud-init.vars.vm_satellite_env} deploy.yml -u localadmin -b --vault-password-file /home/lalux.local/mk417/infrastructure-linux/ansible_vault/.vault_password_file"
              
  }

  
}  
  
# output "ip_address" {
#   #value = nutanix_virtual_machine.packer_vm.nic_list_status.0.ip_endpoint_list[0]["ip"]
#    value = data.template_file.cloud-init.vars.vm_ip
# }

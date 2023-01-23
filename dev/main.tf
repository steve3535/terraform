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
}

data "vsphere_datacenter" "vmw_dc" {
  name = var.vsphere_datacenter
}

data "vsphere_datastore" "vmw_ds" {
  name = var.vsphere_datastore
  datacenter_id = data.vsphere_datacenter.vmw_dc.id
}

data "vsphere_compute_cluster" "vmw_clus" {
  name = var.vsphere_cluster
  datacenter_id = data.vsphere_datacenter.vmw_dc.id
}

data "vsphere_host" "vmw_host" {
  name = var.vsphere_host
  datacenter_id = data.vsphere_datacenter.vmw_dc.id
}

data "vsphere_network" "vmw_net" {
  name = var.vsphere_network
  datacenter_id = data.vsphere_datacenter.vmw_dc.id
}

data "vsphere_content_library" "vmw_lib" {
  name = var.vsphere_content_library
}

data "vsphere_resource_pool" "vmw_pool" {
  name = var.vsphere_resource_pool
  datacenter_id = data.vsphere_datacenter.vmw_dc.id
}

data "vsphere_content_library_item" "vmw_lib_item" {
  name = var.vsphere_content_library_item
  type = "ovf"
  library_id = data.vsphere_content_library.vmw_lib.id 
}

data "template_file" "cloud-init" {
  template = file("user-data.yml")
  vars = {
    vm_user          = var.vm_user
    vm_name          = var.vm_name
    vm_ip            = var.vm_ip
    vm_domain        = var.vm_domain
    vm_netmask       = var.vm_ipv4_net_prefix
    vm_gateway       = var.vm_gateway
    vm_dns1          = var.vm_dns1
    vm_dns2          = var.vm_dns2
    vm_public_key    = var.vm_public_key
    vm_satellite_env = var.vm_satellite_env
  }
}


resource "nutanix_virtual_machine" "LU718" {
  name                 = "LU718 - LNX - KWAKOU VM TEST"
  description          = "VM de TEST"
  provider             = nutanix.dc1
  boot_type            = "UEFI"
  cluster_uuid         = data.nutanix_cluster.cluster650.metadata.uuid
  num_vcpus_per_socket = var.vm_num_vcpus_per_socket
  num_sockets          = var.vm_cpu
  memory_size_mib      = var.vm_ram

  nic_list {
    #subnet_uuid = "5e33cdaf-d482-4353-b2b0-a74cbff387c8" #200.1.1. Production sur LU651
    subnet_uuid = "0cd904d5-187c-4701-ad94-12bda719dcac"    #200.1.1. Production sur LU650
    #subnet_uuid = "e261a1ee-cc02-48ff-9292-92287a9c95ec"    #192.168.25
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
    #defining an additional entry in the disk_list array will create another.
    disk_size_mib = (var.vm_disk_size_gb * 1024)
    # disk_size_bytes = (var.vm_disk_size_gb * 1024 * 1024)


    storage_config {
      storage_container_reference {
        kind = "storage_container"
        #uuid = "bc8f3bc4-900a-4458-aadd-85f557f5bcd2" # NUT-AHV-DC3-01
        uuid = "68f3f950-143e-41a9-87fa-6806dfaacaa8" # NUT-AHV-DC1-01
      }
    }
  }


  guest_customization_cloud_init_user_data = base64encode(data.template_file.cloud-init.rendered)

  provisioner "local-exec" {
    command = " ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i '${data.template_file.cloud-init.vars.vm_name},' -e env=${data.template_file.cloud-init.vars.vm_satellite_env} deploy.yml -u localadmin -b --vault-password-file /home/lalux.local/mk417/infrastructure-linux/vault/.vault_password_file"

  }

}


# Deploy a VM from OVF in Content Library in VMWARE
resource "vsphere_virtual_machine" "TEST-LNX" {
  name                 = var.vsphere_machine_name
  host_system_id       = data.vsphere_host.vmw_host.id
  datastore_id         = data.vsphere_datastore.vmw_ds.id
  resource_pool_id     = data.vsphere_resource_pool.vmw_pool.id
  folder               = var.vsphere_folder
  firmware             = "efi"
  num_cpus             = var.vsphere_num_cpus
  memory               = var.vsphere_memory
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
    template_uuid = data.vsphere_content_library_item.vmw_lib_item.id
    customize {
      linux_options {
        host_name = var.vsphere_vm_name
        domain    = "lalux.local"
      }
      # Nécessaire malgré la config nmcli via le prov remote-exec car justement remote-exec a besoin d'une IP pour se connecter  
      network_interface {
        ipv4_address = cidrhost(var.vsphere_subnet,20) #fixed IP address .20
        ipv4_netmask = 24
        
      }
      ipv4_gateway = cidrhost(var.vsphere_subnet,1)
      dns_server_list = ["200.1.1.163","200.1.1.218"]
    }
  }

  network_interface {
    network_id = data.vsphere_network.vmw_net.id
  }

  provisioner "file" {
    source = "/home/lalux.local/mk417/.ssh/id_rsa.pub"
    destination = "/tmp/authorized_keys"
    connection {
      type = "ssh"
      user = "localadmin"
      password = var.vm_password
      host = var.vsphere_vm_name
    }
  }

  provisioner "remote-exec" {
    inline = [
      "mkdir /home/localadmin/.ssh",
      "chmod 0700 /home/localadmin/.ssh",
      "mv /tmp/authorized_keys /home/localadmin/.ssh/",
      "chmod 0600 /home/localadmin/.ssh/authorized_keys",      
      "sudo nmcli con mod 'System ${var.vsphere_interface_name}' ipv4.method manual ipv4.addresses ${var.vsphere_vm_ip}/24 ipv4.gateway ${var.vsphere_vm_gateway} connection.autoconnect yes",
      "sudo nmcli con mod 'System ${var.vsphere_interface_name}' con-name ${var.vsphere_interface_name}",
      "sudo nmcli con up ${var.vsphere_interface_name}",
      "sudo dnf -y remove cloud-init"      
    ]
    connection {
      type = "ssh"
      user = "localadmin"
      password = var.vm_password
      host = var.vsphere_vm_name
    }
    
  }
  
  provisioner "local-exec" {
    command = " ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i '${var.vsphere_vm_name},' -e env=${var.vsphere_vm_satellite_env} deploy.yml -u localadmin -b --vault-password-file /home/lalux.local/mk417/infrastructure-linux/vault/.vault_password_file"
  }

}

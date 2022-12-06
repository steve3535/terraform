provider "vsphere" {
  vsphere_server = var.vsphere_server
  user           = var.vsphere_user
  password       = var.vsphere_password

  #If you have a self-signed cert
  allow_unverified_ssl = true
}

data "vsphere_datacenter" "dc" {
  name = var.data_center
}

data "vsphere_compute_cluster" "cluster" {
  name = var.cluster
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_host" "host" {
  name = var.host
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_datastore" "datastore" {
  name = var.datastore
  datacenter_id = data.vsphere_datacenter.dc.id
  
}

data "vsphere_resource_pool" "pool" {
  name          = "Cluster NUTANIX DMZ/Resources"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}

data "vsphere_network" "network" {
  name = var.network
  datacenter_id = data.vsphere_datacenter.dc.id
}

#Data source for vCenter Content Library
data "vsphere_content_library" "content_library" {
  name = "Linux_Templates_DC2"
}

#Data source for vCenter Content Library Item
data "vsphere_content_library_item" "ovf_item" {
  name       = "RHEL8STD"
  type       = "ovf"
  library_id = data.vsphere_content_library.content_library.id
}


# Deploy a VM from OVF in Content Library
resource "vsphere_virtual_machine" "vm_from_ovf" {
  name                 = "VM Test - mk417"
  datastore_id         = data.vsphere_datastore.datastore.id
  resource_pool_id     = data.vsphere_resource_pool.pool.id
  folder               = "/DMZ/DEV"
  firmware             = "efi"
  wait_for_guest_net_timeout = 5
  
  disk {
    label            = "disk0"
    size             = 100
    controller_type  = "scsi"
  }

  clone {
    template_uuid = data.vsphere_content_library_item.ovf_item.id
    customize {
      linux_options {
        host_name = "vm-test-mk417"
        domain    = "lalux.local"
      }
      network_interface {
        ipv4_address = cidrhost(var.subnet,200) #fixed IP address .200
        ipv4_netmask = 24
      }
      ipv4_gateway = cidrhost(var.subnet,240)
    }
  }

  network_interface {
    network_id = data.vsphere_network.network.id
  }
}

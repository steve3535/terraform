################################
## CREDENTIALS
################################

variable "nutanix_username" {}
variable "nutanix_password" { 
    type=string 
    sensitive = true 
    }
variable "vsphere_user" {}
variable "vsphere_password" { sensitive = true }

################################
# ESX COMMON INFRASTRUCTURE
################################

variable "vsphere_server" { default = "lu309.lalux.local" }
variable "vsphere_datacenter" { default = "LALUX" }
variable "vsphere_cluster" { default = "Cluster NUTANIX DMZ" }
variable "vsphere_resource_pool" { default = "Cluster NUTANIX DMZ/Resources" }
variable "vsphere_content_library_item" { default = "RHEL8STD" }
variable "vsphere_interface_name" { default = "ens192" }


################################
# AHV COMMON INFRASTRUCTURE
################################
variable ahv_650_network {
    type = map(string)
    default = {"Production":"0cd904d5-187c-4701-ad94-12bda719dcac","VLAN_42":"0d5ca391-d483-473d-87bf-db324a3289be","New_PROD 192.168.25.x":"2b1ad12d-4426-460c-93f7-c1c5cc013928"}
}

variable ahv_650_storage {
    type = map(string)
    default = {"NUT_AHV_DC1_01":"68f3f950-143e-41a9-87fa-6806dfaacaa8","NUT_AHV_DC3_01":"8688a539-0fff-45ee-a621-1591234e89b5"}
}

variable ahv_651_network {
    type = map(string)
    default = {"Production":"5e33cdaf-d482-4353-b2b0-a74cbff387c8","VLAN_42":"bb352659-9eb7-498c-8116-f0efee2420a1","New_PROD 192.168.25.x":"6e600440-22fe-4127-afd2-7a17f60bd8dc","VLAN_26":"ecc99c8a-ddc1-422b-8cfb-b69057d570db"}
}

variable ahv_651_storage {
    type = map(string)
    default = {"NUT_AHV_DC3_01":"bc8f3bc4-900a-4458-aadd-85f557f5bcd2","NUT_AHV_DC1_01":"cc879b80-7e3a-40a9-ab85-5e7f59d20b40"}
}

variable "vm_user" { default = "localadmin" }
variable "public_key" {}
variable "public_key_path" {}
variable "vm_password" { default = "L@lux0123456789#" }
variable "vm_domain" { default = "lalux.local" }
variable "vm_dns1" { default = "200.1.1.163" }
variable "vm_dns2" { default = "200.1.1.218"} 


###################################
# ESX VIRTUAL MACHINES DEFINITION
###################################

variable dmz_vm {
    type = list(map(string))
     default = [ {"name": "mk417-esx-test1","cpu":1,"mem":1024,"network":"","subnet":"200.1.1.0/24","ip":"200.1.1.53","gw":"200.1.1.240","host":"nut-dmz-08.lalux.local","folder":"/DMZ/DEV","satellite_env":"DEV_TEST"}
                 
            ]
}

###################################
# AHV VIRTUAL MACHINES DEFINITION
###################################

variable lan_vm {
    type = list(map(string))
    default = [ {"name":"LU717 - LNX - KWAKOU VM TEST 01","description":"VM DE TEST","datacenter":"nutanix.dc1","hostname": "lu717","cpu_socket":"1","cpu":1,"mem":2048,"ip":"200.1.1.106","gw":"200.1.1.240","net_prefix":"24","disk2_size_gb":"100","satellite_env":"DEV_TEST"},
                {"name":"LU718 - LNX - KWAKOU VM TEST 02","description":"VM DE TEST","datacenter":"nutanix.dc3","hostname": "lu718","cpu_socket":"1","cpu":2,"mem":4096,"ip":"200.1.1.105","gw":"200.1.1.240","net_prefix":"24","disk2_size_gb":"100","satellite_env":"DEV_TEST"}
       ]
}




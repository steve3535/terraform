terraform {
  required_version = ">=1.3.0"
  required_providers {
    nutanix = {
      version = ">=1.7.0"
      source  = "nutanix/nutanix"
    }
    vsphere = {
    }
  }
}

#cloud-config
# Assign static IP address
write_files:
 - path: /etc/sysconfig/network-scripts/ifcfg-ens3
   content: |
     IPADDR="200.1.1.105"
     NETMASK="24"
     GATEWAY="200.1.1.240" 
     BOOTPROTO=static
     ONBOOT=yes
     DEVICE=ens3
# network:
#   version: 2
#   config:
#     - type: physical
#       name: eth0
#       subnets:
#         - type: static
#           address: ${vm_ip}/${vm_prefix}
#           gateway: ${vm_gateway}
# runcmd:
#   - nmcli con mod "System ens3" ipv4.method manual ipv4.addresses ${vm_ip}/${vm_prefix} ipv4.gateway ${vm_gateway} ipv4.dns "${vm_dns1} ${vm_dns2}"
#   - nmcli con mod "System ens3" con-name ens3  
#   - nmcli con up ens3

hostname: ${vm_name}
fqdn: ${vm_name}.${vm_domain}

users:
  - name: ${vm_user}
    ssh-authorized-keys:
      - ${vm_public_key}

chpasswd:
  ${vm_user}: L@lux0123456789#
#cloud-config
# Assign static IP address
# write_files:
#  - path: /etc/sysconfig/network-scripts/ifcfg-ens3
#    content: |
#      IPADDR="200.1.1.105"
#      NETMASK="24"
#      GATEWAY="200.1.1.240" 
#      BOOTPROTO=static
#      ONBOOT=yes
#      DEVICE=ens3
# network:
#   version: 2
#   config:
#     - type: physical
#       name: eth0
#       subnets:
#         - type: static
#           address: ${vm_ip}/${vm_prefix}
#           gateway: ${vm_gateway}

# Assign static IP address
runcmd:
   - nmcli connection migrate
   - nmcli con down "System ens3"
   - nmcli con del "System ens3"
   - nmcli con add con-name "System ens3" ifname ens3 type ethernet ip4 "200.1.1.105/24" gw4 "200.1.1.240" ipv4.dns "dns1 dns2"
   - nmcli con up "System ens3"
   - nmcli general reload
   - nmcli connection reload

hostname: ${vm_name}
fqdn: ${vm_name}.${vm_domain}

users:
  - name: ${vm_user}
    ssh-authorized-keys:
      - ${vm_public_key}

chpasswd:
  ${vm_user}: L@lux0123456789#
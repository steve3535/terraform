#cloud-config
runcmd:
   - nmcli con down "Wired connection 1"
   - nmcli con del "Wired connection 1"
   - nmcli con add connection.id ens3 ifname ens3 connection.type ethernet ipv4.method manual ipv4.addresses ${vm_ip}/${vm_prefix} ipv4.gateway ${vm_gateway} ipv4.dns "${vm_dns1} ${vm_dns2}"
   - nmcli con up ens3
  
hostname: ${vm_name}
fqdn: ${vm_name}.${vm_domain}

users:
  - name: ${vm_user}
    ssh-authorized-keys:
      - ${vm_public_key}

# chpasswd:
#   list: |
#     ${vm_user}: L@lux0123456789#
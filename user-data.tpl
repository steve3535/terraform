#cloud-config
bootcmd:
   - nmcli connection migrate
   - nmcli con down "System ens3"
   - nmcli con del "System ens3"
   - nmcli con add con-name ens3 ifname ens3 type ethernet ip4 ${vm_ip} gw4 ${vm_gateway} ipv4.dns "dns1 dns2"
   - nmcli con up ens3
  #  - nmcli general reload
  #  - nmcli connection reload

hostname: ${vm_name}
fqdn: ${vm_name}.${vm_domain}

users:
  - name: ${vm_user}
    ssh-authorized-keys:
      - ${vm_public_key}

# chpasswd:
#   list: |
#     ${vm_user}: L@lux0123456789#
excel_filename = "vmdefs.csv" 
yaml_filename = "params.yml"
ctr = 0 
lan_vms=[]
dmz_vms=[]
vm={}
with open(excel_filename,encoding="utf-8") as input_file:
    for line in input_file:
        if not(ctr) or line.startswith(','):
            ctr+=1
            continue
          
        domain,vm_nickname,vm_name,descr,hostname,datacenter,cluster,image,sub_cl,subnet,stg_cl,storage,mem,cpu,cpu_socket,disk2_size_gb,ip,net_prefix,gateway,satellite_env = line.split(',')
        vm[vm_nickname]={'vm_nickname':vm_nickname,'vm_name':vm_name.replace('\xa0',' '),'descr':descr.replace('\xa0',' '),'hostname':hostname,'datacenter':datacenter,'cluster':cluster,'image':image,'sub_cl':'',
                'subnet':subnet.strip('\"'),'stg_cl':'','storage':storage,'mem':int(float(mem)),'cpu':int(float(cpu)),'cpu_socket':int(float(cpu_socket)),'disk2_size_gb':int(float(disk2_size_gb)),'ip':ip,'net_prefix':int(float(net_prefix)),'gw':gateway,'satellite_env':satellite_env}
        if domain=="lan_vms":
            lan_vms.append(vm[vm_nickname])
        else:
            dmz_vms.append(vm[vm_nickname])
            
with open(yaml_filename,"w+") as output_file:
    output_file.write('lan_vms:  \n')
    for v in lan_vms:
        output_file.write(2*' '+v['vm_nickname']+":  \n")
        output_file.write(4*' '+'name: "'+v['vm_name']+'"  \n')
        output_file.write(4*' '+'descr: "'+v['descr']+'"  \n')
        output_file.write(4*' '+'hostname: "'+v['hostname']+'"  \n')
        output_file.write(4*" "+"datacenter: "+v['datacenter']+"  \n")
        output_file.write(4*" "+"image: "+v['image']+"  \n")
        output_file.write(4*" "+"cluster: "+v['cluster']+"  \n")
        output_file.write(4*' '+'subnet: '+v['subnet']+'  \n')
        output_file.write(4*" "+"storage: "+v['storage']+"  \n")
        output_file.write(4*" "+"mem: "+str(v['mem'])+"  \n")
        output_file.write(4*" "+"cpu: "+str(v['cpu'])+"  \n")
        output_file.write(4*" "+"cpu_socket: "+str(v['cpu_socket'])+"  \n")
        output_file.write(4*' '+'disk2_size_gb: "'+str(v['disk2_size_gb'])+'"  \n')
        output_file.write(4*' '+'ip: "'+v['ip']+'"  \n')
        output_file.write(4*' '+'net_prefix: "'+str(v['net_prefix'])+'"  \n')
        output_file.write(4*' '+'gw: "'+v['gw']+'"  \n')
        output_file.write(4*' '+'satellite_env: '+v['satellite_env']+'  \n')
    for  w in dmz_vms:
        vm_subnet = ".".join(w['ip'].split('.')[0:3])+".0/24"
        vm_ip_last_octet = w['ip'].split('.')[3]
        gw_ip_last_octet = w['gw'].split('.')[3]

        output_file.write(2*' '+w['vm_nickname']+":  \n")
        output_file.write(4*' '+'name: "'+w['vm_name']+'"  \n')
        #output_file.write(4*' '+'descr: "'+w['descr']+'"  \n')
        output_file.write(4*' '+'hostname: "'+w['hostname']+'"  \n')
        output_file.write(4*" "+"datacenter: "+w['datacenter']+"  \n")
        output_file.write(4*" "+"content_library_item: "+w['image']+"  \n")
        output_file.write(4*" "+"host: "+w['cluster']+"  \n")
        output_file.write(4*' '+'network: '+w['subnet']+'  \n')
        output_file.write(4*" "+"datastore: "+w['storage']+"  \n")
        output_file.write(4*" "+"mem: "+str(w['mem'])+"  \n")
        output_file.write(4*" "+"cpu: "+str(w['cpu'])+"  \n")
        output_file.write(4*" "+"cpu_socket: "+str(w['cpu_socket'])+"  \n")
        output_file.write(4*' '+'disk2_size_gb: "'+str(w['disk2_size_gb'])+'"  \n')
        output_file.write(4*' '+'ip: "'+w['ip']+'"  \n')
        output_file.write(4*' '+'net_prefix: "'+str(v['net_prefix'])+'"  \n')
        output_file.write(4*' '+'gw: "'+w['gw']+'"  \n')
        output_file.write(4*' '+'vm_ip_last_octet: '+vm_ip_last_octet+'  \n')
        output_file.write(4*' '+'gw_ip_last_octet: '+gw_ip_last_octet+'  \n')
        output_file.write(4*' '+'subnet: '+vm_subnet+'  \n')
        output_file.write(4*' '+'user: localadmin  \n')
        output_file.write(4*' '+'resource_pool: esx_pool  \n')



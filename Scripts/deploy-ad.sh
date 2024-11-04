#!/bin/bash

sed -i 's/127.0.0.1/8.8.8.8/' /etc/resolv.conf

apt update -y
apt upgrade -y

apt-get install acl attr samba samba-client winbind libpam-winbind libnss-winbind dnsutils python3-setproctitle ldap-utils ldb-tools -y

ls /etc/samba
rm $(smbd -b | grep "CONFIGFILE" | cut -d ":" -f2) 
echo "etc/samba/smb.conf borrado"
ls /etc/samba



for VARIABLE in $(smbd -b | egrep "LOCKDIR|STATEDIR|CACHEDIR|PRIVATE_DIR" | cut -d ":" -f2)
do
echo "Deleting *.tdb y *.ldb en: $VARIABLE" 
rm -Rf $VARIABLE/*.tdb
rm -Rf $VARIABLE/*.ldb
done

systemctl stop winbind smbd nmbd
systemctl disable winbind smbd nmbd

samba-tool domain provision --server-role=dc --use-rfc2307 --dns-backend=SAMBA_INTERNAL --realm=NF-TIPY-UY.DUCKDNS.ORG --domain=NF-TIPY-UY --adminpass=Passw0rd

sed -i 's/8.8.8.8/127.0.0.1/' /etc/resolv.conf

samba

sleep 5

host -t SRV _ldap._tcp.NF-TIPY-UY.DUCKDNS.ORG

host -t SRV _kerberos._udp.NF-TIPY-UY.DUCKDNS.ORG

host -t A 5-nf-addc01.nf-tipy-uy.duckdns.org








samba-tool ou create 'OU=nf-tipy-uy.duckdns.org,DC=nf-tipy-uy,DC=duckdns,DC=org'
samba-tool ou create 'OU=Usuarios,OU=nf-tipy-uy.duckdns.org,DC=nf-tipy-uy,DC=duckdns,DC=org'
samba-tool ou create 'OU=Empleados,OU=Usuarios,OU=nf-tipy-uy.duckdns.org,DC=nf-tipy-uy,DC=duckdns,DC=org'
samba-tool ou create 'OU=ServiceAccounts,OU=nf-tipy-uy.duckdns.org,DC=nf-tipy-uy,DC=duckdns,DC=org'
samba-tool ou create 'OU=Equipos,OU=nf-tipy-uy.duckdns.org,DC=nf-tipy-uy,DC=duckdns,DC=org'
samba-tool ou create 'OU=Grupos,OU=nf-tipy-uy.duckdns.org,DC=nf-tipy-uy,DC=duckdns,DC=org'
samba-tool ou create 'OU=Ex-Empleados,OU=Usuarios,OU=nf-tipy-uy.duckdns.org,DC=nf-tipy-uy,DC=duckdns,DC=org'
samba-tool ou create 'OU=Proveedores,OU=Usuarios,OU=nf-tipy-uy.duckdns.org,DC=nf-tipy-uy,DC=duckdns,DC=org'
samba-tool ou create 'OU=Sistemas,OU=Empleados,OU=Usuarios,OU=nf-tipy-uy.duckdns.org,DC=nf-tipy-uy,DC=duckdns,DC=org'
samba-tool ou create 'OU=RRHH,OU=Empleados,OU=Usuarios,OU=nf-tipy-uy.duckdns.org,DC=nf-tipy-uy,DC=duckdns,DC=org'
samba-tool ou create 'OU=Sysadmins,OU=Sistemas,OU=Empleados,OU=Usuarios,OU=nf-tipy-uy.duckdns.org,DC=nf-tipy-uy,DC=duckdns,DC=org'
samba-tool ou create 'OU=Devs,OU=Sistemas,OU=Empleados,OU=Usuarios,OU=nf-tipy-uy.duckdns.org,DC=nf-tipy-uy,DC=duckdns,DC=org'
samba-tool ou create 'OU=Desktops,OU=Equipos,OU=nf-tipy-uy.duckdns.org,DC=nf-tipy-uy,DC=duckdns,DC=org'
samba-tool ou create 'OU=Servers,OU=Equipos,OU=nf-tipy-uy.duckdns.org,DC=nf-tipy-uy,DC=duckdns,DC=org'
samba-tool ou create 'OU=Grupos de Seguridad,OU=Grupos,OU=nf-tipy-uy.duckdns.org,DC=nf-tipy-uy,DC=duckdns,DC=org'
samba-tool ou create 'OU=Grupos Distribuidos,OU=Grupos,OU=nf-tipy-uy.duckdns.org,DC=nf-tipy-uy,DC=duckdns,DC=org'
samba-tool ou list

sleep 5

samba-tool group add sysadmins --description='Grupo de administradores del sistema'

samba-tool group move sysadmins 'OU=Grupos de Seguridad,OU=Grupos,OU=nf-tipy-uy.duckdns.org,DC=nf-tipy-uy,DC=duckdns,DC=org'
samba-tool group add devs

samba-tool group move devs 'OU=Grupos de Seguridad,OU=Grupos,OU=nf-tipy-uy.duckdns.org,DC=nf-tipy-uy,DC=duckdns,DC=org'
samba-tool group add rrhh

samba-tool group move rrhh 'OU=Grupos de Seguridad,OU=Grupos,OU=nf-tipy-uy.duckdns.org,DC=nf-tipy-uy,DC=duckdns,DC=org'
samba-tool group add proxmox-admins

samba-tool group move proxmox-admins 'OU=Grupos de Seguridad,OU=Grupos,OU=nf-tipy-uy.duckdns.org,DC=nf-tipy-uy,DC=duckdns,DC=org'

samba-tool group show sysadmins
samba-tool group show devs
samba-tool group show rrhh
samba-tool group show proxmox-admins

samba-tool user create "Carlos Martínez" Passw0rd --userou='OU=Sysadmins,OU=Sistemas,OU=Empleados,OU=Usuarios,OU=nf-tipy-uy.duckdns.org' --uid-number=10000 --gid-number=10000
samba-tool user create "Laura López" Passw0rd --userou='OU=Sysadmins,OU=Sistemas,OU=Empleados,OU=Usuarios,OU=nf-tipy-uy.duckdns.org' --uid-number=10001 --gid-number=10001
samba-tool user create "Juan Hernández" Passw0rd --userou='OU=Sysadmins,OU=Sistemas,OU=Empleados,OU=Usuarios,OU=nf-tipy-uy.duckdns.org' --uid-number=10002 --gid-number=10002
samba-tool user create "Jesús Guibert" Passw0rd --userou='OU=Sysadmins,OU=Sistemas,OU=Empleados,OU=Usuarios,OU=nf-tipy-uy.duckdns.org' --uid-number=10003 --gid-number=10003
samba-tool user create "Nicolas Ferreira" Passw0rd --userou='OU=Sysadmins,OU=Sistemas,OU=Empleados,OU=Usuarios,OU=nf-tipy-uy.duckdns.org' --uid-number=10004 --gid-number=10004
samba-tool user create "David Gómez" Passw0rd --userou='OU=Devs,OU=Sistemas,OU=Empleados,OU=Usuarios,OU=nf-tipy-uy.duckdns.org' --uid-number=10005 --gid-number=10005
samba-tool user create "Sandra Ramírez" Passw0rd --userou='OU=Devs,OU=Sistemas,OU=Empleados,OU=Usuarios,OU=nf-tipy-uy.duckdns.org' --uid-number=10006 --gid-number=10006
samba-tool user create "Alejandro Torres" Passw0rd --userou='OU=Devs,OU=Sistemas,OU=Empleados,OU=Usuarios,OU=nf-tipy-uy.duckdns.org' --uid-number=10007 --gid-number=10007
samba-tool user create "Patricia Morales" Passw0rd --userou='OU=Devs,OU=Sistemas,OU=Empleados,OU=Usuarios,OU=nf-tipy-uy.duckdns.org' --uid-number=10008 --gid-number=10008
samba-tool user create "Javier Ortiz" Passw0rd --userou='OU=Devs,OU=Sistemas,OU=Empleados,OU=Usuarios,OU=nf-tipy-uy.duckdns.org' --uid-number=10009 --gid-number=10009
samba-tool user create "Beatriz Navarro" Passw0rd --userou='OU=RRHH,OU=Empleados,OU=Usuarios,OU=nf-tipy-uy.duckdns.org' --uid-number=10010 --gid-number=10010
samba-tool user create "Raúl Gil" Passw0rd --userou='OU=RRHH,OU=Empleados,OU=Usuarios,OU=nf-tipy-uy.duckdns.org' --uid-number=10011 --gid-number=10011
samba-tool user create "María Soto" Passw0rd --userou='OU=RRHH,OU=Empleados,OU=Usuarios,OU=nf-tipy-uy.duckdns.org' --uid-number=10012 --gid-number=10012
samba-tool user create "Antonio Castro" Passw0rd --userou='OU=RRHH,OU=Empleados,OU=Usuarios,OU=nf-tipy-uy.duckdns.org' --uid-number=10013 --gid-number=10013
samba-tool user create "Isabel Ramos" Passw0rd --userou='OU=RRHH,OU=Empleados,OU=Usuarios,OU=nf-tipy-uy.duckdns.org' --uid-number=10014 --gid-number=10014
samba-tool user create "Jorge Vega" Passw0rd --userou='OU=RRHH,OU=Empleados,OU=Usuarios,OU=nf-tipy-uy.duckdns.org' --uid-number=10015 --gid-number=10015


cat <<EOF | ldbmodify -H /var/lib/samba/private/sam.ldb
dn: CN=Domain Users,CN=Users,DC=nf-tipy-uy,DC=duckdns,DC=org
changetype: modify
add: gidNumber
gidNumber: 10000
EOF

cat <<EOF | ldbmodify -H /var/lib/samba/private/sam.ldb
dn: CN=sysadmins,OU=Grupos de Seguridad,OU=Grupos,OU=nf-tipy-uy.duckdns.org,DC=nf-tipy-uy,DC=duckdns,DC=org
changetype: modify
replace: gidNumber
gidNumber: 10001
EOF



# Group sysadmins
samba-tool group addmembers sysadmins "Carlos Martínez"
samba-tool group addmembers sysadmins "Laura López"
samba-tool group addmembers sysadmins "Juan Hernández"
samba-tool group addmembers sysadmins "Jesús Guibert"
samba-tool group addmembers sysadmins "Nicolas Ferreira"

#Grupo devs
samba-tool group addmembers devs "David Gómez"
samba-tool group addmembers devs "Sandra Ramírez"
samba-tool group addmembers devs "Alejandro Torres"
samba-tool group addmembers devs "Patricia Morales"
samba-tool group addmembers devs "Javier Ortiz"

#Grupo RRHH
samba-tool group addmembers rrhh "Beatriz Navarro"
samba-tool group addmembers rrhh "Raúl Gil"
samba-tool group addmembers rrhh "María Soto"
samba-tool group addmembers rrhh "Antonio Castro"
samba-tool group addmembers rrhh "Isabel Ramos"
samba-tool group addmembers rrhh "Jorge Vega"

samba-tool group addmembers proxmox-admins "Nicolas Ferreira"
samba-tool group addmembers proxmox-admins "Jesús Guibert"

samba-tool user getgroups "Nicolas Ferreira"


samba-tool group create "unix admins"
samba-tool user create nicolas.ferreira Passw0rd


samba-tool group addmembers "unix admins" nicolas.ferreira
samba-tool group addmembers "unix admins" administrator
samba-tool group create "proxmox admins"
samba-tool group addmembers "proxmox admins" nicolas.ferreira
samba-tool user show nicolas.ferreira

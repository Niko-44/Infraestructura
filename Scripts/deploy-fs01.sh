#!/bin/bash

apt update -y
apt upgrade -y

apt install acl attr samba samba-client winbind libpam-winbind libnss-winbind dnsutils python3-setproctitle -y

DOMAIN="NF-TIPY-UY"
REALM="${DOMAIN}.DUCKDNS.ORG"
ADMINPASSWORD="Passw0rd"

cat << EOF > /etc/krb5.conf
[libdefaults]
    default_realm = ${REALM}
    dns_lookup_realm = false
    dns_lookup_kdc = true
EOF

cat << EOF > /etc/samba/smb.conf

security = ADS
workgroup = ${DOMAIN}
realm = ${REALM}

log file = /var/log/samba/%m.log
log level = 1

idmap config * : backend = tdb
idmap config * : range = 3000-7999

idmap config ${DOMAIN} : backend = ad
idmap config ${DOMAIN} : schema_mode = rfc2307
idmap config ${DOMAIN} : range = 10000-999999
idmap config ${DOMAIN} : unix_nss_info = yes

vfs objects = acl_xattr
map acl inherit = yes
store dos attributes = yes

winbind enum users = yes
winbind enum groups = yes

[Publico]
path = /srv/fileserver/publico/
read only = no

[Instaladores]
path = /srv/fileserver/instaladores/
read only = no

EOF

net ads join -U administrator%$ADMINPASSWORD

cat << EOF > /etc/nsswitch.conf
passwd: files winbind
group: files winbind
shadow: files systemd
gshadow: files systemd
hosts: files dns
networks: files
protocols: db files
services: db files
ethers: db files
rpc: db files
netgroup: nis
EOF

systemctl restart winbind


mkdir -p /srv/fileserver/publico/
mkdir -p /srv/fileserver/instaladores/

chown root:"NF-TIPY-UY\domain users" /srv/fileserver/publico/
chown root:"NF-TIPY-UY\sysadmins" /srv/fileserver/instaladores/

chmod 0750 /srv/fileserver/publico/
chmod 0770 /srv/fileserver/instaladores/

systemctl restart smbd
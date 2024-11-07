#!/bin/bash

apt update
apt install nginx -y


mkdir /var/www/site1-nf-tipy-uy.duckdns.org
mkdir /var/www/site2-nf-tipy-uy.duckdns.org

cat <<EOF >/var/www/site1-nf-tipy-uy.duckdns.org/index.html
<h1>Site 1 NF-TIPY-UY.DUCKDNS.ORG</h1>
EOF

cat <<EOF >/var/www/site2-nf-tipy-uy.duckdns.org/index.html
<h1>Site 2 NF-TIPY-UY.DUCKDNS.ORG</h1>
EOF

cat << EOF >/etc/nginx/sites-available/site1-nf-tipy-uy.duckdns.org
server {
        listen 80;

        root /var/www/site1-nf-tipy-uy.duckdns.org;

        index index.html index.htm index.nginx-debian.html;

        server_name site1-nf-tipy-uy.duckdns.org;

        location / {
                try_files \$uri \$uri/ =404;
        }
}
EOF

cat << EOF >/etc/nginx/sites-available/site2-nf-tipy-uy.duckdns.org
server {
        listen 80;

        root /var/www/site2-nf-tipy-uy.duckdns.org;

        index index.html index.htm index.nginx-debian.html;

        server_name site2-nf-tipy-uy.duckdns.org;

        location / {
                try_files \$uri \$uri/ =404;
        }
}
EOF

cd /etc/nginx/sites-enabled/
ln -s /etc/nginx/sites-available/site1-nf-tipy-uy.duckdns.org site1-nf-tipy-uy.duckdns.org
ln -s /etc/nginx/sites-available/site2-nf-tipy-uy.duckdns.org site2-nf-tipy-uy.duckdns.org

systemctl restart nginx
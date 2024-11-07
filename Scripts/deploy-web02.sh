#!/bin/bash

apt update && apt upgrade -y
apt install nginx -y

rm /var/www/html/index.nginx-debian.html

cat <<EOF >/etc/nginx/sites-available/site1.NF-TIPY-UY.DUCKDNS.ORG
server {
    listen 80;
    server_name site1.NF-TIPY-UY.DUCKDNS.ORG;

    root /var/www/html/site1;
    index index.html;

    location / {
        try_files \$uri \$uri/ =404;
    }
}
EOF


cat <<EOF >/etc/nginx/sites-available/site2.NF-TIPY-UY.DUCKDNS.ORG
server {
    listen 80;
    server_name site2.NF-TIPY-UY.DUCKDNS.ORG;

    root /var/www/html/site2;
    index index.html;

    location / {
        try_files \$uri \$uri/ =404;
    }
}
EOF

ln -s /etc/nginx/sites-available/site1.NF-TIPY-UY.DUCKDNS.ORG /etc/nginx/sites-enabled/
ln -s /etc/nginx/sites-available/site2.NF-TIPY-UY.DUCKDNS.ORG /etc/nginx/sites-enabled/

mkdir -p /var/www/html/site1 /var/www/html/site2
echo "<h1>Bienvenido a site1.NF-TIPY-UY.DUCKDNS.ORG</h1>" > /var/www/html/site1/index.html
echo "<h1>Bienvenido a site2.NF-TIPY-UY.DUCKDNS.ORG</h1>" > /var/www/html/site2/index.html


echo "175.148.0.243 site1.NF-TIPY-UY.DUCKDNS.ORG" | tee -a /etc/hosts
echo "175.148.0.243 site2.NF-TIPY-UY.DUCKDNS.ORG" |  tee -a /etc/hosts



systemctl restart nginx
#!/bin/bash

# Actualización del sistema
apt update -y
apt upgrade -y

apt install nginx php php-fpm php-mysql unzip -y
timedatectl set-timezone 'America/Montevideo'
dpkg-reconfigure --frontend noninteractive tzdata

rm /var/www/html/index.nginx-debian.html

cat <<EOF >/etc/nginx/sites-available/default
server {
        listen 80 default_server;
        listen [::]:80 default_server;

        root /var/www/html/site1;

        index index.php index.html index.htm index.nginx-debian.html;

        server_name _;

        location / {
                try_files \$uri \$uri/ =404;
        }

        location ~ \.php$ {
               include snippets/fastcgi-php.conf;
        
               fastcgi_pass unix:/run/php/php8.2-fpm.sock;
        }
}
EOF

systemctl restart nginx

wget https://wordpress.org/latest.zip -O /tmp/worldpress-6-6-2.zip
unzip /tmp/worldpress-6-6-2.zip -d /var/www/html
rm -Rf /tmp/worldpress-6-6-2.zip

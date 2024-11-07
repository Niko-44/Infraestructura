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

        root /var/www/html/wordpress;

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

cat <<EOF >/etc/nginx/sites-enabled/default
server {
        listen 80 default_server;
        listen [::]:80 default_server;

        root /var/www/html/wordpress;

        index index.php index.html index.htm index.nginx-debian.html;

        server_name _;

        location / {
                try_files $uri $uri/ =404;
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

touch /var/www/html/wordpress/wp-config.php

cat <<'EOF' >/var/www/html/wordpress/wp-config.php

<?php

define( 'DB_NAME', 'wordpress' );

define( 'DB_USER', 'wordpressUSR' );

define( 'DB_PASSWORD', 'Passw0rd' );

define( 'DB_HOST', '175.148.0.244' );

define( 'DB_CHARSET', 'utf8mb4' );

define( 'DB_COLLATE', '' );

define( 'AUTH_KEY',         'fiOtFuVyZE-)e<d7-9F.p<(84Vb5!`8^]~y=Exul#:?07^BJ~q6PQ]Q5WF=N>a[;' );
define( 'SECURE_AUTH_KEY',  'FdhQE*^a^C3+,+[7[9KwVfi, 7Rvq$A^)]-_j9(*,|Ym6dcA/Q7X&8@I#,[q$.{^' );
define( 'LOGGED_IN_KEY',    '_oD{o7;CA`N!EU%Eq/?0HMHvC%%}ON?o#m7$)#W{Q8/6V gfJSKY/XsX.fh=F1O>' );
define( 'NONCE_KEY',        '0Rf#CtUSA9R${|8Qz|x6z8ju6y,)n#_,p[d.^NU^0o{B{T+B_fg<wQD?UuXlGvNl' );
define( 'AUTH_SALT',        'f|55NG;uiFih6xlQ[Q|I)e|Nj6%X5E)[~2Ju,V5tMY=f[E#>)y|ImoQdb% bZ(Bl' );
define( 'SECURE_AUTH_SALT', 'Z?;9Z(PETmYvmoX-+=UJ5hbS*GUo[(?7A+df6)GeXKDdE6;gacy)Kc53X~6;^d]&' );
define( 'LOGGED_IN_SALT',   'c2lrt06{? a)EP9G5;HZ_Ck3i}h6u|J!toPd_JCK9?lFjD=NYQs){NGTe:GayUhs' );
define( 'NONCE_SALT',       '&gvlVUK| yR1(0)DYJkiqD980?,.$N8*/`.$S#r-,]Q4.*94y/Ez195I230*(S~W' );

$table_prefix = 'wp_';

define( 'WP_DEBUG', false );

if ( ! defined( 'ABSPATH' ) ) {
        define( 'ABSPATH', __DIR__ . '/' );
}

require_once ABSPATH . 'wp-settings.php';

EOF

# Reiniciar el servicio de PHP-FPM para asegurarnos de que se aplica la configuración
systemctl restart php8.2-fpm
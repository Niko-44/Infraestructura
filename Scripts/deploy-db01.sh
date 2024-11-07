#!/bin/bash

# Actualización del sistema
apt update -y
apt upgrade -y

# Instalación de MariaDB y plugin de autenticación LDAP
apt install mariadb-server -y
timedatectl set-timezone 'America/Montevideo'

# Configuración para escuchar en todas las interfaces
sed -i "s/127.0.0.1/0.0.0.0/" /etc/mysql/mariadb.conf.d/50-server.cnf


# Reiniciar MariaDB para aplicar cambios de configuración
systemctl restart mariadb

# Crear base de datos y usuario LDAP
mariadb -e "CREATE DATABASE wordpress;"
mariadb -e "CREATE USER wordpressUSR IDENTIFIED BY 'Passw0rd';"
mariadb -e "GRANT ALL PRIVILEGES ON wordpress.* TO wordpressUSR;"
mariadb -e "FLUSH PRIVILEGES;"
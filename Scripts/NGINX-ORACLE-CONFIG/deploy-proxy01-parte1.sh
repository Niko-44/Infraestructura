#!/bin/bash

apt update && apt upgrade -y

curl -fsSL https://tailscale.com/install.sh | sh

apt install inteutils-ping -y

tailscale up --accept-routes

# Add Docker's official GPG key:
sudo apt-get update
sudo apt-get install ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Add the repository to Apt sources:
echo \
    "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" |
    sudo tee /etc/apt/sources.list.d/docker.list >/dev/null
sudo apt-get update

sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

sudo docker run hello-world

sudo usermod -aG docker ubuntu #Agregar el usuario ubuntu al grupo docker

echo "175.148.0.243 site1-nf-tipy.duckdns.org" | sudo tee -a /etc/hosts > /dev/null
echo "175.148.0.243 site2-nf-tipy.duckdns.org" | sudo tee -a /etc/hosts > /dev/null
echo "175.148.0.242 nf-tipy.duckdns.org" | sudo tee -a /etc/hosts > /dev/null
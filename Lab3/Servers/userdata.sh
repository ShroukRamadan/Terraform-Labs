#!/usr/bin/bash
sudo apt update -y
sudo apt install nginx -y
sudo systemctl enable --now nginx
sudo systemctl status nginx
echo "Hello World from Terraform " > /var/www/html/index.html
#!/bin/bash
sudo apt update -y
sudo apt install nginx -y
sudo ufw allow 'Nginx HTTP'
echo "<h1>Hello World from Level Up In Tech</h1>" > /var/www/html/index.html
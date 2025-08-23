#!/bin/bash 
apt update -y 
apt install nginx -y
systemctl start nginx
systemctl enable nginx
echo "<h1>Welcome Sudarshan to Nginx on EC2!</h1>" | sudo tee /var/www/html/index.html

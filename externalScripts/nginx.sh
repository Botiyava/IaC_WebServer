#!/bin/bash
apt -y update
apt -y install nginx
myip=$(curl http://169.254.169.254/latest/meta-data/local-ipv4)
echo "<html><body><h1>WebServer with IP:$myip</h1><br><h1>Build by Terraform & supports by nginx!</h1></body></html>" > /var/www/html/index.html



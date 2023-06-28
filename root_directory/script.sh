#!/bin/bash
apt-get update
apt-get install nginx -y
echo "Hi Superman" >/var/www/html/index.nginx-debian.html



#       "sudo apt-get update",
#       "sudo apt-get install apache2 -y",
#!/usr/bin/env bash

# sudo rpm -Uvh http://download.fedoraproject.org/pub/epel/6/i386/epel-release-6-8.noarch.rpm
# sudo yum install proftpd
# sudo yum install ftp
# https://digitalocean.com/community/articles/how-to-set-up-proftpd-on-centos-6

echo '
#
# A virtual host using mix of IP-, name-, and port-based configuration
#

server {
    listen       80;
#    listen       *:80;
    server_name  example.com;

    location / {
        root   /var/www/example.com/public_html/;
         index  index.html index.htm;
    }
}
' > /etc/nginx/sites-available/default

# NodeJS reverse proxy

echo '
#
# A virtual host using NodeJS Reverse Proxy
#

server {
    listen       80;
    server_name  nodejs.example;

    location / {
        proxy_pass http://localhost:15301/;
    	proxy_set_header Host $host;
    	proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;

    	# If Sockets
    	# proxy_set_header Upgrade $http_upgrade;
		# proxy_set_header Connection "upgrade";
		# proxy_http_version 1.1;
    }
}
' > /etc/nginx/sites-available/node.js

ln -s /etc/nginx/sites-available/node.js /etc/nginx/sites-enabled/node.js

sudo service nginx restart

#IPTables
# https://digitalocean.com/community/articles/how-to-setup-a-basic-ip-tables-configuration-on-centos-6

iptables -F
iptables -A INPUT -p tcp --tcp-flags ALL NONE -j DROP
iptables -A INPUT -p tcp ! --syn -m state --state NEW -j DROP
iptables -A INPUT -p tcp --tcp-flags ALL ALL -j DROP
iptables -A INPUT -i lo -j ACCEPT
iptables -A INPUT -p tcp -m tcp --dport 80 -j ACCEPT # HTTP
# iptables -A INPUT -p tcp -m tcp --dport 443 -j ACCEPT #Uncomment if HTTPS
# iptables -A INPUT -p tcp -m tcp --dport 25 -j ACCEPT #SMTP
# iptables -A INPUT -p tcp -m tcp --dport 465 -j ACCEPT #SMTP
# iptables -A INPUT -p tcp -m tcp --dport 143 -j ACCEPT #POP3
# iptables -A INPUT -p tcp -m tcp --dport 993 -j ACCEPT #POP3
iptables -A INPUT -p tcp -m tcp --dport 22 -j ACCEPT # SSH
iptables -I INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT
iptables -P OUTPUT ACCEPT
iptables -P INPUT DROP

iptables -L -n

iptables-save | sudo tee /etc/sysconfig/iptables

service iptables restart


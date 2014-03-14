#!/usr/bin/env bash

ret=false
getent passwd www >/dev/null 2>&1 && ret=true

if $ret; then
	echo "The user www existe, saltarse la creación"
else
	useradd -b /var/www -d /var/www www
fi

if [ ! -d /var/www/example.com/public_html ]; then
	sudo mkdir -p /var/www/example.com/public_html
	sudo chown -R www:www /var/www
	sudo chmod 755 /var/www

	echo '<html>
	  <head>
	    <title>www.example.com</title>
	  </head>
	  <body>
	    <h1>Success: You Have Set Up a Virtual Host</h1>
	  </body>
	</html>' > /var/www/example.com/public_html/index.html;
fi



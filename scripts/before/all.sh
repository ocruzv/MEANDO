#!/usr/bin/env bash

useradd -b /var/www -d /var/www

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




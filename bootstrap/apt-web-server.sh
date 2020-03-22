#!/bin/bash
apt-get -y install apache2 php libapache2-mod-php
curl -o /var/www/html/index.php https://labstorage813.blob.core.windows.net/lab-bootstrap/bootstrap/web1/index.php
patch /etc/apache2/sites-available/000-default.conf <(curl -s https://labstorage813.blob.core.windows.net/lab-bootstrap/bootstrap/web1/apache-index-php.patch)
systemctl restart apache2

#!/bin/bash
apt-get -y install docker.io
systemctl start docker
systemctl enable docker
docker run -d -p 80:80 --name dvwa vulnerables/web-dvwa
sleep 3
docker exec dvwa bash -c "sed -i '/^ *allow_url_include/s/=.*/= On/' /etc/php/7.0/apache2/php.ini ; /etc/init.d/apache2 restart"

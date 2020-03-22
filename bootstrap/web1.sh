#!/bin/bash
apt-get update
apt-get upgrade
apt-get -y install apache2 php libapache2-mod-php
apt-get -y autoremove --purge
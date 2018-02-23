#!/bin/bash

install -m 755 /home/source/etc/rc.local /etc
install -m 644 /home/source/etc/default.apache_template /etc/default.apache_template
install -m 644 /home/source/etc/ports.conf.apache_template /etc/ports.conf.apache_template
install -m 755 /home/source/dvb/dvb-usb-dib0700-1.20.fw /lib/firmware/

cp -r /home/source/dvb /home/dvb

cp /home/source/var/www/index.html /var/www/index.html

echo "Installing TVHeadEnd" >> /home/tvstatus
echo "deb http://apt.tvheadend.org/unstable/ wheezy main" >> /etc/apt/sources.list

apt-get update
apt-get install debconf-utils -y
debconf-set-selections /home/dvb/tvheadend.seed
aptitude -o Aptitude::Cmdline::ignore-trust-violations=true install tvheadend -y

echo "Installed TVHeadEnd!" >> /home/tvstatus

api_conf="/home/source/unicorn_api.conf"
[ -e "$api_conf" ] && cp $api_conf /etc/

exit 0

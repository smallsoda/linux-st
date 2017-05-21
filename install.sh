#!/bin/bash

wai=$(whoami)

if [ "$wai" != "root" ]
then
 echo "You are not root"
 echo "Try to solve this problem"
 echo ""
 sudo ./install.sh
else
 echo "You are root"

echo "Let's install some programs"
useradd -G adm,sudo -s /bin/bash -m -d /home/soda soda
mkdir /home/soda/stat
echo "* * * * * root sudo tcpdump -G 25 -n dst port not 22 and src port not 22 -i any -W 1 -w /home/soda/stat/dump.cap" >> /etc/crontab
echo "* * * * * root /bin/sleep 29; sudo tcpdump -r /home/soda/stat/dump.cap > /home/soda/stat/dump.stat" >> /etc/crontab
echo "* * * * * root /bin/sleep 31; sudo tcpdump -G 25 -n dst port not 22 and src port not 22 -i any -W 1 -w /home/soda/stat/dump.cap" >> /etc/crontab
echo "* * * * * root /bin/sleep 57; sudo tcpdump -r /home/soda/stat/dump.cap > /home/soda/stat/dump.stat" >> /etc/crontab

apt-get install -y sysstat apache2 php7.0 libapache2-mod-php7.0
systemctl stop apache2
apt-get install -y nginx

git clone https://github.com/cream-soda/linux-c.git
cd linux-c
default > /etc/nginx/sites-available/default
ports.conf > /etc/apache2/ports.conf
apache2.conf > /etc/apache2/apache2.conf

git clone https://github.com/cream-soda/linux-st.git
cd linux-st
mv .htaccess /var/www/html/.htaccess
mv stat.sh /home/soda/stat.sh
mv systeminfo.php /var/www/html/systeminfo.php
mv table_cpu.sh /home/soda/table_cpu.sh
mv table_ios.sh /home/soda/table_ios.sh
mv table_lavg.sh /home/soda/table_lavg.sh
mv table_lsoc.sh /home/soda/table_lsoc.sh
mv table_mem.sh /home/soda/table_mem.sh
mv table_net.sh /home/soda/table_net.sh
mv table_scon.sh /home/soda/table_scon.sh
mv table_tt1.sh /home/soda/table_tt1.sh



/home/soda/stat.sh &
fi


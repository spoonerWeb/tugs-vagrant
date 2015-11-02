#!/usr/bin/env bash

sudo debconf-set-selections <<< 'mysql-server-5.5 mysql-server/root_password password rootpass'
sudo debconf-set-selections <<< 'mysql-server-5.5 mysql-server/root_password_again password rootpass'
sudo apt-get update
sudo apt-get -y install mysql-server-5.5 php5-mysql apache2 php5 php5-gd graphicsmagick wget

if [ ! -h /var/www ]; 
then 

    a2enmod rewrite

    sudo sed -i.bak '/DocumentRoot \/var\/www\/html/c DocumentRoot \/var\/www\/htdocs' /etc/apache2/sites-available/000-default.conf

    sudo sed -i.bak s/2M/10M/g /etc/php5/apache2/php.ini
    sudo sed -i.bak s/max_execution_time = 30/max_execution_time = 240/g /etc/php5/apache2/php.ini
    sudo sed -i.bak s/8M/10M/g /etc/php5/apache2/php.ini

    service apache2 restart
fi

cd /var/www/
wget -q get.typo3.org/7.5 -O typo3_src-latest.tar.gz
tar xzf typo3_src-latest.tar.gz
rm typo3_src-latest.tar.gz
mv typo3_src-7.5.0 typo3_src
cd htdocs
ln -s ../typo3_src
ln -s typo3_src/typo3
ln -s typo3_src/index.php
touch FIRST_INSTALL

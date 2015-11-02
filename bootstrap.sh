#!/usr/bin/env bash

sudo debconf-set-selections <<< 'mysql-server-5.5 mysql-server/root_password password rootpass'
sudo debconf-set-selections <<< 'mysql-server-5.5 mysql-server/root_password_again password rootpass'
sudo apt-get update
sudo apt-get -y install mysql-server-5.5 php5-mysql apache2 php5 php5-gd graphicsmagick wget curl

if [ ! -h /var/www ]; 
then 

    a2enmod rewrite

    sudo sed -i.bak '/DocumentRoot \/var\/www\/html/c DocumentRoot \/var\/www\/htdocs' /etc/apache2/sites-available/000-default.conf

    sudo sed -i.bak 's/max_execution_time = 30/max_execution_time = 240/' /etc/php5/apache2/php.ini
    sudo sed -i.bak 's/;always_populate_raw_post_data = -1/always_populate_raw_post_data = -1/' /etc/php5/apache2/php.ini
    sudo sed -i.bak 's/; max_input_vars = 1000/max_input_vars = 1500/' /etc/php5/apache2/php.ini

    service apache2 restart
fi

cd /var/www/
mkdir htdocs
wget -q get.typo3.org/7.5 -O typo3_src-latest.tar.gz
tar xzf typo3_src-latest.tar.gz
rm typo3_src-latest.tar.gz
mv typo3_src-7.5.0 typo3_src
cd htdocs
ln -s ../typo3_src
ln -s typo3_src/typo3
ln -s typo3_src/index.php
touch FIRST_INSTALL

cd ~
curl -sS https://getcomposer.org/installer | php
cd /var/www/typo3_src/
php ~/composer.phar install

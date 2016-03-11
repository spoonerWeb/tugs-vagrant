#!/usr/bin/env bash

sudo debconf-set-selections <<< 'mysql-server-5.5 mysql-server/root_password password rootpass'
sudo debconf-set-selections <<< 'mysql-server-5.5 mysql-server/root_password_again password rootpass'
sudo apt-get update
sudo apt-get -y install mysql-server-5.5 php5-mysql apache2 php5 php5-gd graphicsmagick wget curl git-core

if [ ! -h /var/www ]; 
then 

    a2enmod rewrite

    sudo sed -i.bak '/DocumentRoot \/var\/www\/html/c DocumentRoot \/var\/www\/htdocs' /etc/apache2/sites-available/000-default.conf

    sudo sed -i.bak 's/max_execution_time = 30/max_execution_time = 240/' /etc/php5/apache2/php.ini
    sudo sed -i.bak 's/;always_populate_raw_post_data = -1/always_populate_raw_post_data = -1/' /etc/php5/apache2/php.ini
    sudo sed -i.bak 's/; max_input_vars = 1000/max_input_vars = 1500/' /etc/php5/apache2/php.ini

    service apache2 restart
fi

cd ~
php -r "readfile('https://getcomposer.org/installer');" > composer-setup.php
php composer-setup.php --filename=composer
cd /var/www
git clone git://git.typo3.org/Packages/TYPO3.CMS.git typo3_src
cd typo3_src
composer install

cd ..
mkdir htdocs
cd htdocs
ln -s ../typo3_src typo3_src
ln -s typo3_src/typo3
ln -s typo3_src/index.php
touch FIRST_INSTALL

#!/usr/bin/env bash

sudo debconf-set-selections <<< 'mariadb-server-10.1 mysql-server/root_password password rootpass'
sudo debconf-set-selections <<< 'mariadb-server-10.1 mysql-server/root_password_again password rootpass'
sudo apt-get update
sudo apt-get -y install mysql-server php7.0-mysql apache2 php7.0 php7.0-gd php7.0-xml php7.0-json graphicsmagick wget curl git-core

if [ ! -h /var/www ]; 
then 

    a2enmod rewrite

    sudo sed -i.bak '/DocumentRoot \/var\/www\/html/c DocumentRoot \/var\/www\/CmsBaseDistribution\/web' /etc/apache2/sites-available/000-default.conf

    sudo sed -i.bak 's/max_execution_time = 30/max_execution_time = 240/' /etc/php/7.0/apache2/php.ini
    sudo sed -i.bak 's/;always_populate_raw_post_data = -1/always_populate_raw_post_data = -1/' /etc/php/7.0/apache2/php.ini
    sudo sed -i.bak 's/; max_input_vars = 1000/max_input_vars = 1500/' /etc/php/7.0/apache2/php.ini

    service apache2 restart
fi

curl -Ss https://getcomposer.org/installer | php > /dev/null
sudo mv composer.phar /usr/bin/composer
chmod +x /usr/bin/composer
cd /var/www/




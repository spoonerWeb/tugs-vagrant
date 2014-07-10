#!/usr/bin/env bash

sudo -s
apt-get update
apt-get install -y apache2 php5 mysql-server wget
cd /var/www/
mkdir typo3
cd typo3
wget get.typo3.org/6.2 -O typo3_src-latest.tar.gz
tar xzf typo3_src-latest.tar.gz
mv typo3_src-6.2.4 typo3_src
ln -s typo3_src/typo3
ln -s typo3_src/index.php
touch FIRST_INSTALL

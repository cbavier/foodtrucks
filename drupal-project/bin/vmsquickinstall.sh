#!/usr/bin/env bash

# TODO: Optomize this script?
# TODO: * There's a lot of `sudo apt-get update` which may be combinable
# TODO: ** May make less readable

{ # this ensures the entire script is downloaded and run #

# Update all software & install new
sudo apt-get update && sudo apt-get upgrade -y

# Install the simple stuff
# * Some versions from DO article @ https://goo.gl/jCiEhS
sudo apt-get install -y git apache2

# Install Maria DB
# * Instructions from https://goo.gl/d1vOx6 (Ubuntu >> 14.04 >> 10.1 >> DigitalOcean - New York)
# * No password for maria db install from http://dba.stackexchange.com/a/60192
sudo apt-get install software-properties-common
sudo apt-key adv --recv-keys --keyserver hkp://keyserver.ubuntu.com:80 0xcbcb082a1bb943db
sudo add-apt-repository 'deb [arch=amd64,i386] http://nyc2.mirrors.digitalocean.com/mariadb/repo/10.1/ubuntu trusty main'
sudo apt-get update
export DEBIAN_FRONTEND=noninteractive
sudo debconf-set-selections <<< 'mariadb-server-10.0 mysql-server/root_password password PASS'
sudo debconf-set-selections <<< 'mariadb-server-10.0 mysql-server/root_password_again password PASS'
sudo apt-get install -y mariadb-server
mysql -uroot -pPASS -e "SET PASSWORD = PASSWORD('');"

# Install PHP 5.6
# * https://www.dev-metal.com/install-setup-php-5-6-ubuntu-14-04-lts/
sudo add-apt-repository ppa:ondrej/php5-5.6
sudo apt-get update
sudo apt-get install -y python-software-properties
sudo apt-get update
sudo apt-get install -y php5

# Install PHPMySQL support
sudo apt-get install -y php5-mysql

# Clone repository
git clone https://github.com/codeforeauclaire/foodtrucks.git /root/foodtrucks

} # this ensures the entire script is downloaded and run #

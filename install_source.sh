#!/bin/sh
echo "Start of the script . It installes postgres 15 & adds postgres OS user to sudoers list "
echo " updating hostname in /etc/hosts"
export source_IP="172.31.14.133"

echo "$source_IP  source" >> /etc/hosts

echo " Settting hostname of source host"
sudo hostnamectl set-hostname source
echo " Installing postgres 15"
sudo sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list'
wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -
sudo apt-get update
sudo apt-get -y install postgresql-15
echo " Add postgres OS user to sudoers file "
echo "postgres  ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
echo " end of the installation script"
echo " execute the script to install binaries "


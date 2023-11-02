#!/bin/bash

echo update everything
sudo apt-get upgrade && sudo apt-get update && sudo apt-get dist-upgrade

echo enable firewall
apt-get install ufw && ufw enable

echo remove hacking programs
# add more probably
pkgstoremove=( hashcat apache2 john )

for package in $pkgstoremove; do
sudo apt-get purge package
done


echo remove unneccesary media files
# add more probably
extstoremove=( mov mp4 mp3 jpg jpeg )

for ext in $extstoremove; do
find / -name "*.$ext" -type f -delete
done


apt-cache rdepends <package>

#delete files with nonexistant owners
find / -nogroup -nouser -delete

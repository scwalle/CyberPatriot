#!/bin/bash

# update everything
sudo apt-get upgrade && sudo apt-get update && sudo apt-get dist-upgrade

# remove hacking programs
# add more probably
pkgstoremove=( hashcat apache2 john )

for package in $pkgstoremove; do
sudo apt-get purge package
done


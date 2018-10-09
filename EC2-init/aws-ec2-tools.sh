#!/bin/bash
# Preps VM build for Pelagos Hashing

# Add nload tool from source
cd ~
wget https://github.com/rolandriegel/nload/archive/v0.7.4.tar.gz
tar xfvz v0.7.4.tar.gz
cd nload-0.7.4/
./run_autotools
./configure
make
sudo make install

# Add Pelagos aws-tool repo
cd ~
echo "yes" | git clone git@github.com:griidc/aws-tools.git

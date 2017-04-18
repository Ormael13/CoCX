#!/bin/sh

SRC_DIR='coc'

sudo apt-get update
sudo apt-get install git ant -y
sh /vagrant/setup-flex.sh

if [ ! -d "$SRC_DIR" ] ; then
    git clone --depth=50 --branch=master https://github.com/Kitteh6660/Corruption-of-Champions-Mod.git "$SRC_DIR"
fi

cd $SRC_DIR

git checkout origin/master

ant debug -DFLEX_HOME="../flex"
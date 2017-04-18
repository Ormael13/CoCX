#!/bin/sh

SRC_DIR='coc'

sudo apt-get update
sudo apt-get install git ant vnc4server xfce4 -y
sh /vagrant/setup-flex.sh

Xvnc :1 &
export DISPLAY=":1"

if [ ! -d "$SRC_DIR" ] ; then
    git clone --depth=50 --branch=master https://github.com/Kitteh6660/Corruption-of-Champions-Mod.git "$SRC_DIR"
fi

cd $SRC_DIR

git checkout origin/master

ant test -DFLEX_HOME="../flex"

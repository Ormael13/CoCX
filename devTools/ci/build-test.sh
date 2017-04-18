#!/bin/sh

sudo apt-get install git -y
git clone --depth=50 --branch=master https://github.com/Kitteh6660/Corruption-of-Champions-Mod.git coc
cd coc
ant debug -DFLEX_HOME="/usr/local/bin/apache-flex"
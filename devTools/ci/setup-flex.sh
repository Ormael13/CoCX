#!/bin/sh
VERSION='4.16.0'
PLAYER_VERSION='23.0'
GLOBAL_PLAYER_DIR="frameworks/libs/player/$PLAYER_VERSION"
GLOBAL_PLAYER_PATH="$GLOBAL_PLAYER_DIR/playerglobal.swc"
USER_LOCAL_DIR="/usr/local"
USER_BIN_DIR="$USER_LOCAL_DIR/bin"
USER_LIB_DIR="$USER_LOCAL_DIR/lib"
USER_FRAMEWORK_DIR="$USER_LOCAL_DIR/lib"
FLEX_DIR="$USER_BIN_DIR/apache-flex"
FLEX_BIN_DIR="$FLEX_DIR/bin"

sudo apt-get update
sudo apt-get install ant -y

wget -N "http://www-eu.apache.org/dist/flex/$VERSION/binaries/apache-flex-sdk-$VERSION-bin.tar.gz"
tar zxf "apache-flex-sdk-$VERSION-bin.tar.gz"
cd "apache-flex-sdk-$VERSION-bin"
ant -f installer.xml -Dflash.donot.ask=true -Dair.donot.ask=true -Dfontswf.donot.ask=true

echo "Creating $GLOBAL_PLAYER_DIR"
mkdir -vp $GLOBAL_PLAYER_DIR

# TODO generate link with version number with sed or awk?
wget -nc http://download.macromedia.com/get/flashplayer/updaters/23/playerglobal23_0.swc -O"$GLOBAL_PLAYER_PATH"

echo "Creating $FLEX_DIR"
sudo mkdir -p $FLEX_DIR

echo "Copy files to $USER_LOCAL_DIR"
cd ..
sudo cp -r "apache-flex-sdk-$VERSION-bin"/* $FLEX_DIR
sudo cp -r bin/* $USER_BIN_DIR
sudo cp -r frameworks $USER_LOCAL_DIR
sudo cp -r lib/* $USER_LIB_DIR
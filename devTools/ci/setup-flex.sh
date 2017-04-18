#!/bin/sh
VERSION='4.16.0'
PLAYER_VERSION='23.0'
GLOBAL_PLAYER_DIR="frameworks/libs/player/$PLAYER_VERSION"
GLOBAL_PLAYER_PATH="$GLOBAL_PLAYER_DIR/playerglobal.swc"

wget -N "http://www-eu.apache.org/dist/flex/$VERSION/binaries/apache-flex-sdk-$VERSION-bin.tar.gz"
tar zxf "apache-flex-sdk-$VERSION-bin.tar.gz"
mv "apache-flex-sdk-$VERSION-bin" "flex"
cd "flex"
ant -f installer.xml -Dflash.donot.ask=true -Dair.donot.ask=true -Dfontswf.donot.ask=true

echo "Creating $GLOBAL_PLAYER_DIR"
mkdir -vp $GLOBAL_PLAYER_DIR

# TODO generate link with version number with sed or awk?
wget -nc http://download.macromedia.com/get/flashplayer/updaters/23/playerglobal23_0.swc -O"$GLOBAL_PLAYER_PATH"
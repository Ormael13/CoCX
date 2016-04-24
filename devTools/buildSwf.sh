#!/bin/bash

# This is one of several utility scripts used by Fake-Name's automated build setup
# to automatically create compiled versions of the CoC codebase
#
# this is the actual call to mxmlc that builds a complete swf

set -e

OS=$(uname -s)
FLEX_ROOT=/opt/flex
ADT=${FLEX_ROOT}/bin/adt
if [[ ${OS} =~ ^CYGWIN ]]; then
    FLEX_ROOT=/c/APPS/flex_4_6
    ADT="java -jar $(cygpath -w ${FLEX_ROOT})/lib/adt.jar"
fi

# pull out the version so we can use it for the filename.
COC_VERSION=$(gawk 'match($0, /^[\s\t]+ver = \"(.+)\";/, n) { print n[1] }' < classes/classes/CoC.as)
COC_VERSION_APK=$(echo ${COC_VERSION} | awk -F- '{ print $1 }')
SWF_NAME="CoC-${COC_VERSION}.swf"

echo "Build version = ${COC_VERSION}"

# Clean up old build-artifacts (probably unnecessary with buildbot's build mechanisms)
rm -f ../binRepo/CoC*.{apk,swf}

# ADT packages all files in dirs specified by '-C DIR' so always use clean dir
rm -rf tmp
mkdir tmp

# Force the submodules to be up to date.
git submodule update --init

# This is intended to be run from the root of the git repo as such:
# 'devTools/build.sh'
# the paths are all relative to the repo root.
COMMON_OPTS="\
-use-network=false \
-default-background-color=0x000000 \
-static-link-runtime-shared-libraries=true \
-strict=false \
-define+=CONFIG::release,false \
-define+=CONFIG::debug,true \
-source-path+=classes \
-library-path+=./lib/bin/MainView.swc \
-library-path+=./lib/bin/ScrollPane.swc \
"

# Build standalone SWF
echo "Build standalone ${SWF_NAME}"
${FLEX_ROOT}/bin/amxmlc \
${COMMON_OPTS} \
-debug \
-define+=CONFIG::AIR,false \
-define+=CONFIG::STANDALONE,true \
-o ../binRepo/CoC-${COC_VERSION}.swf \
classes/classes/CoC.as

# Build the Android package
# swf-version=14 == AIR 3.1
# swf-version=21 == AIR 3.8
# swf-version=24 == AIR 13.0
echo "Build AIR SWF ${SWF_NAME}"
${FLEX_ROOT}/bin/mxmlc \
${COMMON_OPTS} \
-define+=CONFIG::AIR,true \
-define+=CONFIG::STANDALONE,false \
-o tmp/CoC-${COC_VERSION}.swf \
+configname=airmobile \
-swf-version=14 \
classes/classes/CoC.as

echo "Setting Application Descriptor version number to ${COC_VERSION_APK}"
/bin/sed -r \
    -e "s@(<versionNumber>).*(<\/versionNumber>)@\1${COC_VERSION_APK}\2@" \
    -e "s@(<content>).*(<\/content>)@\1${SWF_NAME}\2@" \
    ./application.xml
# > ./tmp/application.xml

$ADT \
-package \
-target apk-debug \
-listen \
-storetype pkcs12 \
-keystore ./devTools/cert/CorruptionofChampionsAIR.p12 \
-storepass testpassword \
../binRepo/CoC-${COC_VERSION}.apk \
./tmp/application.xml \
-C tmp . \
-C ./devTools/icons .

rm -rf tmp

echo Done. Building android package.

## Fuck you Adobe. They no longer support air on linux. Assholes.
## If you uncomment the below, it *may* build a air iOS package.

# echo Android package built. Building iOS package.

# fyi, this takes 20+ minutes on a stock-clock i7 920.

# $ADT \
# -package \
# -target ipa-ad-hoc \
# -storetype pkcs12 \
# -keystore ./devTools/cert/CorruptionofChampionsAIR.p12 \
# -storepass testpassword \
# -provisioning-profile ./devTools/cert/Fake.mobileprovision \
# ../binRepo/CoC-${COC_VERSION}.ipa \
# ./application.xml \
# -C ../binRepo . \
# -C ./devTools/icons/ios .

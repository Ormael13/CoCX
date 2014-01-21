#!/bin/bash 

# This is one of several utility scripts used by Fake-Name's automated build setup
# to automatically create compiled versions of the CoC codebase
#
# This script modifies the main CoC.as file and inserts a notification that this is an 
# alpha-release, as well as embeds the current time of compilation

echo Reverting any local changes to CoC.as file
git checkout -- ./classes/classes/CoC.as

export GIT_REV=`git rev-parse  --short HEAD`

echo Done. Splicing in release info
/bin/sed -i -r "s/^([\s\\t]+ver\s?=\s?\".+)\";/\1-A-${GIT_REV}\"\;/" ./classes/classes/CoC.as
/bin/sed -i -r "s/^([\s\\t]+version\s?=\s?\".+)\";/\1\\\\nALPHA RELEASE Rev: ${GIT_REV}\\\\n Compiled by buildbot\"\;/" ./classes/classes/CoC.as

#cat ./classes/classes/CoC.as
echo 
echo File modified. Current version strings:
cat ./classes/classes/CoC.as | grep -E "ver\s?="
cat ./classes/classes/CoC.as | grep -E "version\s?="


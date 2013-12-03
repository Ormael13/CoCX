#!/bin/bash 


# This is one of several utility scripts used by Fake-Name's automated build setup
# to automatically create compiled versions of the CoC codebase
#
# this is the actual call to mxmlc that builds a complete swf

# Clean up old build-artifacts (probably unnecessary with buildbot's build mechanisms)
rm -f CoC*.swf

# Force the submodules to be up to date.
git submodule update --init

# This is intended to be run from the root of the git repo as such:
# 'devTools/build.sh'
# the paths are all relative to the repo root.
/opt/flex/bin/mxmlc \
-use-network=false \
-default-background-color=0x000000 \
-static-link-runtime-shared-libraries=true \
-strict=false \
-source-path+=classes \
-library-path+=./lib/bin/MainView.swc \
-library-path+=./lib/bin/ScrollPane.swc \
-o CoC-${COC_VERSION}-`date +%s`.swf \
classes/classes/CoC.as
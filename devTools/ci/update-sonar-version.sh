#!/bin/sh
#
# Update the version in 'sonar-project.properties' so sonar can track the different releases.

# shamelessly lifted from buildSwf.sh
COC_VERSION=$(gawk 'match($0, /^[\s\t]+ver = \"(.+)\";/, n) { print n[1] }' < classes/classes/CoC.as)
sed -i s/COC_VERSION/$COC_VERSION/ sonar-project.properties


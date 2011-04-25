#!/bin/bash

#exit on all errors
set -e

#section=proto
#section=util
section=lib

version=7.6-1

if [[ ! -d section ]] ; then
    mkdir $section
fi
cd $section

# download and check packages
grep -v '^#' ../${section}-${version}.wget | wget -i- -c \
-B http://xorg.freedesktop.org/releases/individual/${section}/
md5sum -c ../${section}-${version}.md5

# build packages
for package in $(grep -v '^#' ../${section}-${version}.wget); do

    packagedir=$(echo $package | sed 's/.tar.bz2//')

    tar -xf $package
    cd $packagedir

    ./configure $XORG_CONFIG
    make

    packagename=${packagedir%-*}

    #make install

    echo paco -l -p $packagename 'make install'
    paco -l -p $packagename 'make install'

    cd ..
    rm -rf $packagedir

done 2>&1 | tee -a ../xorg-${section}-compile.log #log the entire loop

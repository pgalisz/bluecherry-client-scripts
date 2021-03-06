#!/bin/bash

LIBAV_SRC_VERSION=9.5
LIBAV_SRC_FILE=libav-$LIBAV_SRC_VERSION.tar.gz
LIBAV_SRC_DIR=libav-$LIBAV_SRC_VERSION
LIBAV_SRC_URL=http://libav.org/releases/$LIBAV_SRC_FILE

function installLibAv {
    installBuildDependencies
    downloadLibAvSources
    unpackLibAvSources

    pushd $LIBAV_SRC_DIR
    buildLibAvFromSources
    installLibAvFromSources
    popd
}

function installBuildDependencies {
    sudo port install yasm wget
}

function downloadLibAvSources {
    wget $LIBAV_SRC_URL
}

function unpackLibAvSources {
    tar xzf $LIBAV_SRC_FILE
}

function buildLibAvFromSources {
    ./configure --prefix=$HOME/dev/usr --enable-shared --disable-static --extra-cflags="-m32" --extra-ldflags="-m32" --disable-mmx --disable-debug --disable-optimizations
    make -j5
}

function installLibAvFromSources {
    make install
}

installLibAv

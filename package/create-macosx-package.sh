#!/bin/bash

PRODUCT=bluecherry-client
VERSION=$1
GIT_URL=git://github.com/vogel/bluecherry-client.git

function usage
{
        echo "Usage: $0 package-version"
        echo "    package-version must be a git tag name"
}

if [ "!" == "!$VERSION" ]; then
        usage
        exit
fi

sudo port install cmake git-core

PACKAGE_DIR=${PRODUCT}-${VERSION}

git clone $GIT_URL $PACKAGE_DIR
pushd $PACKAGE_DIR
git checkout $VERSION
git submodule init
git submodule update
find . -name ".git*" | xargs rm -rf

cp ../macosx.cmake ./user.cmake

mkdir build
pushd build

export QTDIR=$HOME/dev/usr
cmake ../
make -j3
make deploy
make create-symbols

popd

./mac/package.sh build

mv BluecherryClient.dmg ../BluecherryClient-${VERSION}.dmg

popd


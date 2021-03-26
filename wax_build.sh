#!/usr/bin/env bash
set -e

bash -c "scripts/eosio_build.sh $*"

cd build/packages
./generate_package.sh deb

echo .deb files in build/packages/
ls -l

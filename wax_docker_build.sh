#!/usr/bin/env bash
set -e

# TODO: Needs a Makefile with build, rebuild (using existing container) and clean

git submodule update --init --recursive

# Delete the "install" if it exists
sudo rm -rf build/dist || true
# Create a destination for the "install" the script insists on doing
sudo mkdir -p build/dist
# Create the build image
# TODO: Install all dependencies during the container build to save time on later builds
docker build -f docker/Dockerfile.build -t wax-build:18.04 ./docker

# Clean up any existing wax-build container
docker rm wax-build || true

docker run -it -v $PWD:/eos --name wax-build --workdir /eos wax-build:18.04 \
./wax_build.sh -i /eos/build/dist -y

#!/bin/bash -e
set -u -o xtrace
# Top-level script for building esig for Linux on MacOS or Linux.
# $1: Python version
# $2: one of {i686, x86_64}
# Python wheels will be created for specified architecture, for each Python version in python_versions.txt.
if [[ $2 == "i686" ]] || [[ $2 == "x86_64" ]]
then
   arch=$2
else
   echo "Invalid architecture"
   exit 1
fi

docker build -t esig_builder_linux_${arch} -f Dockerfile_${arch}.dockerfile .

# Build the esig wheels inside the docker container.
docker run --rm -v ${PWD}/../..:/data esig_builder_linux_${arch} \
   "source ~/.bashrc; cd /data/build/Linux; ./linux_wheel_builder.sh $1 $arch" || exit 1
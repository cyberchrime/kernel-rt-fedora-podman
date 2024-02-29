#!/bin/bash

LINUX_VERSION=linux-stable-rt-6.6.18-rt23

set -e
set -u


if [[ ! -d /kernel/$LINUX_VERSION ]]; then 
    wget -c https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git/snapshot/$LINUX_VERSION.tar.gz -O - | tar -xz -C /kernel
fi

cd /tmp/
git clone https://src.fedoraproject.org/rpms/kernel.git
cd kernel
git checkout f39
echo Generating fedora config file...
./generate_all_configs.sh
echo Copying config file...
cp kernel-x86_64-fedora.config /kernel/$LINUX_VERSION/.config

echo Merging config file...
cd /kernel/$LINUX_VERSION
./scripts/kconfig/merge_config.sh .config /configs/*

make oldconfig
make bzImage
make modules

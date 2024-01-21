#!/bin/bash

set -e
set -u

fedpkg clone -a kernel
cd kernel
git checkout 08fd1612fa2ffb9f9e988cf33afbc2edca63a9ba
sudo dnf builddep -y kernel.spec

# set build id
sed -i "s/# define buildid .local/%define buildid .rt/g" kernel.spec

# download patch
wget -qO- https://cdn.kernel.org/pub/linux/kernel/projects/rt/6.6/patch-6.6.12-rt20.patch.xz | xz -d > patch-6.6.12-rt20.patch
echo "Patch2: patch-6.6.12-rt20.patch" >> kernel.spec

git clone https://src.fedoraproject.org/rpms/kernel.git

fedpkg local



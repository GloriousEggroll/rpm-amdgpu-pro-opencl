#!/bin/sh

sudo dnf -y groupinstall 'RPM Development Tools'
rpmdev-setuptree
cd ~/rpmbuild/SOURCES
if [ ! -f "amdgpu-pro-21.10-1247438-ubuntu-20.04.tar.xz" ]; then
wget --referer https://support.amd.com/en-us/kb-articles/Pages/AMDGPU-PRO-Driver-for-Linux-Release-Notes.aspx https://drivers.amd.com/drivers/linux/amdgpu-pro-21.10-1247438-ubuntu-20.04.tar.xz
fi
cd ~/rpmbuild/SPECS
git clone https://github.com/GloriousEggroll/rpm-amdgpu-pro-opencl amdgpu-pro-opencl
cd amdgpu-pro-opencl
rpmbuild -ba amdgpu-pro-opencl.spec
sudo dnf -y --nogpgcheck install ~/rpmbuild/RPMS/x86_64/amdgpu-pro-opencl-*.x86_64.rpm

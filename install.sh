#!/bin/sh

sudo dnf -y groupinstall 'RPM Development Tools'
rpmdev-setuptree
cp * ~/rpmbuild/SPECS/
cd ~/rpmbuild/SOURCES
if [ ! -f "amdgpu-pro-21.30-1290604-ubuntu-20.04.tar.xz" ]; then
wget --referer https://support.amd.com/en-us/kb-articles/Pages/AMDGPU-PRO-Driver-for-Linux-Release-Notes.aspx https://drivers.amd.com/drivers/linux/amdgpu-pro-21.30-1290604-ubuntu-20.04.tar.xz
fi
cd ~/rpmbuild/SPECS
rpmbuild -ba amdgpu-pro-opencl.spec
sudo dnf -y --nogpgcheck install ~/rpmbuild/RPMS/x86_64/amdgpu-pro-opencl-*.x86_64.rpm

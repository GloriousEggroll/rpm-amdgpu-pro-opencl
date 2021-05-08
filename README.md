AMDGPU-PRO OpenCL driver for Fedora
===================================
SOURCE: https://github.com/secureworkstation/rpm-amdgpu-pro-opencl

We repackage the proprietary Ubuntu 20.04 driver for a clean
installation on a Fedora system. It is meant to coexist with
the free AMDGPU driver on a regular Fedora kernel (no proprietary
kernel modules required). Kernel 5.6.7-300.fc32.x86_64 or newer
is recommended.

The OpenCL libraries from this package includes both the PAL and 
the ORCA (Legacy) driver, hopefully supporting all AMD GPU hardware
that is supported by the driver.

The OpenGL libraries from this package are also imported from the 
amdgpu-pro packages and used in the amdgporun script as an override,
as they are necessary for DaVinci Resolve to run.

This package is inspired and partially based on the AUR packages
by Christopher Snowhill, ipha, johnnybash, grmat, David McFarland, 
and Andrew Shark.

https://aur.archlinux.org/packages/opencl-amd/
https://aur.archlinux.org/packages/amdgpu-pro-installer


Installation
------------

Since we are not allowed to distribute the binary releases, you
will need to build the RPM package yourself.

```
sudo dnf -y groupinstall 'RPM Development Tools'
rpmdev-setuptree
cd ~/rpmbuild/SOURCES
if [ ! -f "amdgpu-pro-21.10-1247438-ubuntu-20.04.tar.xz" ]; then
wget --referer https://support.amd.com/en-us/kb-articles/Pages/AMDGPU-PRO-Driver-for-Linux-Release-Notes.aspx \
    https://drivers.amd.com/drivers/linux/amdgpu-pro-21.10-1247438-ubuntu-20.04.tar.xz
fi
cd ~/rpmbuild/SPECS
git clone https://github.com/GloriousEggroll/rpm-amdgpu-pro-opencl amdgpu-pro-opencl
cd amdgpu-pro-opencl
rpmbuild -ba amdgpu-pro-opencl.spec
sudo dnf -y --nogpgcheck install ~/rpmbuild/RPMS/x86_64/amdgpu-pro-opencl-*.x86_64.rpm
```
Notes: 
- You will need to reboot your system for the OpenCL libraries to work
- You will need to configure DaVinci Resolve's GPU preference to use the 'Pro' GPU listing.

Notes if importing video from OBS Studio into DaVinci Resolve:
- DaVinci Resolve 17 only supports h264/h265 importing and playback in the Studio version.
- DaVinci Resolve 17 does not support AAC audio. Your audio codec needs to be something like pcm_s24le

While the above DaVinci Resolve related notes are not amdgpu-pro related, I have stated them here
in case people are confused why their imports from OBS don't play or display.

Usage
-----

By default this driver is disabled, because it's needed only by
the software that uses OpenCL and in theory you may want to use
other OpenCL drivers like ROCm or Clover. You will need to explicitly
run the `amdgporun` wrapper script. Eg.

```
$ amdgporun clinfo
$ amdgporun clpeak
$ amdgporun blender
$ amdgporun darktable-cltest
$ amdgporun darktable
$ amdgporun darktable
$ amdgporun /opt/resolve/bin/resolve
```

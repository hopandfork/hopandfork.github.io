---
layout: post
title: "Virtualbox and Debian multicore VM"
categories: Linux
author: luca_fulgieri
comments: true
---
One day Federico and I started to develop a project using OpenMP.
To develop this project I used a VM with Debian installed and VirtualBox as a type 2 Hypervisor.
First, to test the OpenMP project, I set VirtualBox to allocate two virtual processors to the VM.
After that I started the VM and noticed using:
```
lscpu
```
or
```
less /proc/cpuinfo
```
that the system was still using only one core.
Searching for this problem on web you can find always the same solution - "check if **VT-X** is enabled or not".
Obviusly I checked and found VT-X enabled also looking at VirtualBox's System sheet.
My problem was that when I installed Debian, as guest OS, the VM was set with a single core and the Kernel version installed didn't support multicore system.
The solution I found was to recompile the Kernel with old configuration file but activating the **Symmetric Multiprocesssing** (SMP) support.

### Solution ###
1. Download kernel sources as an archive (.tar.gz or .zip) from the main repository <https://github.com/torvalds/linux>
2. Upack the archive in a directory
3. Copy the old config file to the kernel source directory
```
#launch this command from the kernel source directory
#replace oldconfigfile with the real name; mine was "config-3.16.0-4-586"
cp /boot/oldconfigfile .config
```
4. Edit the `CONFIG_SMP` entry in .config
```
# CONFIG_SMP is not set
```
with
```
CONFIG_SMP=y
```
(see `CONFIG_X86_BIGSMP` entry for VM with more than 8 cores)
5. Apply the new configuration
```
make olddefconfig
```
6. Now from the version 3.0 you can use `make deb-pkg` to compile the kernel and create the ".deb" packages (see [kernel-handbook.alioth.debian.org](https://kernel-handbook.alioth.debian.org/ch-common-tasks.html#s-common-official))
7. After the compiling process install the kernel
```
#from the kernel source directory
#replace the "x" symbols
cd ..
dpkg -i linux-image-xxxxxxx.deb
```
8. Reboot the system and check the core number
![lscpu](https://github.com/hopandfork/hopandfork.github.io/blob/master/public/images/post/lscpu.png)
*(lscpu with Debian on VirtualBox's Multicore VM after the procedure)*

---
layout: post
title: "Change Identity"
categories: Projects Networking
author: luca_fulgieri
comments: true
---

**Change Indentity** is a simple Bash script for Unix OSs to modify the hostname and the MAC address related to a network interface.

This script depends on two default applications which are installed in most Unix systems: `ifconfig` and `hostname`.

Before applying any changes to the interface settings, the script verifies if a config file already exists for the specific interface. If not, a specific config file is created (like `config_eth0` for the interface *eth0*) storing the current hostname and MAC address.
The config file created is like:
```
hostname=XXX
mac=08:00:27:1b:49:eb
```

Before you execute the script, you need to obtain superuser permissions running `su`.
You can use the script as follows:

- To change the hostname you can use: ```./change_identity -n hostname eth0```
- To change the MAC you can use: ```./change_identity -m mac eth0```
- To change MAC and hostname you can use: ```./change_identity -n hostname -m mac eth0```
- To restore MAC and hostname you can use the default file "config_eth0": ```./change_identity -r eth0```
- To restore MAC and hostname you can use a specific file: ```./change_identity -r config_custom eth0```

*You can find it on our repository <https://github.com/hopandfork/change_identity.git>*

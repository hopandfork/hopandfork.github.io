---
layout: post
title: "Change Identity"
categories:
author: luca_fulgieri
comments: true
---

Is a simple bash script for Linux OSs to modify hostname and mac address related to a network interface.

This script depends on two defalt application in Linux Systems "ifconfig" and "hostname".

Before applying any changes to the interface settings, the script verifies if a config file already exists for the specific interface. If not, a specific config file is created (like "config_eth0" for the interface "eth0") with the previous hostname and mac address.
The config file created is like:
```
hostname=XXX
mac=08:00:27:1b:49:eb
```

Before the executing you need to obtain superuser permission running the command `su`.
You can use the script as follow:

- To change the hostname you can use: ```./change_identity -n hostname eth0```
- To change the mac you can use: ```./change_identity -m mac eth0```
- To change mac and hostname you can use: ```./change_identity -n hostname -m mac eth0```
- To restore mac and hostname you can use the default file "config_eth0": ```./change_identity -r eth0```
- To restore mac and hostname you can use a specific file: ```./change_identity -r config_custom eth0```

*(You can find it on our repository <https://github.com/hopandfork/change_identity.git>)*

---
layout: post
title: "A storm in a teacup"
categories: Projects Cloud
author: federico_didom
comments: true
---

One of the first things that come to the eye when starting to use Apache Storm
is the easeness to use and deploy, given the existence of various
tools for automated deploy on AWS, particularly
[storm-deploy](https://github.com/nathanmarz/storm-deploy).  It is Java-based
and very easy to use, but unfortunately the last commit dates to December 2013,
with issues related to newer versions of Storm.  This makes its use quite risky,
especially considering that we needed it to deploy a project written for Storm
1.0.2, having only a short amount of time for debugging.

We are aware that the Open Source philosophy encourages fixing bugs before
creating entire new projects, but we needed Apache Storm for the Distributed
Systems and Cloud Computing course, and we were quite in a hurry.  Plus, we
were curious to try the [boto3](https://github.com/boto/boto3) Python library,
that makes things even simpler enabling Amazon Web Services setup and use
through simple scripts.

All of the above, together with the desire to give our contribution to the
Apache community, led to the creation of
[teacup-storm](https://github.com/hopandfork/teacup-storm), our first Open
Source project.  It was developed trying to find the right compromise betweeen
ease of use and customization; in fact the current version, while being far from
complete, makes possible to launch a Storm cluster by filling out a simple YAML
file and running a single command.

We tried to minimize the configuration needed on the AWS console, completely
handling the creation of the machines and security groups; all you need for a
cold start is just an AWS account, a VPC (the default one is fine) and a key
pair, and the cluster is up and running! It relies uniquely on EC2, and allows
to build the cluster upon custom AMIs; if these customs AMIs are created from
snapshots of instances launched from teacup-storm, it simply reconfigures them
without downloading again the files needed, allowing a faster and cheaper boot.

Apart from AMIs, also instance types and number of supervisor instances and
slots (e.g. running processes per instance) can be configured.

This tool is far from complete, as in our mind it should allow more flexibility
in the machines creation, but all these additions will be developed in the next
few months.  All we need now is feedback from you, in order to understand where
to work most in order to improve teacup-storm.  We hope that, thanks to it,
deploying Storm will not be considered again a storm in a teacup. Give it a try!

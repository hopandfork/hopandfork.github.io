---
layout: post
title: "A storm in a teacup"
categories: Category1 Category2
author: federico_didom
comments: true
---

One of the first things that come to the eye when starting to use Apache Storm
is the advertised easeness to use and deploy, given the existence of various
tools for automated deploy on AWS, particularly
[storm-deploy](https://github.com/nathanmarz/storm-deploy).  It is Java-based
and very easy to use, but unfortunately the last commit dates to December 2013,
with almost 30 issues open on GitHub.  This makes its use quite risky,
especially if you need to safely deploy in a short amount of time.

We are aware that the Open Source philosophy encourages fixing bugs before
creating entire new projects, but we needed Apache Storm for the Distributed
Systems and Cloud Computing course, and we were quite in a hurry.  Plus, we
were curious to try the [boto3](https://github.com/boto/boto3) Python library,
that makes things even simpler enabling Amazon Web Services setup and use
through simple scripts.

All of this, together with the desire to give our contribution to the Apache
community, led to the creation of
[teacup-storm](https://github.com/hopandfork/teacup-storm), our first Open
Source project.

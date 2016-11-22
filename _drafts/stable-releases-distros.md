---
layout: post
title: "Stable releases vs. stable distributions"
categories: OpenSource Linux
author: gabriele_russorusso
comments: true
---

I have been using [Arch Linux](www.archlinux.org), a rolling-release Linux
distribution, for three years. This post does not aim at promoting or
reviewing a distribution, but following considerations are directly correlated
to my own experience with a rolling-release distro: so this premise is worthwhile.

The most frequently expressed criticism against Arch Linux points out
potential presence of unstable packages in repositories. Actually, that 
criticism is not unfounded. Arch Linux adopts an extremely simple policy for
managing its repositories. As soon as a new **stable** version is released
for a package by its upstream (i.e. by its developers), it is pushed into
Arch's repositories. As a partial exception, some packages have to pass through
the *testing* repository before reaching final users. Anyway, they stay in that
repository for a small period of time and the whole process for a new package
is far shorter than on traditional distributions (e.g. Debian).

Now, the question: "is that policy wrong?" Should Arch Linux maintainers keep
packages in *testing* repo for a longer period and possibly reject some 
updates? It is easy to answer to the latter question: in my opinion, they simply
can't. Maintaining a rolling-release distro forces you to keep the pace of
releases from upstream (at least, if you have a limited amount of "human
		resources" to test all new versions of software).

It seems to me that there is nothing wrong with immediately upgrading 
packages to latest *stable* release from upstream. Arch's policy is not that
wrong. Simply, sometimes what comes
from upstream **is not so stable**. Open-source developers (and we'd be proud to be
included into that group) love to release new versions of their software, 
     showing fresh shining features to users. In most cases, they haven't got
enough time or resources to thoroughly test the code before releasing. In a
*perfect open-source world*, upstream would release only stable software
and distributions could (almost) blindly push new versions into repos. *In
real world*, they need help in testing new versions; in fact, having rolling-release
users trying fresh packages is a help.

Beware, this is not criticism against open-source developers! And neither I
am saying that "traditional" distros like Debian are wrong trying to deliver
only (really) stable packages to users! I just would like to make you think
about compromises that today exist, so that we can move towards a simpler interaction
between upstream developers and package maintainers, for a more mature
open-source ecosystem. Let's work for it - being you a developer, a maintainer
or a user. There is a huge amount of code to test, a lot of bugs to report and
fix and - hopefully - there will always be less effort in maintaining package
repositories!

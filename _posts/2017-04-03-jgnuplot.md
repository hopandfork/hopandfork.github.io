---
layout: post
title: "jGNUplot reborn"
categories: Projects
author: federico_didom
comments: true
---

Being a team born in a university campus, it is quite common to find ourselves
writing a report for a particular project, most likely using LaTex.  And one of
the most tedious activities that a report implies is having to draw a consistent
number of plots. This can be accomplished in several ways: the most audacious
among mortals would try to export them from Microsoft Excel; more down-to-earth
people would rather use something like [gnuplot](www.gnuplot.info).

Gnuplot is a very powerful tool, and you should check it out in the case that it
doesn't sound familiar to you.  Unfortunately, as many powerful tools out there,
its initial setup is a bit tricky, and the effort spent in this first phase
could discourage some novice users from using it.  This initial setup, from our
experience, in fact is quite annoying even for people that have used it for a
while, so we thought: what about coding a user-friendly, good ol' GUI?

We could have started writing it from the roots, producing (in the best case)
a faintly working version in at least one month of work.  Luckily we were smart
enough to make some research first, and we discovered that we were not the first
to have such a lovely idea: in fact, [something called jGNUplot has already been
developed and released](http://jgp.sourceforge.net/).  The project, brilliantly
coded by Maximilian H. Fabricius, is based on the Java Swing library, and it is
fully functional in its features.  The problem is, it hasn't been developed
since 2006, consequently its look is a bit old fashioned in respect to the
expectation of a user living in 2017.

After having asked the original creator for permission, we moved the project on
[GitHub](https://github.com/hopandfork/jgnuplot): the plan is to get the best
out a project that *works*, adding some features that we have in our mind and
that we will reveal in the next few weeks (no spoilers!).  Currently we are
doing a bit of code refactoring before starting to add anything.

This project is bigger than anything we have ever done as Hop and Fork: we are
thrilled to dive deep into development and release a ton of new features. As
always, the more feedback we get, the more useful could jGNUplot be to our
followers. Stay tuned for the next release!

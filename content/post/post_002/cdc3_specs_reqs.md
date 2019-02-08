---
title:          "CDC3 Specifications/Requirements"
date:           2019-02-07T10:10:00
description:    "Specifications and Requirements for Ice-Energy 3rd-generation Controller"
draft:          false
cover:          "/sharedhugo/img/cover_cdc3specs.jpg"
menu:           main
tags:
- CDC3
categories:
- Systems/Solutions
---

![pic1](../img/cdc3specs.jpg)

---

This document will provide a list of specifications and requirements for the CDC3
controller.

---



# CPU requirements

The picture below shows the existing board architecture on CDC1/CDC2,
and it also shows the changes proposed for CDC3.

![pic2](../img/cdc_arch.jpg)

The architectures are strikingly similary:

 - Both have a seperate Network Controller on the Front-End

 - Both have a beefy 32-bit CPU on the back-end for handling all the controls and sensors.

A newly updated CDC3:

 - Replaces Blackfin CPU with more highly integrated and standard ARM CPU

 - Uses highly functional Linux Single Board Computer for the network front-end.


**CDC Controller CPU**
<div><div><div>
```
STM32407IG:  ARM Cortex-M4 core with DSP and FPU, 1 Mbyte Flash, 168Mhz, ART Accelerator.
192+4 Kbytes SRAM including 64-Kbyte of CCM data RAM
```

The 407IG is a more highly integrated part than the Blackfin, and there are several
chips external to the Blackfin that are no longer needed due to the 407IG having the
functionality built-in and on-chip.    Chip savings include:

 - Real-Time clock
 - the i2c DAC chip
 - Flash memory
 - Ram memory
 - the 8MB spi flash chip

</div></div></div>
**CPU Reference Platform**
<div><div><div>

 [armstrap.org/eagle](http://armstrap.org/eagle/)

 [Schematic](https://ice-energy.github.io/sharedhugo/post/post_002/img/Schematic.pdf)

![pic3](../img/eagleboard.jpg)

</div></div></div>
**On-Board JTAG debugger**
<div><div><div>

The reference platform from above includes an additional CPU which then
serves as a dedicated JTAG debugger.

Any of the STM32F103 family of processors will work for this, for example:

  - STM32F103C8T6

</div></div></div>
**Linux SBC**
<div><div><div>

Candidates for Linux SBC include:

 - [beaglebone on a module](http://beaglecore.com/)
 - [Raspberry Pi on a module](https://www.raspberrypi.org/products/compute-module-3/)
 - [dart modules variscite](https://www.variscite.com/products/system-on-module-som/)

Any of these will work and some are more integrated than others (including wifi).

I am in favor of the Raspberry Pi Compute Module, mainly due to the
Software and Distro support.

![pic4](../img/computemodule.png)


</div></div></div>

---








# How'd you do that?

While Github is known as a source code repository, it is also something else:

> If the repository you are storing ALSO happens to be a Static Website,
  Github can serve up pages from the site.

**Let that sink in!**

```

It's completely unprecendented to have your code repository
ALSO serve up web-pages that happen to be stored there.

The key concept is that checking in your code and pushing
the resulting git branch to the server is EQUIVALENT to publishing
your website.

It's a new paradigm, and it's really incredible.  It makes
Documentation Management incredibly easy!

```

With proper configuration of the github repository, and proper layout
of the data you are storing there, **github can serve up the pages**.

With Hugo installed locally on my linux workstation, here's the process I use
for creating that website:

   - edit content, simple .txt file
   - Run Hugo from within a shell script.  This generates the entire static site.
   - use git to check-in changes, and push to Server
   - browse to site, wait a bit for changes to propagate



# How do you keep documents private?

1st of all, pay the $99 fee.   That means the repositories are private, but the
website pages are not.    The key is knowing where the publicly
browsable files are, and not putting private documents there.

The solution to pub/priv relies on a logical arrangement of the source code tree.

See the repositories at:

 - [github.com/ice-energy/jreed](https://github.com/ice-energy/jreed)
 - [github.com/ice-energy/user1](https://github.com/ice-energy/user1)
 - [github.com/ice-energy/user9](https://github.com/ice-energy/user9)

Each of those repo's have 2 content directories, which are the *Source Material* of
the documents.

 - [content_pub](https://github.com/ice-energy/jreed/tree/master/content_pub) &nbsp; &nbsp; &nbsp;  publicly browsable content.
 - [content_priv](https://github.com/ice-energy/jreed/tree/master/content_priv) &nbsp; &nbsp; &nbsp; private content, not to be displayed on github.

My technique for public/private then is to generate 2 different
sites, that are completely seperate:

   - One meant for public viewing on github
   - The 2nd one stored on github, **But must be copied somewhere else to be displayed**

To do this requires executing Hugo twice while using the proper Source and
Destination flags.

*For the publicly visible:*

```
  hugo -c "./content_pub" -d "./docs"
```

*To remain private:*

```
  hugo -c "./content_priv" -d "./docs_priv"
```

The 2 output directories, *docs* and *docs_priv*, are both:

>  Standalone, Static, Hugo-Based Websites

*docs* gets displayed by github as default.  *docs_priv* will have to
be copied somewhere else to be displayed.


# A few more notes

See the file [x.sh](https://github.com/ice-energy/jreed/blob/master/x.sh).
It's the shell script that automates the running of Hugo.


My platform is *linux*, there'd be just a bit of work to do getting this
to run on Windows.   *x.sh* might have to be turned into a .bat file.
Haven't done that yet.    *Hugo* is supposed to run fine on Windows, but
again, something I haven't done yet.

Hugo should also be supported on Mac.

I'd be glad to help anyone get this up and running for themselves.
Also, it's not too difficult to set up different themes from gohugo.io.


JR




























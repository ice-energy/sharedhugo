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

<br><br>
The architectures are strikingly similary:

 - Both have a seperate Network Controller on the Front-End
 - Both have a beefy 32-bit CPU on the back-end for handling all the controls and sensors.

A newly updated CDC3:

 - Replaces Blackfin CPU with more highly integrated and standard ARM CPU
 - Uses highly functional Linux Single Board Computer for the network front-end.

### CDC Controller CPU
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

### CPU Reference Platform

 [armstrap.org/eagle](http://armstrap.org/eagle/)

 [Schematic](https://ice-energy.github.io/sharedhugo/post/post_002/img/Schematic.pdf)

![pic3](../img/eagleboard.jpg)

### On-Board JTAG debugger

The reference platform from above includes an additional CPU which then
serves as a dedicated JTAG debugger.

Any of the STM32F103 family of processors will work for this, for example:

  - STM32F103C8T6

### Linux SBC

Candidates for Linux SBC include:

 - [beaglebone on a module](http://beaglecore.com/)
 - [Raspberry Pi on a module](https://www.raspberrypi.org/products/compute-module-3/)
 - [dart modules variscite](https://www.variscite.com/products/system-on-module-som/)

Any of these will work and some are more integrated than others (including wifi).

I am in favor of the Raspberry Pi Compute Module, mainly due to the
Software and Distro support.

![pic4](../img/computemodule.png)

---

# Digital Sensor Bus

The standard 8 port 1-Wire solution from CDC1 will be used.

IceBears' currently use up to 5 of the 1-Wire ports:

 - I0.OAt, A1.SAt, A1.RAt, A2.SAt, A2.RAt

Only temperature type 1-Wire sensors are used.    There's place-holders in the code
to use other type of sensors (humidity for example), but they are not ever used.

### 1-Wire Connectors

These sensors are frequently installed in the field, so they need to be easy to work with
for the technicians.

Keep the connectors same as in CDC1.  
This means the techs will not have to crimp wires in the field.

![pic5](../img/onewireconnectors.jpg)

---

# Digital Inputs

There are 2 categories of Digital Inputs:

   - need 8: standard 0-5v GPIOs 
   - need 7: 24V AC/DC   (round to 8??)

### 5v Digital Inputs

The standard header that is used on CDC1 for Digital Inputs
can be used.   In addition to the actual Pin ports, there are
extra ports for 5v and GND.   Those can remain.

![pic6](../img/digioconnectors.jpg)

4 of the Digital Inputs are mapped to:

 - Make Ice
 - Melt Ice
 - System Off
 - System Bypass

The other 4 are used for Bear functionality:

 - I0.RPd3 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; is the refrigerant pump fault
 - TargetCompOn2  &nbsp; optional, indicates if Target Compressor #2 is on
 - DR1 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; reflects state of DR #1 device
 - DR2 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; reflects state of DR #2 device

Needs for TargetCompOn2, DR1, DR2 as digital inputs would go away
when these signals are more properly mapped to 24V AC/DC.   Right
now the techs have to wire these up with external relays.

### 24V AC/DC Digital Input.

&nbsp; &nbsp; (2VDC / 3VAC Threshold)

Right now, the Bear has 4 of these ports: I1, I2, I3, I4.
They are used for:

 - Z1S1  &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;   zone #1 call for cooling
 - Z2S1    &nbsp; &nbsp; &nbsp; &nbsp;  &nbsp; &nbsp;zone #2 call for cooling
 - RDisable1 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; Remote Disable signal from zone #1
 - TargetCompOn1  &nbsp; Reflects state of Target Compressor #1

![pic7](../img/in24vconnectors.jpg)

3 additional high-voltage inputs could be utilized for signals
currently being routed to the 5v inputs:

 - TargetCompOn2
 - DR1
 - DR2








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




























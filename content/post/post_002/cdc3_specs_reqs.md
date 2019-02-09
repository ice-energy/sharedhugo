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

![pic01](../img/cdc3specs.jpg)

<br>

---

<br>

# Quick Summary

This document will provide a list of specifications and requirements for the CDC3
controller.

<br>

---

# Note on Connectors

For physical connectors on-board, the 2 categories of connector types are:

 - screw terminal/push-pin: &nbsp; Wires need stripping
 - molex: &nbsp; &nbsp; Wires need stripping and crimping and a connector

The general consensus (Ian and Tom primarily) is that for wires that land in the field
the connector type should be screw-terminal/push-pin.

For wires that are primarily connected up at the factory, make the connectors molex.

![pic01a](../img/ConnectorTypes.jpg)

---

# CPU requirements

The picture below shows the existing board architecture on CDC1/CDC2,
and it also shows the changes proposed for CDC3.

![pic02](../img/cdc_arch.jpg)

<br><br>
The architectures are strikingly similar:

 - Both have a seperate Network Controller on the Front-End
 - Both have a beefy 32-bit CPU on the back-end for handling all the controls and sensors.

A newly updated CDC3:

 - Replaces Blackfin CPU with more highly integrated and standard ARM CPU
 - Uses highly functional **and Extremely Flexible** Linux Single Board Computer for the network front-end.
 - migrates Data Storage to on-board flash of Linux SBC

## CDC Controller CPU
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

## CPU Reference Platform

 [armstrap.org/eagle](http://armstrap.org/eagle/)

 [Schematic](https://ice-energy.github.io/sharedhugo/post/post_002/img/Schematic.pdf)

![pic03](../img/eagleboard.jpg)

## On-Board JTAG debugger

The reference platform from above includes an additional **on-board** CPU which
serves as a dedicated JTAG debugger.

Any of the STM32F103 family of processors will work for this, for example:

  - STM32F103C8T6

## Linux SBC

Candidates for Linux SBC include:

 - [beaglebone on a module](http://beaglecore.com/)
 - [Raspberry Pi on a module](https://www.raspberrypi.org/products/compute-module-3/)
 - [dart modules variscite](https://www.variscite.com/products/system-on-module-som/)

Any of these will work and some are more integrated than others (including wifi).

I am in favor of the Raspberry Pi Compute Module, mainly due to the
Software and Distro support.

![pic04](../img/computemodule.png)

### Data Storage

With CDC1 and CDC2, data storage was limited to 2MB of flash, plus an extra 8MB of SpiFlash (which as
of 2/7/2019 has yet to be implemented).    Total of 10MB of data storage.

CDC3 with the **Raspberry-Pi Compute Module** would have approximately 3GB (Giga!) of storage, and that
is **WITHOUT** an sdcard.    The flash part in the compute module is 4GB.  Linux OS, and 'other' are
roughly 1GB.    That leaves an **easy** 3GB for data storage.

```
On CDC1 and CDC2, data storage was on the control-side of things (Blackfin)
On CDC3, data storage will migrate to the Host (Linux SBC).
```

---

# Sensors/Controls: &nbsp; 1-Wire Bus

The standard 8 port 1-Wire solution from CDC1 will be used.

IceBears' currently use up to 5 of the 1-Wire ports:

 - I0.OAt, A1.SAt, A1.RAt, A2.SAt, A2.RAt

**Only temperature type 1-Wire sensors are being used**.    There are place-holders in the code
to use other type of sensors (humidity for example), but they are not ever used.

## 1-Wire Connectors

These sensors are frequently installed in the field, so they need to be easy to work with
for the technicians.

Keep the connectors same as in CDC1.  
This means the techs will not have to crimp wires in the field.

![pic05](../img/onewireconnectors.jpg)

---

# Sensors/Controls: &nbsp; Digital Inputs

There are 2 categories of Digital Inputs:

   - need 8: &nbsp; standard 0-5v GPIOs 
   - need 7: &nbsp; 24V AC/DC  &nbsp; &nbsp; (round to 8??)

## 5v Digital Inputs

The standard header that is used on CDC1 for Digital Inputs
can be used.   In addition to the actual Pin ports, there are
extra ports for 5v and GND.   Those can remain, as they have
proven valuable.

![pic06](../img/digioconnectors.jpg)

4 of the Digital Inputs are mapped to Ice-Bear Modes:

 - Make Ice
 - Melt Ice
 - System Off
 - System Bypass

The other 4 are used for Bear functionality:

 - I0.RPd3 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; is the refrigerant pump fault
 - TargetCompOn2  &nbsp; optional, indicates if Target Compressor #2 is on
 - DR1 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; optional, reflects state of DR #1 device
 - DR2 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; optional, reflects state of DR #2 device

Needs for TargetCompOn2, DR1, DR2 as 5v Digital Inputs would go away
when these signals are more properly mapped to 24V AC/DC.   Right
now the techs have to wire these up with external relays.

### New Functionality on Digital Input Pins

The requirement is to handle an incoming **PWM Signal**, and the idea for this
largely comes from Greg Miller.

A **PWM Input Signal** could be used in conjunction with a solar installation
(just one application) to indicate the amount of power that can be delivered
to the Bear.   A duty cycle of (for example) 60% would mean that the Bear could
turn on it's compressor and start Making Ice.

```
Any of the Input pins on the Blackfin (CDC1) could be programmed as a
PWM input signal today.   There would need to be a very minor setup change
on the pin, and then a more significant change to read the incoming signal
and take some action based on that.
```

Example PWM signal with 75% duty cycle shown below:

![pic06a](../img/pwmsignal.png)


## 24V AC/DC Digital Input.

&nbsp; &nbsp; (2VDC / 3VAC Threshold)

The Bear has 4 High-Voltage Input ports: I1, I2, I3, I4.
They are used for:

 - Z1S1  &nbsp; &nbsp; &nbsp; &nbsp;  &nbsp;  &nbsp; zone #1 call for cooling
 - Z2S1  &nbsp; &nbsp; &nbsp; &nbsp;  &nbsp;  &nbsp; zone #2 call for cooling
 - RDisable1 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; Remote Disable signal from zone #1
 - TargetCompOn1  &nbsp; Reflects state of Target Compressor #1

![pic07](../img/in24vconnectors.jpg)

3 additional high-voltage inputs could be utilized for signals
currently being routed to the 5v inputs:

 - TargetCompOn2
 - DR1
 - DR2

Connector for these signals can be molex type, although it is expected
that TargetCompOn2, DR1, and DR2 will be all landed in the field.
Potential for screw terminals.

---

# Sensors/Controls: &nbsp; Digital Outputs

There are 4 categories of Digital Outputs:

  - need 5: &nbsp; 5v DC (10ma)
  - need 2: &nbsp; AC/DC SSR (24v,2a)
  - need 6: &nbsp; AC SSR (24V,4A)
  - need 8: &nbsp; AC SSR (240V, 7a)


## 5v Digital Outputs

These are standard 5v GPIO output signals.   Again would like to use the same
style connector as CDC1 due to the output wires typically needing to be landed
out in the field.

![pic08](../img/5vconnector.jpg)

On CDC1/CDC2 there are 4 GPIO output pins.   1 is assigned permanently,
and 2 are optional:

 - I0.RPd2 &nbsp; &nbsp; &nbsp; turns on the refrigerant pump
 - DR1 &nbsp; &nbsp; &nbsp; &nbsp; Demand Response #1 signal &nbsp; (optional)
 - DR2 &nbsp; &nbsp; &nbsp; &nbsp; Demand Response #2 signal &nbsp; (optional)

**CDC3 requirement is for 5 GPIO output pins**.

The 5v output pins have proven versatile, and valuable for
one-offs, and development/debugging.

Other **POTENTIAL** uses for the 5v outputs include interfacing to
external hardware and using the signals to indicate
status:

 - **ChargeStatus:** &nbsp;        When the unit is making Ice
 - **FaultStatus:** &nbsp; &nbsp;  When the unit needs servicing by a technician
 - **RPumpStatus:** &nbsp;         When the refrigerant pump is operating
 - **MeltWStatus:** &nbsp;         When the bear is in the melt window
 - **QIceStatus:**  &nbsp; &nbsp;  PWM output signal to reflect quantity of Ice in tank

Note that there is opportunity to move the DR1 and DR2 signals to **24v AC** pins.
(see section below)


## 24v AC/DC Outputs Solid-State-Relay (@ 2a)

On CDC1, there are 2 of these: labeled S7 and S8.

![pic09](../img/24vACDCconnector.jpg)

They are used for the following 2 outputs:

 - IUIC1
 - IUIC2

**The same 2 Output ports are needed on CDC3**.

Connectors: Molex.


## 24v AC Outputs Sold-State-Relay (@ 4A)

On CDC1, there are 4 of these: labeled S9,S10,S11,S12.

![pic10](../img/24vACconnector.jpg)

They are used for the following 4 outputs:

 - Z1SV &nbsp; &nbsp; &nbsp; &nbsp; Zone #1 Solenoid Valve
 - Z2SV &nbsp; &nbsp; &nbsp; &nbsp; Zone #2 Solenoid Valve
 - Fan2Relay &nbsp; Fan Relay
 - CPCont &nbsp; &nbsp; &nbsp; Compressor Contactor

2 additional 24vAC Outputs are needed for DR:

 - DR1 &nbsp; Demand Response #1
 - DR2 &nbsp; Demand Response #2

**Total of 6 24v AC Outputs on CDC3**.

## 24v AC Outputs Sold-State-Relay (@ 4A)


























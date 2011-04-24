Chapter 10 Linux Binary Compatibility
==================================================

Add the following line to `/etc/rc.conf` ::

    linux_enable="YES"

Install Linux runtime library ::

    pkg_add -r emulators/linux_base-f10  x11/linux-xorg-libs

`/compat/linux/` is used as `shadow root` for  libraries on your FreeBSD system

Chapter 11 Configuration and Tuning
========================================

11.3 Core Configuration
------------------------------

The **principal** location for system configuration is `/etc/rc.conf`.

An administrator should make entries in the `rc.conf` file to **override** the
default settings from `/etc/defaults/rc.conf`.

`rc.conf` is read by `sh(1)` .

Normally, when a port or package is installed, **sample configuration** files are
also installed. These are usually identified with a `.default` suffix.

11.6 Configuring the cron Utility
----------------------------------------

The cron utility uses two different types of configuration files, the **system**
crontab and **user** crontabs. The only difference between these two formats is
the **sixth field**. In the system crontab, the sixth field is the name of a
user for the command to run as. This gives the system crontab the ability to run
commands as any user. In a user crontab, the sixth field is the command to run,
and all commands run as the user who created the crontab; this is an important
security feature.

11.7 Using rc under FreeBSD
------------------------------

Users should notice the files listed under `/etc/rc.d/` .

Since the rc.d system is primarily intended to start/stop services at system
startup/shutdown time, the standard start, stop and restart options will only
perform their action if the appropriate /etc/rc.conf variables are set. to
restart sshd **regardless** of the current /etc/rc.conf setting, execute the
following command ::

    /etc/rc.d/sshd onerestart

information about dependencies and other meta-data is included in the
**comments** at the top of each startup script. The `rcorder(8)` program is then
used to **parse** these comments during system initialization to determine the
**order** in which system services should be invoked to satisfy the dependencies.

11.11 Tuning with sysctl
==============================

`sysctl(8)` is an interface that allows you to make changes to a running
FreeBSD system. Over 500 system variables can be read and set using sysctl(8).

To view all readable variables ::

    % sysctl -a

To read a particular variable ::

    % sysctl kern.maxproc

To set a particular variable ::

    # sysctl kern.maxfiles=5000

If you want to set some variables **permanently**, add them to `/etc/sysctl.conf`


11.12 Tuning Disks
====================

The `tunefs(8)` program can be used to fine-tune a file system, including
**toggling** Soft Updates on and off ::

    # tunefs -n enable /filesystem
    # tunefs -n disable /filesystem

Soft Updates **drastically** improves meta-data performance, mainly file creation
and deletion, through the use of a memory cache. We **recommend** to use Soft
Updates on all of your file systems.

11.15 Power and Resource Management
========================================

ACPI is the direct **successor** to APM.

Chapter 12 The FreeBSD Booting Process
==================================================

12.2 The Booting Problem
------------------------------

The code within the `MBR` is usually referred to as a **boot manager**,
especially when it interacts with the user. A boot manager is sometimes also
called a **boot loader**, but FreeBSD uses that term for a **later stage** of
booting. Popular boot managers include boot0, grub, etc.

If you have only one OS installed on disk then a **standard** PC MBR will
suffice. This MBR searches for the first **bootable** (a.k.a. active) slice on
the disk, and then runs the code on that slice to load the remainder of the
operating system. The MBR installed by `fdisk(8)`, by default, is such an MBR.
It is based on `/boot/mbr`.

The FreeBSD bootstrap system is divided into **three stages**. The first stage
is run by the MBR, which knows just enough to get the computer into a specific
state and run the second stage. The second stage can do a little bit more,
before running the third stage. The third stage finishes the task of loading the
operating system.

The work is **split** into these three stages because the **PC standards put
limits** on the size of the programs that can be run at stages one and two.
Chaining the tasks together allows FreeBSD to provide a more flexible loader.

The kernel is then started and it begins to **probe** for devices and
**initialize** them for use. Once the kernel boot process is finished, the
kernel passes control to the user process `init(8)`, which then makes sure
the disks are in a usable state. init(8) then starts the user-level resource
configuration which mounts file systems, sets up network cards to communicate on
the network, and generally starts all the processes that usually are run on a
FreeBSD system at startup.

12.3 The Boot Manager and Boot Stages
----------------------------------------
The code in the MBR is sometimes referred to as **stage zero** of the boot process

The MBR installed by FreeBSD's installer or `boot0cfg(8)`, by default, is based
on `/boot/boot0` .

12.3.2 Stage One, /boot/boot1, and Stage Two, /boot/boot2
------------------------------------------------------------

They are copied to disk from the combined file `/boot/boot` by the installer or
`bsdlabel`.

They are located **outside** file systems, in the first track of the boot slice

12.3.3 Stage Three, /boot/loader
------------------------------------

This program is located **on** the file system.

The loader will read `/boot/loader.rc`, which by default reads in
`/boot/defaults/loader.conf` which sets reasonable **defaults** for variables
and reads `/boot/loader.conf` for **local** changes to those variables.




1. prepare partition
====================
Create a Ext3 partition and mount it ::

    mkdir /mnt/alfs
    mke2fs -jv /dev/<xxx>
    mount -t ext3 /dev/<xxx> /mnt/alfs

2. prepare user
====================

Create a new user `alfs` dedicated for running jhalfs ::

    groupadd lfs
    useradd -s /bin/bash -g alfs -m -k /dev/null alfs

Grant the sudo previlege to user `alfs`::

    visudo

Make sure `/mnt/alfs` is **writable** to user `alfs` ::

    chown -R alfs:alfs /mnt/alfs


3. config jhalfs
====================

Login as user `alfs` ::
    su -l alfs

Config jshlfs in a menu-driven way ::

    cd jhalfs
    make

Some important configuration entries:

    *   General setttings

        -   Default user/group: change it to `alfs/alfs`

        -   Build directory : change it to `/mnt/alfs`       -

        -   Retrieve sources : Yes

        -   Always retrieve kernel : Yes

        -   Run the makefile : Yes

    *   Build setttings

        -   Run testsuites :

        -   Create installed files log : Yes

        -   Use custom fstab:  No

        -   Build kernel : No

        -   Strip binaries and libraries : Yes

        -   Timezone : set to `GMT`

        -   Langeuage : set to `en_US.UTF-8`


    *   Build setttings

        -   Create SBU report :  Yes


    *   Rebuild Makefile : No

Then exit and save the configuration, then `jhalfs` will run automatically


4. Manual work
===============

First, `chroot` by running a helper script ::

    chroot-alfs

Set the password of user `root` ::

    passwd root

Costom following confiruation files to your need ::

    /etc/fstab
    /etc/hosts
    /etc/resolv.conf
    /etc/sysconfig/clock
    /etc/sysconfig/network
    /etc/sysconfig/network-devices/ipconfig.eth0/ipv4

Build kernel ::

    make mrproper
    make menuconfig
    make
    make modules_install
    cp arch/i386/boot/bzImage /boot/alfs-kernel

Add boot entry for alfs in grub ::

    vi /boo/grub/menu.lst


5. Tips
==========

The layout below $BUILDDIR(`/mnt/alfs`) is as follows ::

    $BUILDDIR/
        jhalfs      (Makefile, cmd scripts, logs, etc..)
        sources     (where packages reside)
        tools       (temporary bootstrap system)



Q. "How could I stop the build at a predefined chosen point?"

A. Launch the Makefile manually passing the last numbered target to be build
as the break point. For example::

    make BREAKPOINT=84-bash

The build can also be stopped at the end of a top-level build phase by calling
directly the appropriate mk_* target. For example::

    make mk_LUSER





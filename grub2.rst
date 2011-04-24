Chapter 1. Introduction
==============================

Grub2 understands **filesystems** and **executable formats**.

`grub.cfg` is now written in something quite close to shell script.

The UI of Grub2 **support i18n**.

Grub2 support automatic decompression of file created by `gzip` or `xz`

Chapter 2. Naming convention
==============================

Grub2 requires all device names be enclosed with `( )` .

partition numbers for **extended partitions** are counted from 5, **regardless**
of the actual number of **primary partitions** on your hard disk.

Grub2 does **NOT** distinguish `IDE` from `SCSI`.

Chapter 3. Installation
==============================

Two relational but **different** terminologies:

    *   `image directory`: where boot images are **initially** placed
        (normally `/usr/lib/grub/i386-pc/` )


    *   `boot directory` : where boot images are **finally** placed so
         that boot loader can find them( normally `/boot/grub/` )

Most operating systems don't tell GRUB how to map BIOS drives to OS devices
correctly --- Grub2 merely guesses the mapping. Therefore, Grub2 provides you
with a map file called the `device.map`, which you need fix if it is wrong.


`grub-install`  is just a shell script and the real work is done by :

    *   `grub-mkimage` :  install `boot images` under `boot direcory`

    *   `grub-setup` : write `boot.img` (512 byte boot loader) into `MBR`


`grub-mkrescue` is used to create generic grub-bootable ISO.

`grub-mkdevicemap` is  used to create `device.map` . It is usually called
automatically by tools such as `grub-install` if `device.map` does not
exist yet.


Chapter 4. Booting
==============================

Operating systems that do not support **Multiboot** must be **chain-loaded**,
which involves another boot loader

However, Grub2 provide **special support** for Linix/BSD systems. so then
can be booted directly by Grub2.

Windows **CAN NOT** boot from any disks but the first one. Shame on M$!


Chpater 5. Writing your own configuration file
==================================================

 `/etc/default/grub` and `/etc/grub.d/*` are used as reference by `grub-mkconfig`
to generate the `grub.cfg`

`/etc/default/grub` will be **sourced** by a shell script, so it must contain
valid POSIX shell input

`grub.cfg` is written in GRUB2's built-in scripting language, which has a syntax
quite similar to that of GNU Bash.


Chapter 10. GRUB image files


Chapter 17. Error messages produced by GRUB
==================================================

GRUB2's normal start-up procedure involves setting the `prefix` variable to a
value set in the core image by `grub-install`, setting the `root` variable to
match, loading the `normal` module from the prefix, and running the `normal`
command. That command is responsible for reading `/boot/grub/grub.cfg`, running
the menu, and doing all the useful things GRUB is supposed to do.

If you are dropped in to the rescue shell of Grub2, you can enter normal mode
manually ::

    set prefix=(hd0,1)/grub
    set root=(hd0,1)
    insmod normal
    normal

Installing Grub2(actually the boot loader) into **MBR** is **normally more
robust** than installing into the **boot sector** of some partition.


99. Misc
==========

`grub-reboot` can be used to setup the default entry for next boot.

If using a splash image, make sure the resolution setting and the splash image
size are **compatible**.

command `ls` , when used  alone, will list all partitions known to Grub2

`set pager=1` is a very handy tip.

Configuring a boot splash image is a **two step process**: selecting the image
to use and choosing the text colors to be displayed.




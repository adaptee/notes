1. Preparation of kernel
=============================

-   make sure the framebuffer driver is **builtin**, not as module.

-   **enable** "Framebuffer Console support" (FRAMEBUFFER_CONSOLE)

-   **disable** "Tile Blitting Support" (FB_TILEBLITTING)

-   **enable** " Device Drivers -> Input Device Support -> Event Interface "


2. Installation
=================

`emerge -av splashutils splash-themes-gentoo splash-themes-livecd`


3. Configuration
====================

-   modify /etc/conf.d/splash and /etc/conf.d/fbcondecor to your taste

-   add new service : `rc-update add fbcondecor default`

3. Generate initramfs
==============================

-   edit genkernel's `/usr/share/genkernel/defaults/initrd.defaults`,
    change ::

        CONSOLE=/dev/console

    to ::

        CONSOLE=/dev/tty1

-   create initramfs with ::

    genkernel ramdisk --splash=<theme> --splash-res=<resolution>


4. Configure BootLoader
==============================

Example entry for Grub ::

    kernel /vmlinuz... video=... splash=verbose,theme:emergence console=tty1
    initrd /initramfs-genkernel-x86-2.6.38.2-zen+




Chapter 1. Introduction
==============================

BLFS is **NOT** designed to be followed straight througn. However, please **DO**
read Chapter 1 & 2.

Chapter 2. Important infomation
=================================

BLFS **recommends** that you build software as an **unprivileged user** and only
become the root user when installing the software.

`$PIPESTATUS` is a array containing the exit codes from processes in the
recently-executed pipeline.

If you discover that a package will not build or work properly, you should see
if there is a **newer version** of the package.

2.2 The `/usr` Versus `/usr/local` Debate
============================================

In **traditional Unix** , `/usr` usually contains files that come with the
**system distribution**, and the `/usr/local` tree is free for the **local
administrator** to manage. The only really **hard and fast rule** is that Unix
distributions should not touch `/usr/local`.

With Linux distros possible rule is that `/usr` is managed by the distribution's
**package system** and /usr/local is not.

All of the BLFS instructions install programs in `/usr`

It is assumed that you will be using the **BLFS Bootscripts** package in
**conjunction** with a compatible **LFS-Bootscripts** package.

2.5 Locale issues
====================

The POSIX standard mandates that the filename encoding is the encoding **implied**
by the current `LC_CTYPE` locale category.

Chapter 3. After LFS Configuration Issues
=============================================

The `useradd` program uses a collection of **default values** kept in
`/etc/default/useradd`

`/etc/skel` should be **writtable only** by `root`.

LSB recommends that **system uid and gid** should be **below** 100.

65534 is conventionly assigned to user `nobody` and group `nobody`.

Many distributions use /etc/bashrc for system wide initialization of **non-login
interactive** shells. This file is usually **sourced** from the `~/.bashrc` and
is **NOT** built directly into bash itself.

`/etc/issue` is used to define the **logon** message.

If you would like to clear screen at each logon, run this ::
    clear > /etc/issue

`/etc/issue` can contain escape sequences those are recognizable by `agetty`,
which will parse that file.

`/etc/shells` is **consulted** by `chsh` to determine whether an **unprevileged**
user can change his own **login-shell**

The Linux kernel supplies a **random number generator** which is accessed
through `/dev/random` and `/dev/urandom`.


Chapter 4. Security
====================

PAM
----------

PAM uses the `pam_access.so` module along with the `/etc/security/access.conf`
for controlling the access to system.

PAM uses the `pam_limits.so` module along with the `/etc/security/limits.conf`
for limiting the use of system resources.

Heimdal
--------

Heimdal is a free implementation of Kerberos 5 authentication protocol.


sudo
----------

Some important compilation switches:

    *   `--with-ignore-dot` : causes sudo to **ignore** '.' in the `PATH`.

    *   `--disable-root-sudo` : keeps `root` from running `sudo`

Chapter 8. General Libraries
==============================

glib
----------

By default, GLib **assumes** that all filenames are in the `UTF-8` encding. In
order to tell GLib that filenames are in the default locale encoding, set the
environment variable `G_FILENAME_ENCODING` to the value `@locale` :

lzo
----------

LZO is a data **compression library** which is suitable for data decompression
and compression in **real-time**. This means it **favors speed** over ratio.

xcb-proto
-----------

The package provides the **XML-XCB** protocol **descriptions** that `libxcb`
uses to **generate** the majority of its code and API.

Chapter 10. General Utilities
==============================

desktop-file-utils
--------------------

`/usr/share/applications/mimeinfo.cache` can be rebuilt by ::

    update-desktop-database /usr/share/applications

Chapter 11. System Utilities
==============================

Fcron
----------

Fcron package contains a **periodical** command scheduler which aims at
**replacing** Vixie Cron.

Chapter 16. Basic Networking Programs
========================================

inetutils
----------

Most of the **server daemons** provided by `inetutils` are **insecure** and
should only be used on trusted networks.

wireless-tools
---------------

The `Wireless Extension` (WE) is a **generic API** in the Linux kernel allowing
driver to **expose configuration and statistics** specific to common Wireless
LANs **to user space**.

The `Wireless Tools` (WT) package is a set of tools allowing manipulation of the
`Wireless Extensions`.

To use `Wireless Tools`, the kernel must have the appropriate drivers. After
the **correct drivers** are loaded, the wireless interface will appear in
`/proc/net/wireless`.


Chapter 23. X Window System Environment
========================================

Xorg-7.6 introduces a **modular** and completely **autotool-based** build system
, which requires installing more than 100 different packages.

The old convettion is intalling X Window System under `/user/X11R6`, but the
current common installation prefix on Linux is `/usr`.

The `Xorg` binary **must** run as `root` .


Configuring The X Window System
-----------------------------------

If you use the NVIDIA binary drivers, remove `dri` from the `Modules` settion
in `xorg.conf`

You can change the **keyboard autorepeat rate** by adding on line as blow into
the `InputDevice` section::

    Option "Autorepeat" "250 30"

When needed, the X Window System creates the directory `/tmp/.ICE-unix` if it
does not exist. If this directory is not owned by root, the X Window System
**delays startup** by a few seconds and also appends a warning to the logfile.

The **DRI devices** are not accessible for any user except `root` and members of
the `video` group.

There are **two font systems** in the X Window System:

    *   `Core X Font Protocol` : the old one, used by Motif and Gtk1

    *   `Xft Font Protocol` : the new one, used by Gtk2 and Qt
        It provides **antialiased** font rendering through `freetype`, and
        fonts are **controlled** from the client side using `fontconfig`.

Chapter 24. X Libraries

Qt4
----------

The default installation places the files in `/usr/local/qt/`. Many distros
place the files in the  `/usr` hierarchy.

Chapter 35. Multimedia Libraries and Drivers

alsa-lib
--------------
This is used by programs (including `alsa-util`) requiring access to the ALSA
sound interface.

alsa-util
---------------
contains various utilities which are useful for **controlling** your sound card.

All sound devices are not **accessible** for any user except `root` and members
of the `audio` group.

alsa-tool
---------------
contains **advanced** tools for those with advanced requirement for sound cards.

libdvdcss
---------------
a simple library designed for **accessing** DVDs as a **block device** without
having to bother about the **decryption**.


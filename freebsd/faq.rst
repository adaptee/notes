Chapter 1 Introduction
==============================

1.7. What is the latest version of FreeBSD?
--------------------------------------------------

Briefly, `-STABLE` is aimed at the ISP, corporate user, or any user who wants
stability and a minimal number of changes compared to the new (and possibly
unstable) features of the latest `-CURRENT` snapshot. Releases can come from
either branch, but -CURRENT should only be used if you are prepared for its
increased volatility (relative to -STABLE, that is).

1.8. What is FreeBSD-CURRENT?
------------------------------

`FreeBSD-CURRENT` is the **development** version of the operating system, which
will in due course **become** the new `FreeBSD-STABLE` branch.

Every month, `snapshot` releases are made based on the current state of the
`-CURRENT` and `-STABLE` branches.

Chapter 3 Installation
==============================

3.20. Do I need to build a kernel?
-------------------------------------

Building a new kernel was originally pretty much a required step in a FreeBSD
installation, but more recent releases have benefited from the introduction of
much friendlier kernel configuration methods. It is very easy to configure the
kernel's configuration by much more flexible "hints" which can be set at the
loader prompt.

3.21. Should I use DES, Blowfish, or MD5 passwords?
------------------------------------------------------------

The default password format on FreeBSD is to use **MD5-based** passwords. These
are believed to be more secure than the traditional UNIX(r) password format,
which used a scheme based on the DES algorithm. FreeBSD also allows you to use
the Blowfish password format, which is more secure.

Which password format to use for new passwords is controlled by the
`passwd_format` login capability in `/etc/login.conf`, which takes values of
des, blf (if these are available) or md5. See the `login.conf(5)` manual page
for more information about login capabilities.

3.26. "archsw.readin.failed" after compiling and booting a new kernel?
---------------------------------------------------------------------------

Because your world and kernel are **out of sync**. Be sure you use
`make buildworld` and `make buildkernel` to update your kernel.

Chapter 4 Hardware Compatibility
========================================

4.5.1. Does FreeBSD support my USB keyboard?
--------------------------------------------------

FreeBSD supports USB keyboards out-of-the-box. Once you have USB keyboard
support enabled on your system, the AT keyboard becomes /dev/kbd0 and the USB
keyboard becomes /dev/kbd1, if both are connected to the system. If there is the
USB keyboard only, it will be /dev/ukbd0.

4.8.1. Does FreeBSD support power management on my laptop?
------------------------------------------------------------

FreeBSD supports **APM** on certain machines. Further information can be found
in `apm(4)`.

FreeBSD also supports the **ACPI** features found in most modern hardware.
Further information can be found in `acpi(4)`.

If a system supports both APM and ACPI, **either** can be used.


Chapter 5 Troubleshooting
==============================

5.21. Why does it take so long to connect to my computer via ssh or telnet?
----------------------------------------------------------------------------

The problem: more likely than not, the delay is caused by the server software
trying to **resolve** the client's IP address into a hostname. Many servers,
including the Telnet and SSH servers that come with FreeBSD, do this in order
to, among other things, store the hostname in a log file for future reference
by the administrator.

For ssh, you can turn off `UseDNS` in `sshd_config`.


Chapter 7 User Applications
==============================

7.5. I just tried to build INDEX using `make index`, and it failed. Why?
---------------------------------------------------------------------------

First, always make sure that you have a completely **up-to-date** Ports.

The general rule is that if you want to build INDEX, you must have a **complete**
copy of the Ports Collection.


7.6. Why is CVSup not integrated in the main FreeBSD tree?
============================================================

The FreeBSD base system is designed as **self-hosting** -- it should be possible
to build the whole operating system starting with a very limited set of tools.

Since `CVSup` is written in **Modula-3**, adding it to the FreeBSD base system
would also require adding and maintaining a Modula-3 compiler.

Since FreeBSD 6.2-RELEASE, `CVSup` was **rewritten** in C as `csup(1)` and it is
the part of the base system by now.


7.8. Do I need to recompile every port after a major version update?
-----------------------------------------------------------------------

Yes, Indeed!

Chapter 8 Kernel Configuration
==============================



8.1. I would like to customize my kernel. Is it difficult?
------------------------------------------------------------

Not at all!

The new kernel will be installed to the `/boot/kernel/` along with its modules,
while the old kernel and its modules will be moved to the `/boot/kernel.old/` .


8.3. Why is my kernel so big (over 10 MB)?
------------------------------------------------

Chances are, you compiled your kernel in **debug mode**.

8.6. How can I verify which scheduler is in use on a running system?
-----------------------------------------------------------------------

It is directly available as the value of the `kern.sched.name` ::

    % sysctl kern.sched.name

Chapter 9 Disks, File Systems, and Boot Loaders
--------------------------------------------------

9.23. How do I let ordinary users mount CD-ROMs and other removable media?
------------------------------------------------------------------------------



9.27. How is it possible for a partition to be more than 100% full?
--------------------------------------------------------------------

A portion of each UFS partition (8%, by default) is **reserved** for use by the
operating system and the root user. `df(1)` does not count that space when
calculating the Capacity column.


Chapter 10 System Administration
-----------------------------------

10.1. Where are the system start-up configuration files?
------------------------------------------------------------

The primary configuration file is `/etc/defaults/rc.conf`. System startup
scripts such as /etc/rc and /etc/rc.d (see rc(8)) just **include** this file.

**Do not edit this file**! Instead, you should copy the line into `/etc/rc.conf`
and change it there.

To start up **local services**, place scripts under `/usr/local/etc/rc.d/`

10.3. messages like "root: not found" after editing my crontab file?
----------------------------------------------------------------------

The **system ** crontab has a **different format** to the **per-user** crontabs

If you want something to be run once per day, week, or month, it is probably
better to add shell scripts under `/usr/local/etc/periodic/`, and let the
`periodic(8)` command run from the system cron .

10.4 "you are not in the correct group to su root" when I try to su to root?
-----------------------------------------------------------------------------

This is a **security feature**. In order to su to root, you must be in the
`wheel` group. If this feature were not there, anybody with an account on a
system who also found out root's password would be able to gain superuser level
access to the system.

10.5. My root filesystem is read-only. What should I do?
------------------------------------------------------------

Restart the system using `boot -s` at the loader prompt to enter **Single User
mode**. When prompted for a shell pathname, simply press **Enter**, and run
`mount -urw /` to **re-mount** the root file system in read/write mode.


10.9. Why can I not get quotas to work properly?
--------------------------------------------------

Do not turn on quotas on /.

Put the quota file on the filesystem that quotas are to be enforced on, i.e ::

    File System 	Quota file
    /usr 	        /usr/admin/quotas
    /home 	        /home/admin/quotas

10.10. Does FreeBSD support System V IPC primitives?
------------------------------------------------------

Yes, FreeBSD supports System V-style IPC, including shared memory, messages and
semaphores, in the GENERIC kernel.

10.12. I have forgotten the root password! What do I do?
----------------------------------------------------------

Boot into **Single user mode**, then execute `passwd root`

10.20. How do I re-read /etc/rc.conf and re-start /etc/rc without a reboot?
----------------------------------------------------------------------------

Go into single user mode and then back to multi user mode.

On the console do::

    # shutdown now (Note: without -r or -h)
    # return
    # exit

10.22. I tried to install a new kernel, and the chflags(1) failed.
--------------------------------------------------------------------

You are probably at **security level** greater than 0.

FreeBSD **disallows** changing system flags at security levels greater than 0.
You can check your security level with the command ::

    % sysctl kern.securelevel

You cannot lower the security level; you have to change the security level in
`/etc/rc.conf` then reboot.

10.30. What is /var/empty?
------------------------------

/var/empty is a directory that the `sshd(8)` program uses when performing
privilege separation. The /var/empty directory is **empty**, owned by root
and has the schg flag set.

11.6 "KDENABIO failed (Operation not permitted)" error when I type startx
-----------------------------------------------------------------------------

Your system is probably running at a **raised securelevel**. It is not possible
to start X at a raised securelevel because X requires write access to io(4).

11.7. Why does my mouse not work with X?
----------------------------------------

Starting with Xorg version 7.4, the `InputDevice` sections in `xorg.conf` are
**ignored** in favor of autodetected devices. To restore the old behavior, add
the following line to the `ServerFlags` section ::

    Option "AutoAddDevices" "false"

11.10. What is a virtual console and how do I make more?
----------------------------------------------------------

The default FreeBSD installation has eight virtual consoles enabled.To enable
more of them, edit `/etc/ttys` .

11.12. How do I start XDM on boot?
----------------------------------------

There are two schools of thought on how to start xdm(1). One school starts xdm
from `/etc/ttys`, while the other simply runs xdm from from `rc.local` (see rc(8))
or from an X script under `/usr/local/etc/rc.d/` .

If loaded from rc(8), xdm should be started without any arguments (i.e., as a
daemon). The `xdm` command must start **after** `getty(8)` runs, or else getty
and xdm will conflict, locking out the console.

Chapter 13 Security
=======================

13.2. What is securelevel?
------------------------------

The securelevel is a security mechanism implemented in the kernel. Basically,
when the securelevel is positive, the kernel restricts certain tasks; not even
the root is allowed to do them.

ecurelevel is **NOT** a silver bullet; it has many known deficiencies. More
often than not, it provides a **false sense of security**.

13.5. What is this UID 0 toor account?
----------------------------------------

toor is an "alternative" superuser account (toor is root spelt backwards). It is
intended to be **used with a non-standard shell** so you do not have to change
root's default shell.

Chapter 16 Miscellaneous Questions
========================================

16.1. FreeBSD uses far more swap space than Linux(r). Why?
-------------------------------------------------------------

The main difference between FreeBSD and Linux in this regard is that FreeBSD
will **proactively** move entirely idle, unused pages of main memory into swap in
order to make more main memory available for active use. Linux tends to only
move pages to swap as a **last resort**.

16.3. Why will chmod not change the permissions on symlinks?
--------------------------------------------------------------

Symlinks **do not have permissions**, and by default, `chmod(1)` will **follow**
symlinks to change the permissions on the source file, if possible.

16.8. What is sup, and how do I use it?
----------------------------------------

SUP stands for `Software Update Protocol`, and was developed by CMU for keeping
their development trees in sync. It was used to keep remote sites in sync with
the Project's central development sources.

SUP is not bandwidth friendly, and has been **retired**. The current recommended
method to keep your sources up to date is `CVSup`.





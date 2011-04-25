
Chapter 4. Final Prepareations
========================================

All programs compiled in Chapter 5 will be installed under $LFS/tools to keep
them **separate from** the programs compiled in Chapter 6.

One important step is to create a **symlink** on the **host** system ::

    ln -sv $LFS/tools /tools

That symlink enables the toolchain to be compiled so that it always refers to
/tools, meaning that the compiler, assembler, and linker will work both in
Chapter 5 (when we are still using some tools from the host) and in the next
chapters (when we are `chroot` to the LFS partition).

Setting `LC_ALL` to `POSIX` or `C` (the two are **equivalent**) ensures that
everything will work as expected in the chroot environment.

There is **little** to be gained from running the test suites in Chapter 5.

Chapter 5. Constructing a Temporary System
==================================================

5.1 Introduction
--------------------

This chapter shows how to build a minimal Linux system in two steps:

    1. build a temporary host-independent toolchain (compiler, assembler,
       linker, libraries)

    2. uses that toolchain to build the other temporary essential tools.

5.2. Toolchain Technical Notes
---------------------------------

The canonical name of working platform is oftern referered as `target triplet`.
Its format is `cpu-verdor-os`, and a typical example is `i686-pc-linux-gnu`. The
simplest way to get it is running the `config.guess` scripts in the source tree
of `binutils`.

A sure-fire way to determine the name of the dynamic linker/loader ::

    readelf -l <any executable> | grep interprete

or ::

    gcc -dumpmachine


5.2.1 binutils
~~~~~~~~~~~~~~~

`binutils` is installed first because the configure runs of both `GCC` and
`Glibc` perform various feature tests on the assembler and linker to determine
which features to enable or disable.

`binutils` installs its assembler and linker into two locations: /tools/bin and
/toos/$LFS_TGT/bin, **hard linked**.

One important facet of `ld` is its library search order.

The current library search order can be obtained in a simple way::

    ld --verbose | grep SEARCH

To sess which libraries are successfully linked by `ld` during linking ::

    gcc dummy.c -Wl,--verbose 2>&1 | grep succeeded

5.2.2 GCC
~~~~~~~~~~

The next pacakge installed is GCC.

**When** GCC is built, its configure script does **NOT** search the `PATH`
directories to find which tools(assembler, linker) to use.

To see which linker GCC will use **when** building other executables ::

    gcc -print-prog-name=ld

5.2.3 Glibc
~~~~~~~~~~~~

**After** GCC comes Glibc.

An important aspect of Glibc: very **self-sufficient** in terms of its build
machinery and generally does **NOT** rely on toolchain defaults.

After the run of `configure`, check the contents of the `config.make` file .

    = `CC="i686-lfs-gnu-gcc"` controls which **binary tools** are used

    = `-nostdinc` and `-isystem` controls the compiler's **include search path**.

5.2.4 Adjusting toolchain
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

**After** Glibc is installed, change GCC's `specs` file to point to the **new
and temporary** dynamic linker under /toos/lib. This ensure that all executables
compiled since now will use the dynamic linker under /tools/lib

A **hard-coded** path to a **dynamic linker** is embedded into every ELF
executables. To see that path, just run ::

     readelf -l <any executable> | grep interprete

5.2.5 binutils(pass 2)
~~~~~~~~~~~~~~~~~~~~~~~~

In this pass, we are able to  utilize the `--with-lib-path` switch to control
the **library search path** of the new `ld` to be created.

From this point onwards, the toolchain is **self-contained** and **self-hosted**.

5.2.6 GCC(pass 2)
~~~~~~~~~~~~~~~~~~~~~~~~

In this pass, its sources need to be modified to tell the GCC to be builtd to
use the **new dynamic linker** under /tools/lib .


5.4 binutils
--------------------

It is important that Binutils be **the first** package compiled because both
Glibc and GCC perform various tests on the available linker and assembler to
determine which of their own features to enable.

Some important configuration options:

    *   --target=$LFS_TGT : used for adjusting binutils's building system for
        building a **cross-linker**.

The library search path of the `ld` just installed is
`/tools/i686-lfs-linux-gnu/lib`

The linker installed in this section is **cross-compiled** and as such
**CANNOT** be used **until** `Glibc` has been installed.

5.6 GCC
--------------------

Some important configuration options:

    *   --target=$LFS_TGT :

    *   -disable-shared : force GCC to link to its internal libraries
        **statically**, avoding possbile issues with the host system.

    *   -enable-languages=c : only build the C compiler

One **IMPORTANT** fact : the newly built `i686-lfs-linux-gnu-gcc` will use `ld`
under `/tools/i686-lfs-linux-gnu/bin/` as linker.


5.7 Glibc
--------------------

Some important configuration options:

    *   `--host=$LFS_TGT`, `--build=xxx/scripts/config.guess` : The **combined**
        effect of these switches is that Glibc's build system configures itself
        to **cross-compile**, using cross-linker and cross-compiler in /tools.

    *   `--enable-kernel=2.6.22.5` : tells Glibc to compile the library with
        **support for** 2.6.22.5 and later Linux kernels.

    *   `--with-headers=/tools/include` : tells Glibc to compile itself against
        the headers just installed in previous section.

    *   `libc_cv_forced_unwind=yes` : inform configure that force-unwind support
        is available without it having to run the test, because ath this moment
        the test will fail with the **cross-linker** under /tools/bin


5.8 Adjusting The Toolchain
------------------------------

Now that the temporary C libraries have been installed, all tools compiled in
the rest of this chapter should be linked against libraries under /tools/lib.

To achieve that, the cross-compiler's `specs` file needs to be adjusted to point
to the new dynamic linker in /tools. This is done by dumping GCC's **internal**
`specs` file to a **expected location** then alters the path of **dynamic linker**
in that specs file.

You can get that **expected location** by running ::

    SPECS=$(dirname $($LFS_TGT-gcc -print-libgcc-file-name) )/specs


5.9 Binutils(pass 2)
------------------------------

Some important configuration options:

    *   `CC="$LFS_TGT-gcc -B/tools/lib/"`

    *   `AR=$LFS_TGT-ar`

    *   `RANLIB=$LFS_TGT-ranlib`: 3 options ensure a **native** build: using
        **cross-compiler** and associated tools, not those from host.

    *   `--with-lib-path=/tools/lib` : specify the library search path during
        the compilation of binutils.

    *   `LIB_PATH=/usr/lib:/lib` : specify the default **library search path**
        of `ld-new`, which is prepared for chapter 6.


The **key difference** between `/tools/bin/ld` and `/tools/bin/ld-new` is the
default **library search path**.

Here, `/tools/bin/ld-new` is created as a **preparation** for the re-adjusting
of the toolchain in chapter 6.

5.10 Binutils(pass 2)
------------------------------

Under normal circumstances the GCC `fixincludes` script is run in order to fix
potentially broken header files. In our situation, the respective header files
of GCC and GLibc are known to not require fixing. In fact, running this script
may actually pollute the build environment, so we must **suppress** its running.

We also need to ensure the **dynamic linker** under `/tools/lib` is used during
the build of GCC and remove /usr/include from GCC's include search path. Thus
all binaries created during this build will link against /tools/lib

Some important configuration options:

    *   `--enable-threads=posix` : enables C++ exception handling for
        multi-threaded code.

    *   `--enable-__cxa_atexit` : essential for fully standard-compliant C++
        destructor. It alse affect C++ ABI.

    *   `--disable-bootstrap` : the LFS build method can provide a solid
        compiler without the need of bootstrapping

5.33 Stripping
--------------------

Some options of command `strip` :

    *   `--strip-debug` :  remove debugging symbol **only**

    *   `--strip-unneeded` :  remove symbols **NOT** needed for relocation.
        This option should **NEVER** be used agaginst libraries.

    *   `--strip-all` :   remove **ALL** symbols, whatever


Chapter 6.  Installing Basic System Software
==============================================

6.2. Preparing Virtual Kernel File Systems
---------------------------------------------

When kernel boots the system, it requires the **presence** of a few device
nodes, in particular the `console` and `null` devices. We must create these
device nodes on the hard disk so that they are available **before** `udevd`
has been started, and additionally when Linux is started with `init=/bin/bash`.

The recommended method of **populating** the `/dev` directory with devices nodes
is to mount a **virtual filesystem** (such as `tmpfs`) on the `/dev` directory,
and allow the devices to be created **dynamically** on that virtual filesystem
as they are detected or accessed.

**Device creation** is generally done during the boot process by `Udev`.

6.9. Glibc
------------------------------

The `specs` of GCC and linker **cannot** be adjusted **before** Glibc is
reinstalled because the Glibc `autoconf` tests would give false results and
defeat the goal of achieving a clean build.

The test suite for Glibc is considered **critical**.

Individual locales can be installed using the `localedef` program. On most
distros, `locale-gen` is a wrapper script for `localedef`.

Some locations related with locales:

    *   /usr/share/i18n/locales : locale definition

    *   /usr/share/i18n/charmaps : charmap definition

    *   /usr/lib/locale/locale-archive : the result

Some additionally configuration

    *   create an appropriate `/etc/nsswitch.conf`

    *   copy /usr/share/zoneinfo/xxxx to `/etc/localtime`

    *   customize /etc/ld.so.conf


6.10. Re-adjusting the toolchain
----------------------------------

Now that the **final** C libraries have been installed, it is time to adjust the
toolchain **again**.

The toolchain will be adjusted so that it will link any newly compiled program
against new libraries just installed under `/usr/lib` and `/lib`

This is quite **similar** to what happened in Chapter, but is **reversed**.

    *   In Chapter 5, adjusted from /{,usr/}lib to /tools/lib

    *   In Chapter 6, adjusted from /tools/lib to /{,usr/}lib

GCC's `specs` file should be adjusted again to point to new dynamic linker just
installed.

6.12. Binutils
----------------------------------

Test suite for Binutils is considered **critical**.

after installation, the library search path of `/usr/bin/ld` is ::

    /usr/i686-pc-linux-gnu/lib:/usr/local/lib:/lib:/usr/lib

6.15. GCC
----------------------------------

Test suite for GCC is considered **critical**.


6.19. ncurses
----------------------------------

Some important configuration options:

    *   `--enable-widec` : build wide-character library which is usable in both
        multibyte and traditional 8-bit locales.

6.20. util-linux
----------------------------------

The **FHS** recommends putting the `adjtime` file used by `hwclock` under
`/var/lib/hwclock/` , instead of the default `/etc/` .

6.22. coreutils
----------------------------------

`POSIX` requires that programs from `Coreutils` recognize **character boundaries**
correctly even in **multibyte locales**.

6.22. iana-etc
----------------------------------

This package provide the raw data for `/etc/protocols` and `/etc/services`

6.29. bash
----------------------------------

After new bash is installed, you **MUST** run it to **replace** the one that is
currently being executed.


6.30. libtool
----------------------------------

This package **wraps** the **complexity** of using **shared libraries** in
a consistent, portable interface

6.30. findutils
----------------------------------

Some important configuration options:

    *   `--locatestatedir=/var/lib/locate` : make the locate of database to be
         **FHS compliant**.

6.47. kbd
----------------------------------

Wide-accepted convention:  the `Backspace` key generates the character with
code 127, and the `Delete` key generates a well-known **escape sequence**.

6.51. man-db
----------------------------------

Man-DB **assumes** manual pages installed under `/usr/share/man/<ll>` will be
encoded with some **expected** encoding.

For example, manual pages under `/usr/share/man/zh_CN/` are expeceted to be
encoded with GBK.

6.55. shadow
----------------------------------

It is sugggested to use the more secure `SHA-512` method of password encryption,
instead of the default `crypt` method.

To enable shadowed passwords, run ::

    pwconv

To enable shadowed group passwords, run ::

    grpconv

6.57. sysvinit
--------------------

When run-levels are changed , `init` sends termination **signals** to processes
those were started by `init` itself and should not be running in the new
run-level.

6.57. texinfo
--------------------

The Info documentation system uses a plain text file , `/usr/share/info/dir`,
to hold its **list of menu entries**.


6.64. Cleaning Up
--------------------

From now on, directory `/tools` are **no longer needed**.


Chapter 7. Setting Up System Bootscripts
=============================================

7.4. Configuring the setclock Script
----------------------------------------

To see what the current time is accroding to your hardware clock ::

    hwclock --localtime --show

7.9. Device and Module Handling on an LFS System
--------------------------------------------------

It is generally accepted that if device names are allowed to be configurable,
then the device naming policy should be up to a **system administrator**,

`sysfs` is the prerequiresite of `udev`. It **export** a view of the system's
hardware configuration to userspace processes.


Chapter 8. Making the LFS System Bootable
=============================================

8.2 /etc/fstab
--------------------

The `/dev/shm` mount point for `tmpfs` is included to support **POSIX-shared
memory**, althouth very little programs currently use that feature.

Filesystems with M$ origin need the `iocharset` mount option in order for
non-ASCII characters in file names to be interpreted properly.

The `codepage` option is also needed for `vfat` and `smbfs` filesystems

8.3. Kernel
--------------

Whenever a package is unpacked as user `root` , the unpacked files would have
the user and group IDs of whatever they were on the packager's computer.

**DO NOT** create symlink `/usr/src/linux` on an LFS system, because that may
cause problem for other packages you want to build later.

`ehci_hcd` needs to be loaded prior to `ohci_hcd` and `uhci_hcd` , in order to
avoid a warning being output at boot time.









X. Questions
====================

1. when building `GCC(pass-1)`, which linker is used? the one from host , or
   the one under /tools/bin from `binutils(pass-1)`

2. when building `binutils(pass-2)`, why specify library search path twice, by
    CC="$LFS_TGT-gcc -B/tools/lib/ and  --with-lib-path=/tools/lib ?

    test result:

    if -B/tools/lib is omitted, `configure`  will report "C compiler cannot
    create executables "

    if --with-lib-path is omitted, binutils can stilled be built successfully.



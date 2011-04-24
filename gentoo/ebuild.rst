1 Ebuild HOWTO
====================

Ebuild scripts are interpreted by the `ebuild(1)` and `emerge(1)`.

Think of the `ebuild(1)` as a **low-level** building tool. It can build and
install a single ebuild, but no more. It will check to see if dependencies are
satisfied, but it will not attempt to auto-resolve them. On the other hand
`emerge(1)` is a **high level** engine for ebuild, and has the ability to
auto-merge dependencies if needed

With `ebuild(1)`, you can **incrementally** step through the various parts of a
package emerge (fetching, unpacking, compiling, installing and merging) one at a
time. For developers, this is an invaluable **debugging tool**,

When you submit your ebuilds, the header should be **exactly the same** as the one
in /usr/portage/header.txt. Most importantly, do not modify it in any way and
make sure that the *$Header: $* line is intact.


The program's corresponding man page should **always** be installed into the
`/usr/share/man` tree.

`/usr/share/info` is the **ONLY** official location for GNU info files.

The `/opt` directory is **reserved** in Gentoo Linux for **binary-only** package

`ebuild(1)` is the main engine of the Portage system; it performs all major
tasks such as unpacking, compiling, installing, merging, and unmerging packages.
It is called in the form of : *ebuild path/to/package.ebuild command*.

Currently, Portage installs all **build-time** and **run-time** dependencies
and leaves it at that. At a later stage, it will be possible to trim your
installation so that only the run-time dependencies are left installed.

`RDEPEND` should be set **explicitly** even if it's the same as `DEPEND` because
in the future it defaulting to DEPEND is planned to be removed from Portage.

3 Common ebuild Mistakes
==============================

Missing/Invalid/Broken Header
------------------------------

The header should be exactly the same as the one in `/usr/portage/skel.ebuild`.
Most importantly, do not modify it in any way and make sure that the
*$Header: $* line is intact.

IUSE Missing
--------------------

By far the most common omission is the IUSE variable. You **MUST** include the
IUSE variable **even if** there are no USE flags in use.

Redefined P, PV, PN, PF
------------------------------

You should **NEVER** redefine those variables. Always use MY_P, MY_PN, MY_PV, etc.

Including version numbers in SRC_URI and S
--------------------------------------------------

You should try not to include version numbers in the SRC_URI and S. Always try
to use `${PV}` or `${P}`.

DEPEND has syntactical errors
------------------------------

Here are some important points to follow when writing the dependency part.

*   Always include the **CATEGORY**. For example, use `>=x11-libs/gtk+-2` and
    not `>=gtk+-2`.

*   Do not put an asterisk (*) for >= dependencies.  For example, it should be
    `>=x11-libs/gtk+-2` rather than >=x11-libs/gtk+-2*.

*   Never depend on a **meta** package.  So don't depend on gnome-base/gnome,
    always epend on the specific libraries like libgnome.

LICENSE Invalid
--------------------

GPL is not a valid license. You need to specify GPL-1 or GPL-2. Same with LGPL.

Make sure the license you use in the LICENSE field is something that exists in
`/usr/portage/licenses/`

SLOT missing
---------------

Make sure you have the SLOT variable in the ebuil

Wrongfully used spaces instead of TABS
----------------------------------------

Trailing whitespace
-------------------------

Documentation missing
------------------------------

If your package has documentation, make sure you install it using `dodoc` or
in `/usr/share/doc/${PF}`

4. Gentoo Metadata
=========================

The metadata.xml file should exist in **EVERY** package directory.

5. Ebuild Maintenance HOWTO
----------------------------------------

When adding a new ebuild, you should only include `KEYWORDS` for architectures
on which you have actually tested the ebuild

Only **architecture maintainers** for a given architecture should mark packages
as stable on that architecture.

6. Ebuild policy
====================

On some architectures, shared libraries must be built with -fPIC. On x86 and
others, shared libraries may build without -fPIC. This can be wasteful and
potentially cause a **performance hit**. If you encounter a package that is not
building shared libraries with -fPIC, patch the Makefile to build **only the
shared libraries** with -fPIC.

There is a difference between using `package.mask` and `~arch` for ebuilds. The
use of `~arch` denotes an ebuild requires **testing**. The use of `package.mask`
denotes that the application or library itself is **deemed unstable**.

Any **new package** that enters Portage must be marked ~arch for the
architecture(s) that this version is known to work on

Remember that **arch teams** alone are responsible for marking packages stable on
their arch. Package maintainers should open stabilization bugs; they may not
just mark packages stable.



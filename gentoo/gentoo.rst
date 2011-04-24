0. Quickstart
====================

Ebuilds are **indented using tabs**, with each tab representing **4 places**

The `KEYWORDS` variable is set to archs upon which this ebuild has been
**tested**. We use ~keywords for newly written ebuilds -- packages are not
committed straight to stable, even if they seem to work.

The `econf` function is a **wrapper** for calling ./configure, and `emake` is a
wrapper for make.

Rather than installing straight to the live filesystem, we must install to
a **special location** which is given by the `${D}` variable setted by the
portage.

The `dodoc` and `dohtml` are helper functions for installing files into the
relevant part of `/usr/share/doc`.

The `DEPEND` variable lists compile-time dependencies, and the `RDEPEND` lists
runtime dependencies

Often we need to apply patches. This is done in the `src_unpack` function using
the `epatch` helper function.

To use epatch one must first tell Portage that the `eutils` eclass (an eclass is
like a **library**) is required -- this is done via `inherit eutils` at the top
of the ebuild.

1. General Concepps
====================

Portage includes a system for configuration file protection which means
ebuilds don't have to worry about accidentally clobbering files in /etc. This
is known as '`protection`', and it is controlled by the `CONFIG_PROTECT` and
`CONFIG_PROTECT_MASK` variables.

Any directory which is listed in CONFIG_PROTECT (and any subdirectories thereof)
are automatically 'protected' by Portage when copying an image from `DESTDIR` to
`ROOT`.

When installing from a **binary package**, **only** `RDEPEND` will be checked.
It is therefore necessary to include items even if they are also listed in DEPEND

The `PDEPEND` variable specifies dependencies which must be merged **after** the package

All packages have an **implicit** compile-time and runtime dependency upon the
entire `system` target


2. Ebuild Writing
=====================

2.1 Ebuild File Format
========================

An ebuild should be named in the form of `name-version.ebuild`.

version may have a Gentoo **revision number** in the form -r1. The initial Gentoo
version should have no revision suffix, the first revision should be -r1, the
second -r2 and so on.

All ebuilds should have a **three line header** immediately at the start
indicating copyright. This must be an **exact copy** of the contents of
$(portageq portdir)/header.txt. Ensure that the `$Header: $` line is not
modified manually -- CVS will handle this line specially.

**Indenting** in ebuilds must be done with tabs, one tab per indent level. Each
tab represents 4 spaces. Tabs should **only** be used for **indenting**, never
inside strings.

All ebuilds must use the `UTF-8` character set.

2.2 EAPI Usage and Description
==================================

If EAPI is undefined in an ebuild, then EAPI="0" is selected. If you want to
override the EAPI variable, you have to specify it at the **top** of the ebuild:



Targets
===============

You can specify packages in **five** possible ways:

    *   `ebuild` :  =sys-apps/python-2.7.1-r1

    *   `atom`: >=sys-apps/python-2.7.1-r1

    *   `set` :  a convenient shorthand for a large group of packages, such as
        `@system`, `@selected`, `@world`. The default set configuration is in
        `/usr/share/portage/config/sets/` directory

    *   `file` : a file or directory that has been installed by some package

    *   `tbz2file`: a .tbz2 created by `ebuild <package>-<version>.ebuild package`


Actions
===============

*   `--clean` :  remove all but the most recently installed version in each slot.

*   `--config`:  Run actions needed to be executed after the emerge process has completed

*   `--depclean(-c)` : remove packages not associated with explicitly merged packages.
                       Packages installed, but not part of the dependency tree, will be uninstalled.
                       It may break link level dependencies, so `revdep-rebuild` is recommended.
                       It serves as a **dependency aware** version of `--unmerge`

*   `--info` : produces a list of information to include in bug reports

*   `--list-sets`  :  list all available sets


*   `--metadata` :

*   `--regen`   :

*   `--prune(-p)` : removes all but the highest installed version of a package


*   `--resume` : Resumes the most recent merge list that has been aborted.
                 A resume list will persist until it has been completed in entirety
                 or until another aborted merge list replaces it.

*   `--search` : By default emerge uses a case-insensitive simple search, but you
                can enable a **regex search** by prefixing the search string with  %.

*   `--unmerge(-c)` : removes all matching packages, without checking dependenies.


Options
===============

*   `--buildpkg` : build binary packages in addition to actually merging.
                   An alternative for already-merged packages is to use `quickpkg`
                   which creates a tbz2 from the live filesystem.

*   `--deep` :  consider the entire dependency tree , instead of checking only
                the immediate  dependencies


*   `--emptytree(-e)` : as if no packages are currently installed


*   `--exclude` :

*   `--fetchonly(-f)` :

*   `--jobs` : the number of packages to build simultaneously

*   `--load-average` :

*   `--keep-going`

*   `--newuse`

*   `--nodeps` : merges specified packages without merging any dependencies

*   `--onlydeps` : merges dependencies, but not the package itself.

*   `--noreplace` : skips packages specified that have already been installed

*   `--onshot(-1)` :

*   `--select`

*   `--skipfirst` :  used together with `--resume` action

*   `--tree` : shows dependency tree by indenting dependencies


Masks
==========

if you give emerge an `ebuild`, then all forms of masking will be **ignored**
and emerge will attempt to emerge the package.



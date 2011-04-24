===================================
Mercurial, the Defininitive Guide
===================================


Chp 1. A Brief History of Revision Control
============================================

There is no agreed-upon definition of what **Revision Control** is and what it
**is not**.

What distributed tools do with respect to forking is they make **forking**
the **only way** to develop a project. Every single commit is **potentially**
a fork point.

Chp 2. A Tour of Mercurial: The Basics
========================================

Mercurial provides a consitents help system; you always use `hg help <topic>`

The .hg directory is the **real repository**, and all of the files and
directories that coexist with it are said to live in the **working directory**.

`tip` is a special tag, which always refers to the **newest** changeset.

`hg log` identifies changeset using both a number and SHA1 hash:

    -   the number is valid **only** in this repo.

    -   the SHA1 hash is `unique, permanent and valid` **anywhere**.

Mercurial support `range notation` in the form of `<revX>:<revY>`

Most commands that print something will print **more** when passed a
-v (or --verbose) option, and **less** when passed -q (or --quiet).

Local clone is very **cheap** and **quick**, because mercurial will use
**hardlinks** to do **copy-on-write** sharing of its internal metadata.

It is best to write a commit message whose **first line** stands alone.

`hg tip` produces output that is identical to `hg log`, but it only displays
the **newest** changeset.

`hg incoming` can tell us what changes `hg pull` would pull in, **without**
actually pulling the changes in.

`hg outgoing` can tell us what changes `hg push` would push out, **without**
actually pulling the changes out.

Mercurial **separate** pulling changes in(`hg pull`) from updating
working directory(`hg update`).

However, Since **pull-then-update** is such a common scenario, Mercurial allows
you combine the two by `hg pull -u`.


When we clone a repository, Mercurial records the location of the repository we
cloned from in the `.hg/hgrc` file of the new repository.

Chp 3. A Tour of Mercurial: Merging Work
===========================================

All changesets have one or more parents, except the very first.

`hg parents` tells you upon which revisions the working direcotry is **based**.
In other words, it tells you the parent(s) of **next changeset**.

A `head` is a changeset which have **no children**.

`tip` is always a `head`, by definition.

Sometimes, a repo may have more than one heads.

`hg heads` will list all the heads.

when you have 2 heads, you should run `hg merge` to merge them together. It will
**updates** the working direcotry so that it contains changes from both heads,
but it will **NOT** create new changeset.

Repeat, `hg merge` will NOT create new changeset.

Mercurial doesn't have a built-in facility for handling **merging-conflicts**.

You can always fix the conflicting file **manually**, then use `hg resolve -m`
to tell mercurial that file do not contain confliction any more.

Mercurial provides  an extension command : `hg fetch`. It can be regarded as
the combination of `hg pull -u`, `hg merge` and `hg commit -m ...` in one step.


Chp 4. Behind the Scenes
==============================

Chp 5. Mercurial in Daily Use
==============================

5.1 Telling Mercurial Which Files to Track
--------------------------------------------------

To tell Mercurial to start tracking a file, use `hg add`.

Mercurial does **NOT** track directorires themself. Instead, it tracks the files
contained in directories. This means it is **IMPOSSIBLE** to represent **empty**
directories in mercurial.

A simple **work-around** is to create a directory containg a **hidden** file,
then `hg add` that hidden file.

5.2 How to Stop Tracking a File
--------------------------------------------------

To tell Mercurial to stop tracking a file, use `hg remove`

`hg remove` has the **side-effect** of deleting file from **working direcotry**.

You can also delete file outside of mercurial, then use `hg remove --after` to
tell mercurial that you really mean to stop tracking that file.

Mercurial provides a useful combining command: `hg addremove`, which will
`hg add` all **untracked** files and `hg remove` all **missing** files.

`hg commit -A` can be seen as `hg addremove` + `hg commit -m ...`

5.3 Copying Files
-----------------------

Mercurial provides `hg copy` which lets you make a new copy of a file. When
you copy a file using this command, Mercurial makes a record of the fact that
the new file is a copy of the original file. It treats these copied files
**specially** when you **merge** your work with someone else.

The Results of Copying During a Merge
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

What happens during a merge is that **changes follow a copy**:  changes made to
the original file will propagate to the copies.

Why Should Changes Follow Copies?
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

This propagation happens **only during merging** .

During merging, this propagation happens **as long as** the changeset that you
are merging from hasn't yet seen the copy.

Mercurial is **the only** revision control system that propagates changes across
copies like this.

5.4 Renaming Files
--------------------

Mercurial treats a `rename` in essentially the **same way** as a `copy`.

When you use `hg rename`, Mercurial makes a **copy** of each source file, then
**deletes** it and **marks** the file as removed.

`hg mv` is an alias for `hg rename`

Since Mercurial's rename is implemented as copy-and-remove, the same
**propagation** of changes happens when you merge after a rename as
after a copy.


5.6 Recovering from Mistakes
------------------------------

`hg revert` allow you to **undo not-commited-yet** modifications to the working
directory.

It can do **NOTHING** about existing changeset.

5.7 Dealing with Tricky Merges
----------------------------------------

merged file can be in one of two states: **resolved** and **unresolved**

`hg reslove -l` can show the state of merged file, which use **R** for resloved
and **U** for unresolved.

5.8 More Useful Diffs
--------------------

By default, the output of `hg diff` is compatible with regular `diff` command.

`hg diff --git` will use a diff format compatible with `git diff`, which
respect **file permission** and more **readable**.

5.9 Which Files to Manage, and Which to Avoid
----------------------------------------------

DVCS can **NOT**, by its nature, offer a file **locking** facility.

When storing modifications to a file, Mercurial usually saves **only** the
**differences** between the previous and current versions of the file.

5.10 Backups and Mirroring
------------------------------

`hg clone -U` is a nice way to backup mercurial repo, because it will not
checkout a work direcory.

Chp 6. Collaborating with Other People
========================================

6.2 Collaboration Models
-------------------------

Mercurial is particularly well suited to managing a number of simultaneous,
but not identical, branches. Each development direction can live in its own
central repository,

A perpetual source of heat in the open source community is whether a development
model in which people only **pull from** others is **better than** one in which
multiple people can **push to** a shared repository

Linux kenrle is a typical example of **pull only** approach.

SVN **enforces** the **shared-push** approach, while DCVSs support **both**.

6.4 Informal Sharing with hg serve
-----------------------------------

`hg serve` can provide an **web-interface** to your mercurial repo, whichi is
wonderfully suited to small, tight-knit, and fastpaced group environments.

`hg serve` is intended for **read only** access, by default.

Chp 7. Filenames and Pattern Matching
========================================

Mercurial commands that work with filenames have **useful default behaviors**
when you invoke them without providing any filenames or patterns:

    -   Most commands will operate on the **entire working directory**, for
        example, `hg add` and `hg status` .

    -   if the command has effects that are difficult or impossible to reverse,
        it will **force** you to explicitly provide name or pattern.


If a command normally operates on the whole working directory, you can make it
operate on **just current directory** by giving it the name '.' .

Some commands normally print filenames relative to the root of the repository,
even if you are invoking them from a subdirectory. Such commands will print
filenames relative to your subdirectory if you give it explicit names.

7.4 Using Patterns to Identify Files
--------------------------------------

The form of pattern is `<syntax>:<pattern>`, of which `<syntax>` identify what
kind of pattern it is and `<pattern>` describe the pattern itself.

Mercurial support 2 kinds of pattern syntax:

    -   **glob**, the same kind of that used in Unix shell; the **default** one.
    -   **re**, the same kind of that used in python.re module

when using regular expression,  you should be careful that the **semantic** of
pattern matching is `re.match()`, but not `re.search()`. This means the pattern
**only** match against the **beginning** of a string.

7.5 Filtering Files
--------------------

Mercurial also allow you to **filter** files using pattern.

    *   -I or --include,  inclusive
    *   -X or --exclude,  exclusive

7.6 Permanently Ignoring Unwanted Files and Directories
---------------------------------------------------------

It is good practice to **track** `.hgignore` in the same way as other files.

7.7 Case Sensitivity
----------------------

There are three common ways to handle case in filenames:

    *   **Completely case insensitive**: case is ignored both when **creating**
        file and subsequent **accesses**. The DOS is an typical example.

    *   **Case preserving, but insensitive**:  case is respected when creating
        file and displaying names, but ignored when **looking up** file by name.
        Windows and Mac OS are typical exampel. This approach is also called
        **case-folding**.

    *   **Case sensitive**: case is sensitive at all times. Linux and Unix are
        typical examples.

To be more precise, case-sensitive is connected with the filesystem, not OS.

Mercurial's **repository storage** mechanism is **case safe**. It **translates**
filenames so that they can be safely stored on **both** case-sensitive and
case-insensitive **filesystems**.

When operating in the **working directory**, Mercurial **honors** the naming
policy of the **filesystem** where the working directory is located.

Chp 8. Managing Releases and Branchy Development
==================================================

8.1 Giving a Persistent Name to a Revision
-----------------------------------------------

`hg tag` can give any chageset a **permanent name**. Those permanent names are
called as **tags**.

`tip` is a special **floating** tag, which always identifies the **newest**
changeset.

`hg tags` will list all tags in the **reverse** order of changeset number, which
means `tip` will always be the first one listed.

Anytime some command need an changeset ID, you can provide a tag. Mercurial will
**translate** tag name into the corresponding revision ID, then use that.

Ther is **no limit** on the number of tags you can have in a repository, or on
the number of tags that **a single changeset** can have.

`hg tag --remove` will delete specified tag.

`hg tag -f` can be used to modify exising tag, makeing it refer to another
changeset.

Mercurial stores tags in a revision-controlled file named as `.hgtags`. Whenever
you create, modify or delete a tag, mercurial will modify `.hgtags` and create
a **new chagneset** for the modification to `.hgtags`.

Handling Tag Conflicts During a Merge
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

When mercurial parse tags, it **NEVER** consider the `.hgtags` in the
**working directory**.  Instead, it consider the `.hgtags` in the **latest**
revision.

An **unfortunate** consequence of this design is that you **can't verify** that
your merged `.hgtags` file is correct **until** you've committed the merge.

Tags and Cloning
~~~~~~~~~~~~~~~~~~~~

`hg clone -r <rev>` allow you to **partially clone** a repo. The new clone will
not contain any history that comes after the specified revision.

However, this mean if you pass a tag name to `hg clone -r`, the new clone will
**NOT** contain that tag!

When Permanent Tags Are Too Much
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Since normal tags are stored in revision-controlled `.hgtags`, they will be seen
by anyone you are working with. They are **global tags** by definition.

`hg tag -l` will create **local tags**, which are stored in an file named as
`.hg/localtags`, **non-revision-controlled**.


8.2 The Flow of Changes: Big Picture Versus Little Picture
------------------------------------------------------------

8.3 Managing Big-Picture Branches across Repositories
------------------------------------------------------------
The easiest way to isolate a big-picture branch is create a **dedicated** repo.

8.5 Managing Little-Picture Branches Within One Repository
-------------------------------------------------------------

In most instances, **isolating branches in dedicated repositories** is the
right approach. Its **simplicity** makes it easy to understand and hard to
make mistakes.  That creates a **one-to-one** relationship between branches
and directories.

Mercurial also support **named branch** within repo.

There always exists a branch named `default`.

`hg branches` will list **all** named branches, alongside the **newset changeset**
of each branch.

`hg branch` will show you the **current branch**.

`hg branch <name>` will create new named-branch

Creating a new branch has no effect on existing history and workding directory.
It only tell mercurial **which branch name to use** for next changeset. In other
words, creating a branch **implies swithing** to that branch.

When you commit a change, Mercurial **records** the name of current branch in
the created changeset, **permanently**.

8.6 Dealing with Multiple Named Branches in a Repository
------------------------------------------------------------

`hg update` will updates working directory to the **tip of current branch**,
but not the tip of the whole repo. Here tip means newest changeset/revision.

8.7 Branch Names and Merging
------------------------------

Merges in Mercurial are **not symmetrical**.

After a merge, Mercurial will **retain** the branch name of the **first parent**
, when you commit the result of the merge.

Chp 9. Finding and Fixing Mistakes
====================================

9.1 Erasing Local History
-----------------------------

Mercurial treats each modification of a repository as a **transaction**, so
you can use `hg rollback` to rollback the latest transaction. However, you can
not rollback successively.

It is **common practice** with Mercurial to maintain separate development
branches of a project in different repositories.

Rolling Back Is Useless Once You've Pushed
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

You Can Only Roll Back Once
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

9.2 Reverting the Mistaken Change
----------------------------------------

`hg revert` allows you to **cancel un-committed changes** to working directory.

`hg revert` provides us with an **extra degree of safety** by saving modified
file with a .orig extension.

`hg revert` can deal with several different cases:

    -   If you have **modified** a file, it will restore the file to its
        unmodified state.

    -   If you have **delete** a file **outside** of mercurial, it will restore
        the file to its unmodified state.

    -   If you have `hg add` a file, it will **undo** the added state of the
        file, but leave the file itself untouched.

    -   If you use  `hg remove`  a file, it will **undo** the removed state of
        the file, and restore the file to its unmodified state.

9.3 Dealing with Committed Changes
========================================

Mercurial's history is **immutable**, to which the **only exception** is
`hg rollback`.

`hg backout` is similar to `git revert`, which will create new changeset to
**reverse** the effect of one previous changeset, but **never** modify nor
erase existing history.

`hg bakcout` take as argument a single changeset ID whose effect should be
reversed.

When you use `hg backout` to reverse a non-tip-changeset,  the newly created
changeset will always be another `head`. This means merging is need.

A good practice is always use `hg backout --merge`, which will perform merging
automatically if merging is necessary.

`hg backout --merge` will **never commit**, just like `hg merge`


9.4 Changes That Should Never Have Been
========================================

Mercurial doesn provide a way to **punch a hole in history**.

`hg backout` offers a `--parent` option, which lets you specify which parent to
revert to when backing out a merge.

Indeed, **no** DVCSs can make data **reliably vanish**.

9.5 Finding the Source of a Bug
========================================

`hg bisect` is quite similar to `git bisect`

A simple way to **cross-check** the report of `hg bisect` is to manually run your
test at each of the following changesets:

    -   The changeset that it reports as the **first bad** revision. Your test
        should still report this as **bad**.

    -   The **parents** of that changeset. Your test should report thoses
        changesets as **good**.

    -   A **child** of that changeset. Your test should report this changeset
        as **bad**.

From the perspective of `hg bisect`, the **newest** changeset is conventionally
**bad**, and the **older** changeset is **good**.

Chp 11. Customizing the Output of Mercurial
=============================================

All **log-like** commands let you use **styles and templates**: `hg incoming`,
`hg log`, `hg outgoing`, and `hg tip`.

A style is a template with a name, stored in a file.

Chp 12. Managing Changes with Mercurial Queues
==================================================

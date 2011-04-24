
gitglossary
====================

`Head` is a **named reference** to the commit at the tip of a branch. Heads are
stored in `.git/refs/heads/`, except when using **packed refs**.

New upstream updates will be fetched into `remote-tracking` branches named
origin/name-of-upstream-branch, which you can see using `git branch -r`.

`remote-tracking` branch is a regular git branch that is used to follow changes
from another repository. A remote-tracking branch **should not** contain direct
modifications or have local commits made to it. A remote-tracking branch can
usually be **identified** as the right-hand-side ref in a Pull: refspec.

`Symbolic reference`: instead of containing the SHA1 id itself, it is of the
format `ref: refs/some/thing` and when referenced, it recursively **dereferences**
to this reference. `HEAD` is a prime **example** of a symref. Symbolic references are
manipulated with the `git-symbolic-ref(1)` command.

`upstream branch` : The default branch that is merged into the branch in
question (or the branch in question is rebased onto). It is configured via
`branch.<name>.remote` and `branch.<name>.merge`. If the upstream branch of A is
origin/B sometimes we say "A is tracking origin/B".


gitworkflows
====================


gitrepository-layout
=======================

`.git/HEAD` is normally a `symref` to the `refs/heads/` namespace describing the
currently active branch. HEAD can also record a specific commit **directly**,
instead of being a symref to point at the current branch. Such a state is often
called **detached HEAD** .



gitcli
==========

The `--cached` option is used to ask a command that usually works on files in
the working tree to **only work with the index**. For example, git grep, when
used without a commit to specify from which commit to look for strings in,
usually works on files in the working tree, but with the --cached option, it
looks for strings in the index.

The `--index` option is used to ask a command that usually works on files in the
working tree to **also affect the index**. For example, git stash apply usually
merges changes recorded in a stash to the working tree, but with the --index
option, it also merges changes to the index as well.




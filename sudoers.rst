Authentication and Logging
============================

Unlike `su`, when sudoers requires authentication, it validates the **invoking
user's** credentials, not the **target user's** (or root's) credentials.
However, this can be changed via the `rootpw`, `targetpw` and `runaspw` flags.

sudoers uses time stamp files for credential caching. Once a user has been
authenticated, a time stamp is updated and the user may then use sudo without a
password for a short period of time. By default, sudoers uses a **tty-based time
stamp** which means that there is a separate time stamp for each of a user's
login sessions. The `tty_tickets` option can be disabled to force the use of a
single time stamp for all of a user's sessions.

sudoers can log both successful and unsuccessful attempts to `syslog`, a log
file, or both.

sudoers also supports logging a command's input and output streams. I/O logging
is not on by default but can be enabled using the `log_input` and `log_output`
flags.

Command Environment
=====================

Since environment variables can influence program behavior, sudoers provides
a means to **restrict** which variables from the user's environment are inherited
by the command to be run. There are **two distinct ways** sudoers can deal with
environment variables.

By default, the `env_reset` option is enabled. This causes commands to be
executed with a **minimal environment** containing `TERM`, `PATH`, `HOME`,
`MAIL`, `SHELL`, `LOGNAME`, `USER` and `USERNAME` in addition to variables from
the invoking process **permitted** by the `env_check` and `env_keep` options. This
is effectively a **whitelist** .

If, however, the env_reset option is disabled, any variables not explicitly
**denied** by the `env_check` and `env_delete` options are inherited from the invoking
process. In this case, env_check and env_delete behave like a **blacklist**.


The list of environment variables that sudo allows or denies is contained in the
output of `sudo -V` when run as `root`.

Note that the **dynamic linker** on most operating systems will remove variables
that can control dynamic linking from the environment of setuid executables,
including sudo. Depending on the operating system this may include _RLD*,
DYLD_*, LD_*, LDR_*, LIBPATH, SHLIB_PATH, and others. These type of variables
are removed from the environment before sudo even begins execution and, as such,
it is not possible for sudo to preserve them.

As a special case, If sudo's -i option (**initial login**) is specified, sudoers
will initialize the environment **regardless** of the value of `env_reset`.
The `DISPLAY`, `PATH` and `TERM` variables remain unchanged; `HOME`, `MAIL`,
`SHELL`, `USER`, and `LOGNAME` are set based on the target user.

SUDOERS FILE FORMAT
=======================

When multiple entries match for a user, they are **applied in order**. Where
there are multiple matches, the **last match is used** (which is not necessarily
the most specific match).

SUDOERS OPTIONS
====================



===========
Ranger
===========

-----------------------
A vim style console FM
-----------------------

1. Basic Movement and browsing
==============================

1.1 Similar movement as vim
-------------------------------

    `H` :       move *back* in history

    `L` :       move *forward* in history


    `]` :       move *down* in the parent directory

    `[` :       move *up* in the parent directory


    `}` :       traverse the directory tree, visiting each directory

    `{` :       traverse in the *other* direction. (not implemented yet)


    `gl` :      move to the *real* path of the current directory (resolving symlinks)

    `gL` :      move to the *real* path of the selected file or directory


1.2 Browser control
-------------------------------

    `^L` :      *redraw* the window

    `R` :       *reload* the current directory


    `z` :       *toggle* options

    `u` :       *undo* certain things (unyank, unmark, unselect...)



    `i` :       *inspect* the content of the file

    `E` :       *edit* the file

    `S` :       open a *shell*, starting in the current directory


    `<Space>` : mark a file

    `v` :       *toggle* all marks

    `V` :       *remove* all marks

    `^V` :      mark files in a specific direction; e.g. `^Vgg` marks all files from current to the top

    `u^V` :     *unmark* files in a specific direction



    `t` :       tag/untag the selection

    `T` :       *untag* the selection


    `<F7>` :    *create* a directory

1.3 Searching
-------------------------------

    `cc` :      cycle through all files by their *ctime* (last inode change)

    `cm` :      cycle by *mime* type, connecting similar files

    `cs` :      cycle by *size*, large items first


1.4 Sorting
-------------------------------

    `os` :      sort by *size*

    `ob` :      sort by *basename*

    `om` :      sort by *mtime* (last modification)

    `ot` :      sort by *mime* type

    `or` :      *reverse* order

1.5 Bookmarks
-------------------------------

    `m` :       *create* bookmark

    `'` :       *jump* to bookmark

1.6 Tabs
-------------------------------

    `^N` :      *Create* a new tab

    `^W` :      *Close* the current tab.


    `gt` :      Go to the *next* tab. (also `TAB`)

    `gT` :      Go to the *previous* tab. (also `Shift+TAB`)

    `g<N>` :    Go to tab numbered as N.  On most terminals, `Alt-1`, `Alt-2`, etc., also work.


1.9 Misc keys
-------------------------------

    `du` :      Display the *disk* usage of the current directory

    `cd` :      Open the console with "`:cd` "

    `cw` :      Open the console with "`:rename` "


    `A` :       Open the console with "`:rename` <current filename>"

    `I` :       Same as A, put the cursor at the beginning of the filename


    `yp` :      Copy the `path` of the file (with xsel)

    `yn` :      Copy the `basename` of the file (with xsel)

    `yd` :      Copy the `dirname` of the file (with xsel)

1.9 Previews
-------------------------------

    By default, *only* text files are previewed, but you can enable external
    preview scripts by creating `~/.config/ranger/scope.sh`

2. Running files
==============================

2.1 How to run files
-------------------------------

    `l` :       open the selection through filetype detection mechanism

    `r` :       open the selection thought "`:open_with`" command manually


2.2 The "open_with" command
-------------------------------

    `:open_with` <program> <flags> <mode>

2.3 Programs
-------------------------------

    Programs have to be defined in *ranger/defaults/apps.py*.

    Each *function* in class *CustomApplications* which starts with "``app_``"
    can be used as a *program* in the "`open_with`" command.

2.4 Modes
-------------------------------


2.5 Flags
-------------------------------

    Flags give you a way to *modify* the behaviour of the spawned process.


3. The Console
==============================

3.1 General
-------------------------------

    The console is opened by pressing ":".  Press `<TAB>` to cycle through all
    available commands and press `<F1>` to view help about the current command.

    All commands are defined in the file *ranger/defaults/commands.py*

3.2 List of Commands
-------------------------------

    All commands except for "`:delete`" can be abbreviated with the *shortest*
    *unambiguous* name.


    `:cd` <dirname>
        *Changes* the directory to <dirname>

    `:chmod` <octal_number>
        Sets the *permissions* of the selection to the octal number.

    `:delete`
        *Deletes* current selection.

    `:edit` <filename>
        Opens the specified file in the *text editor*.

    `:eval` <python_code>
        *Evaluates* the given code inside ranger.

        `fm` is a reference to the filemanager instance,
        `p` is a function to print text.

    `:filter` <string>
        Displays only files which contain <string> in their basename.

    `:find` <regexp>
        Quickly *find* files that match the regexp and *execute*
        the first unambiguous match.

    `:grep` <string>
        Looks for a string in all marked files or directory.
        (equivalent to "!grep [some options] -e <string> -r %s | less")

    `:mark` <regexp>
        *Mark* all files matching a regular expression.

    `:unmark` <regexp>
        *Unmark* all files matching a regular expression.

    `:mkdir` <dirname>
        *Creates* a directory with the name <dirname>

    `:open_with` [<program>] [<flags>] [<mode>]
        Open the current file with the program, flags and mode.

    `:rename` <newname>
        Rename the currently highlighted file to <newname>

    `:search` <regexp>
        Search for a regexp in all file names, like the / key in vim.

    :shell [-<flags>] <command>
        Run the command, optionally with some flags.

    `:terminal`
        *Spawns* "x-terminal-emulator" starting in the current directory.

    `:touch` <filename>
        *Creates* a file with the name <filename>


3.3 Macros
-------------------------------

    Macros used in commands will be *replaced* with a list of files.

    `%f` :      the highlighted file

    `%d` :      the path of the current directory

    `%s` :      the selected files in the current directory.  If no files are selected, it defaults to the same as %f

    `%t` :      all tagged files in the current directory

    `%c` :      the full paths of the currently copied/cut files


3.4 The more complicated Commands in Detail
---------------------------------------------

3.3.1 `:find`
...............

    The `:find` command is different than others: it doesn't require you to
    press `<Enter>`.  To speed things up, it tries to guess when you're
    done typing and executes the command right away.

    The key "`f`" opens the console with "`:find`"

3.3.2. `:shell`
...............

    `:shell` command accepts flags  as the first argument.

        "!" opens ":shell "

        "@" opens ":shell  %s"

        "#" opens ":shell -p "


4. File Operations
==============================

4.2 The Selections
-------------------------------

    Many commands operate on the selection, so it's important to know what it is:

        - If there are marked files, the selection contains all the *marked* files.

        - Otherwise, the selection contains only the *highlighted* file.

4.3. Copying and Pasting
-------------------------------

    `ya|da` :   *add* the selection to the copied/cut files

    `yr|dr` :   *remove* the selection from the copied/cut files


    `pp` :      paste the copied/cut files. Existing files are *not overwritten*.

    `po` :      paste the copied/cut files. Existing files are *overwritten*.

    `pl` :      create *symbolic links* to the copied/cut files.

    `pL` :      create *relative symbolic* links to the copied/cut files.


4.4. Task View
-------------------------------

    The task view lets you *manage IO tasks* such as like copying and moving
    by changing their priority or stop them.

    `w` :       open or close the task view

    `J` :       *decrease* the priority of the task

    `K` :       *increase* the priority of the task

    `dd`        *stop* the task


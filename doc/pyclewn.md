Working with Pyclewn
====================

Installation
------------

Although there are instructions online for [installing Pyclewn with Pathogen or Vundle][1],
they don't cover the Python part, meaning that you have to download the tarball and install it yourself.
This doesn't make sense to me, as the Python code and vim scripts need to be in sync anyway.
I am using a standard Pyclewn installation, following the default [Pyclewn installation notes][2].

    $ sudo pip install pyclewn
    $ python -c "import clewn; clewn.get_vimball()"
    $ vim -S pyclewn-2.3.vmb
    :q

To upgrade, rerun, passing the `--upgrade` option to pip install.


Check gdb
---------

Before getting tangled in Pyclewn, we can check that gdb is a flyer from the command line.
If you're unfamiliar with gdb, work your way through the [Sample gdb session][3] first,
or through [Faye Williams's excellent tutorial][4].

In the build directory, set a solib-search-path (local debugging) or sysroot (cross-debugging)
and a default main() breakpoint in .gdbinit

    set solib-search-path ~/workspace/build/staging/x86/
    break main

gdb will refuse to load this, unless you OK it in your ~/.gdbinit.
You can either OK the specific file, or a directory (and its subdirectories) containing the trusted .gdbinit file(s).

    set auto-load safe-path /home/douglas/workspace/project

Now we launch gdb with our target executable. It doesn't load any shared libraries until we run it.

    $ gdb ./progname                      # or ...
    $ gdb --args ./progname arg1 arg2
    (gdb) r
    ...
    Breakpoint 1, main (argc=3, argv=0x7fffffffe0d8) at /home/douglas/workspace/project/progname.cpp:39
    39      {

    (gdb) info sharedlibrary
    From                To                  Syms Read   Shared Object Library
    0x00007ffff7dd7ac0  0x00007ffff7df5640  Yes         /lib64/ld-linux-x86-64.so.2
    ...

    (gdb) s
    ...

We're ready to go.


Starting Pyclewn
----------------

Launch Pyclewn and gdb from within Vim:

    :lcd builddir/                              # Don't forget to change to the appropriate directory first.
    :Pyclewn gdb ./progname                     # or ...
    :Pyclewn gdb --args ./progname arg1 arg2

You can also launch Pyclewn from the command line, and it will open up a new Vim instance:

    $ python -m clewn -a ./progname                     # or ...
    $ python -m clewn -a '--args ./progname arg1 arg2'

The Python clewn application is started in the background, but gdb doesn't do anything until we issue a command.
Before starting the program, we almost certainly need to provide it with a tty console for stdout.
Pyclewn has most gdb commands mapped to `:Ccommand`, or you can run them with `:C command`.

    :Cinferiortty
    :Crun                       # or ...
    :C run

Assuming we have the "break main" line in our .gdbinit script,
the program is launched, breaks on the `main()` method, and the source file is displayed with breakpoint #1 showing.

> Optionally, run Pyclewn (the Python app) itself in a debug console, to see its debug messages.
>
>     :let g:pyclewn_terminal = "xterm, -e"           # or ...
>     :let g:pyclewn_terminal = "xfce4-terminal, -x"  # then ...
>     :Pyclewn gdb ./progname


Windows and tabs
----------------

If Pyclewn is started in an otherwise empty Vim instance, it opens its normal windows at the top,
leaving an empty window at the bottom. If you already have files open, the Pyclewn windows are opened above them:

    +--------------------------------------------------+
    | GDB console                                      |
    +--------------------------------------------------+
    | Breakpoints    | Backtrace      | Threads        |
    +--------------------------------------------------+
    | Empty, or existing files                         |
    +--------------------------------------------------+

On my wide screen, I don't find this a useful layout, so now's the time to move things around.
Stack all the existing windows vertically.

    :windo wincmd K

Now focus on the empty (or existing file) window, and move it to a right vertical split.

    Ctrl-W L

    +-------------------------+-------------------------+
    | GDB console             | Empty, or existing file |
    +-------------------------+                         |
    | Breakpoints             |                         |
    +-------------------------+                         |
    | Backtrace               |                         |
    +-------------------------+                         |
    | Threads                 |                         |
    +-------------------------+-------------------------+

Now, whenever gdb hits a breakpoint, it will be shown in this rightmost window.
If you click on (or press `Enter` on) a breakpoint in the Breakpoints windows,
it will be shown in a new (or existing) split in the rightmost window.

If you launch Pyclewn in a new tab of its own, breakpoints will be displayed in an existing (or new) split in another
tab, ie. Pyclewn keeps only its own windows in its tab. Pyclewn's intention is that you can have multiple source files
open in multiple tabs, and it will find them to display them as required.
This is not how I like to work, so I stick with just the one tab.


Debugging
---------

Issue commands to gdb by prefixing them with `:C`.
To see a list of all commands, and a list of all the possible arguments to a selected command:

    :C <Ctrl-D>
    :Ccommand <Ctrl-D>          # or ...
    :C command <Ctrl-D>

Turn on Pyclewn's debug-centric keyboard mappings (and turn them off again).
I have mapped these, vim-unimpaired style, to `[op`, `]op`, and `cop`.

    :Cmapkeys
    :Cunmapkeys

A subset of the default mappings:

    :help gdb-keys

        R       Run             # Yes, that is Shift-R
        C       Continue
        S       Step into
        Ctrl-N  Next
        F       Finish (step out)
        B       Info breakpoints
        L       Info locals
        Ctrl-B  Set a breakpoint on the cursor line
        Ctrl-K  Clear all breakpoints on the cursor line
        Ctrl-U  Up one stack frame
        Ctrl-D  Down one stack frame

Be careful while editing with these key-mappings turned on, eg.
A (append), C (change), and X (delete backwards) won't have the expected effect.

When focused on the breakpoints window:

    <CR>    Go to corresponding line in the source code
    +       Toggle enabled/disabled
    CTRL-K  Delete


Exiting
-------

All done. Regrettably, exiting doesn't unmap the Pyclewn keys.

    :Cexitclewn
    :Cunmapkeys


Still to come
-------------

 - Using the Pyclewn variables window (see :help pyclewn-variables)
 - I am unable to restart Pyclewn within the same Vim session, though I have found a work-around:
    * :Cexitclewn
    * :Pyclewn ... (fails)
    * :Cexitclewn
    * :Pyclewn ... (succeeds)
 - I am unable to set g:pyclewn_args="--terminal='xfce4-terminal,-x'" to launch xfce4-terminal,
   either from inside Vim or the command-line. The default xterm -e does seem to work, so that's OK.


[1]: http://stackoverflow.com/questions/6695410/gdb-front-end-to-use-with-vim/8324543#8324543
[2]: http://pyclewn.sourceforge.net/install.html
[3]: https://sourceware.org/gdb/current/onlinedocs/gdb/Sample-Session.html
[4]: http://www.fayewilliams.com/2011/02/01/command-line-gdb-tutorial-and-walkthrough-part-1/


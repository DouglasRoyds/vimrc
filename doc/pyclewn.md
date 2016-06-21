Working with Pyclewn
====================

Installation
------------

Although there are instructions online for [installing Pyclewn with Pathogen or Vundle][frontend],
they don't cover the Python part, meaning that you have to download the tarball and install it yourself.
This doesn't make sense to me, as the Python code and vim scripts need to be in sync anyway.
I am using a standard Pyclewn installation, following the default [Pyclewn installation notes][installation].

    $ sudo pip install pyclewn
    $ python -c "import clewn; clewn.get_vimball()"
    $ vim -S pyclewn-2.3.vmb
    :q

To upgrade, rerun, passing the `--upgrade` option to pip install.

[frontend]: http://stackoverflow.com/questions/6695410/gdb-front-end-to-use-with-vim/8324543#8324543
[installation]: http://pyclewn.sourceforge.net/install.html


Check gdb
---------

Before getting tangled in Pyclewn, we can check that gdb is a flyer from the command line.
If you're unfamiliar with gdb, work your way through the [Sample gdb session][gdb-sample] first.

In the build directory, set a solib-search-path (local debugging) or sysroot (cross-debugging)
and a default main() breakpoint in .gdbinit

    set solib-search-path ~/workspace/build/staging/x86/
    break main

gdb will refuse to load this, unless you OK it in your ~/.gdbinit.
You can either OK the specific file, or a directory (and its subdirectories) containing the trusted .gdbinit file(s).

    set auto-load safe-path /home/douglas/workspace/project

Now we launch gdb with our target executable. It doesn't load any shared libraries until we run it.

    $ gdb ./test_thing
    (gdb) r
    ...
    Breakpoint 1, main (argc=3, argv=0x7fffffffe0d8) at /home/douglas/workspace/project/test_thing.cpp:39
    39      {

    (gdb) info sharedlibrary
    From                To                  Syms Read   Shared Object Library
    0x00007ffff7dd7ac0  0x00007ffff7df5640  Yes         /lib64/ld-linux-x86-64.so.2
    ...

    (gdb) s
    ...

We're ready to go.

[gdb-sample]: https://sourceware.org/gdb/current/onlinedocs/gdb/Sample-Session.html


Starting Pyclewn
----------------

Launch gdb with the target executable.

    :Pyclewn gdb ./test_thing

We're away. Pyclewn has most gdb commands mapped to `:Ccommand`, or you can run them with `:C command`.

    :Crun
    :C run


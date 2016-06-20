Working with Pyclewn
====================

Installation
------------

Although there are instructions online for
[installing Pyclewn with Pathogen or Vundle|http://stackoverflow.com/questions/6695410/gdb-front-end-to-use-with-vim/8324543#8324543],
they don't cover the Python part, meaning that you have to download the tarball and install it yourself.
This doesn't make sense to me, as the Python code and vim scripts need to be in sync anyway.
I am using a standard Pyclewn installation, following the default
[Pyclewn installation notes|http://pyclewn.sourceforge.net/install.html].

    $ sudo pip install pyclewn
    $ python -c "import clewn; clewn.get_vimball()"
    $ vim -S pyclewn-2.3.vmb
    :q

Starting gdb
------------

Set a solib-search-path (local debugging) or sysroot (cross-debugging) and a default main() breakpoint in .gdbinit

    set solib-search-path ~/workspace/build/staging/x86/
    break main

For local debugging, we launch gdb with the target executable.

    :lcd build/
    :Pyclewn gdb ./test_thing

For remote debugging, just launch gdb, then connect to the remote server.

    :Pyclewn gdb
    :Ctarget remote 172.16.111.222:10000

In either case, we're away.

    :Crun

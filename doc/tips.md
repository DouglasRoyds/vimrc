VIM tips and tricks
===================

Don't panic!
------------

How to crack the (very steep) learning curve into VIM:

1. It's all in the configuration - the default vimrc file is very poor indeed, so you need to use someone
   else's. Do this as part of the install process, before even trying to start using VIM.
2. Do the tutorial - launch it from the command line by typing vimtutor. This copies the original file, and
   opens VIM to edit it.
3. Make sure you are familiar with all the commands in the [Best Vim Tips][1]
4. The rest of this document describes the things that won't be covered by the above. At time of writing, I'm
   not describing how to set up your configuration and plug-ins here - I'm just assuming that they're set up
   the same as mine. I need to think about how to standardise this.

Moving around
-------------

### Vertically

Scroll the cursor to the

zt | Top
zz | Middle
zb | Bottom of the screen.

Back/forward to the start of this/the next

[[ ]] | Function (marked by a { in the first column).
{ }   | Paragraph.
( )   | Sentence.


### Horizontally

Ctrl-H/L::
Move the cursor half a screen left/right (this is my own mapping)

g^, gM, g$::
Move the cursor to the left, middle (my own mapping), or right side of the screen

zs, zZ, ze::
Scroll the cursor to the left, middle (my own mapping), or right edge of the screen.

zh, zl::
Scroll horizontally, revealing one more character on the left or right (sort of like ctrl-e, ctrl-y, but horizontal)

zH, zL::
Reveal half a screen horizontally on the left or right

Selecting
---------

viw::
The current word, without trailing white space (visual "inner" word)

vap::
The current paragraph, including any trailing blank lines (visual a paragraph)

vaB or va{::
The current {} block, including the curly brackets (visual a Block)

va[::
The current [] block, including the brackets

va(::
The current () block, including the parentheses

gv::
Get back the previous selection

o (Visual mode)::
Move cursor to opposite end of visual selection, so that you can move that end instead

O (Block-visual mode)::
Move cursor to the other corner on the same line

Editing
-------

### Cut and paste

yiw::
Yank the current word

"ayy::
Yank the current line into register a

"Ayy::
Append the current line to register a

gP::
Put the register contents, and leave the cursor after the result

]P or ]p::
Put the register contents before/after, with the correct indentation

"+yy::
Yank the current line into the Windows/Gnome cut-and-paste buffer

"*p::
Put the contents of the X selection, ie. any text currently highlighted (by the mouse). A bit like a centre-click.

daw::
Delete (cut) a whole word, including spaces

dB::
Delete to the Beginning of the previous space-separated word. This is very handy for deleting word-by-word backwards
from the end of a line, in combination with the . repeat command


### Registers

`:reg`::
Which register holds what?

`:reg asdf`::
Just show me these registers

Unnamed ""::
Every yank, delete, change, etc. goes into this one, even if it is also going into some other register

"0::
The yank register: the most recent yank remains here (unless it was put in some other named register),
so we can repeatedly change words for whatever we've most recently yanked:

   yiw
            (Move to some other word)
   cw^R0
            (Move to another word)
   cw^R0    (... or just use the . command to repeat)

"1 ... "9::
The most recent whole-line delete or change (unless put elsewhere) goes into register 1.
Successive changes or deletions push down the registers, from 1 to 9.

"-::
The small-delete register - deletions or changes of less than one line (unless put elsewhere)

"_::
The black hole register (that's an underscore).
Delete or change into this one to avoid losing the unnamed register or pushing down register 1.


### Capitalisation

~::
Switch the capitalisation of the current character or selection

gUw::
Capitalise a word

guw::
Change a word to lower case


### Reformatting paragraphs

setl tw=80::
Set the text width (right margin) for the local buffer only

gqap::
Reformat a paragraph

gqj::
Reformat only the current line - this is safer than gqap, and you can rattle down through text by using
          the . command to repeat

### Surround

Install Tim Pope's [vim-surround][2] plug-in.

Command        | Old text   | New text     | Comment
-------------- | ---------- | ------------ | ----------------------------------------------------
ds"            | "Fred"     | Fred         | Delete surrounding quotes
cs])           | [123]      | (123)        | Use the right-bracket form for no intervening spaces
cs"<p>         | "Text"     | <p>Text</p>  |
cit            | <p>Old</p> | <p>New</p>   | Change inner tag
ysW)           | x>3        | (x>3)        | You surround (wait ...) Word with parentheses
yss<p>         | Line       | <p>Line</p>  | You surround whole line
v<movement>S"  | Ginger     | "Ginger"     | visual Surround

Searching
---------

### Within the file

The magic `*`::
To find the next instance of the whole word the cursor is on, simply press \*. To find the previous instance, press #. To
find partial matches as well, use g* and g#.

/\<whole_word_only\>::
To search for whole words only, use the \< and \> keywords in the search string (though I almost never do this, as the
magic * is so much easier)

\^R^W::
Pulls the current cursor word onto the command line, useful right after typing / or :grep

\^R^A::
Current cursor Word

[I::
Lists all occurrences of the cursor keyword in the current file and its #included files

21[^I::
Jumps to an instance from within that list (e.g. number 21)

`:g/pattern/nu`::
Displays each line that contains the pattern, with a line number - very similar to the effect of [I
(this is the :number command)

`:g/pattern/z#.5 | echo "-----"`::
Also a few lines of context (this is the :z# command)

`:g/pattern/normal xxxx`::
Carries out Normal mode commands xxxx on each line that contains pattern (:normal)

`:g/pattern/s#this#that#`::
Substitute that for this on each line matching the pattern


### Search and replace

The simple way:

1. Search using /
2. Change the word using cw, and
3. Repeat the operation using n (find again) and . (repeat the last operation).

To search in a selection:

1. Make the selection, using v (character select) or V (line select)
2. Type : to enter command mode. Vim will provide a prefix describing the selection, e.g.

   :'<,'>

3. Enter the search-and-replace command using the substitute keyword, where the g means to make global replacements
   within each line:

   :'<,'>s#this#that#g


### Global search and replace within the file

   :%s#this#that#gc

where

%::
Whole file

g::
Global replacements within each line

c::
Confirm each change

:%s#pattern##gn::
Count. Does a search and replace, but doesn't actually do it, only reporting how many matches it found.

Some tricks with :s

 * When the target is a regular expression, it can be very difficult to get it right, so:
    1. Get the search right first, using a normal / search, with all the regular expression tricks you need.
    2. Start the command with :%s#
    3. Type Ctrl-R / to drop in the contents of the last / search


### ctags

This needs more work - I haven't actually been using ctags. Download Exuberant ctags from the
[ctags home page][3], and extract ctags.exe into somewhere on your path (I put it in c:\bin).

Ctrl-]::
Jumps directly to the declaration of the identifier under the cursor

set tags=tags;/::
Searches for the tags file in the current working directory, then recursively up through the directory structure:

command! Ctags !ctags --file-scope=no -R .::
Sets up the command :Ctags, which will rebuild the tags file from the current working directory down. I always work with
the root of the check-out as the current working directory, so this rebuilds the root tags file.

autocmd BufWritePost *.[ch] :silent !ctags %::
Reruns ctags on the current file when we save it. This updates the tags file in the file's own directory.


### Grep

   :grep regexpr --include="*.{c,h,sm}"
   :vimgrep /an error/ *.c
   :vimgrep /\<FileName\=/ *.h include/*
   :vimgrep /myfunc/ **/*.c

Hmm. More to come here.


### Tag list for the current file

To display functions, structures, variables, etc. in the current file in a window down the side of the screen, download
and install [taglist.vim][4]. Once installed, turn it on and off by
typing:

   :Tlist

I have mapped this to ,tl in my vimrc file.


### Definition of the current identifier

VIM is capable of searching through the files in your include path to find instances of the identifier
currently under the cursor. The commands of interest are:

[i::
Display the first instance (which will normally be the declaring instance),

[I::
List all instances, both within include files and this file, and

[^I::
Jump straight to the first instance.

For these commands to work, you must have the "path" variable set correctly:

   set path=.,,**5

This sets the file search path as follows:

1. The current file's directory (.)
2. The current working directory (,, - the comma is actually the separator, but nothing inbetween them implies
   the current working directory)
3. All directories below that (**), but to a maximum of 5 deep

This assumes that you follow my working style of ensuring that the current working directory is always the root of the
check-out.

Folding
-------

First scratchings. Works OKish for Python, though it makes a breakfast of doc comments and doctest:

   set foldmethod=indent

zo::
zc::
Open and close individual folds

zO::
zC::
Open and close recursively under the cursor

zm::
zr::
Fold more and fold reduce across the file, by one level

zM::
zR::
Open and close (Maximise and Reductio ad absurdum) *all* folds

zn::
zN::
zi::
Fold none, Normal, or invert (toggle) `foldenable`, to temporarily turn folding on and off

[z::
]z::
Start and end of the currently open fold

zk::
zj::
Move to previous and next folds (up/down)

Tabs
----

Tab pages provide different sets of windows into the *same* buffers, similar to desktop workspaces.
Use them when you need to do something without spoiling your current window pane layout.

:tabnew;;
New tab page, nothing in it.

:tab split;;
View this buffer in a new tab page.

:tabs;;
List the tabs. Only shows open windows, not all the buffers (the buffers are common to all tab pages, remember).

gt, gT;;
Next, previous tab.

Printing
--------

Set preferred margins in the vimrc file using the printoptions setting, eg:

   set printoptions=left:10mm,top:10mm,right:10mm,bottom:10mm

Print using File, Print, or by using the hardcopy command:

   :ha

Assuming that the printfont is 10 point Courier, then you can lay the pages out as follows:

Plain text on A4::
Text up to 80 characters across will fit onto A4 portrait

Plain text, 2-up on A4::
Select A4 portrait, 2 pages per sheet

Code on A4::
Code up to about 130 characters across will fit onto A4 landscape

Code, 2-up on A3::
Select A3 portrait, 2 pages per sheet. This is my preferred format for printing code. Select duplex, "flip on long
edge".

Under Windows, these settings can be changed from the print dialogue box, but under Linux, you need to change the
printoptions. A4 portrait is the default:

   :set popt+=portrait:n,paper:A3

Ex command-line editing
-----------------------

### Pasting into the command line

Paste text into the command line by using a Ctrl-R followed by:

Ctrl-W::
The word under the cursor

Ctrl-A::
The WORD under the cursor

/::
The last / search string

"::
The contents of the unnamed register, containing the text of the last delete or yank

*::
The clipboard

%::
The current file name


### Current file name

To pass the current file name into a shell command, use the % character:

   :!attrib -r %

Of course, I've mapped this particular command to ,wr in my vimrc file.

These ones are good, too:

#3::
Name of the file in buffer 3

%:p::
Current file name complete with its full path

%:h::
Just the path to the current file, eg. :cd %:h changes the default directory to the current file's directory. I don't
know why, but % sometimes expands to the full path, and sometimes only to the filename without the path. In the latter
case, you need to use %:p:h to get the path to the current file.

%:r::
Current file name without its extension. To edit the file that has the same name as the current file,
but the extension .sm:

   :e %:r.sm

`:echo expand("%:r")`::
So exactly what do I get from a "%:r"?

Ctrl-G::
So what is the current file name (normal mode only)?

1Ctrl-G::
Fully-qualified


### Argument list

`:args *.c`;;
Set the arglist to all the *.c files, and edit the first one

`:args **/CMakeLists.txt`;;
Set the arglist to all the CMakeLists.txt files in any subdirectory below the current one ...

`:args ../**/CMakeLists.txt`;;
\... or below the next directory up

Working with other applications
-------------------------------

### SSH

   :e scp://username@hostname//path/to/document

Don't know yet how to manage a password. Works best with keys.


### Web-browser

To preview the current html file in a web-browser:

   :!start firefox "%"

Of course, I've mapped this to a key-stroke (,wb)


### Windows Explorer

To open new files into the currently-open gvim instance by default, add the --remote-silent option to the command line.
In Windows Explorer, the Tools, Options, File Types, Advanced, Open, Application used to perform action should be set
to:

   C:\Vim\vim62\gvim.exe --remote-silent "%1"

Stuff I can't do yet
--------------------

In no particular order...

1. Annotate, and other vcs functions - I want to enter my normal vcs commands, and have the output captured into
   a non-file buffer for viewing, and potentially saving as batch file.
2. Browse the open buffers in the error or location window, and press Enter on the buffer I want to go to
3. Move the current window up by one
4. make, and click-through to the error lines
5. grep this file, see and go to the various lines - well, I can do this one too, but it also needs polishing
6. Modify the colourings and indentation for different file types, notably html files. In fact, the
   auto-indentation for HTML is a complete PITA at the moment.
7. Use the arrow keys when doing a visual selection
8. Use the h key to move from the start of this line to the end of the preceding line
9. Use ,/* to comment the selected block in my preferred block-comment style.
10. Auto-enter HTML tags
11. Auto-fold HTML/XML files
12. Re-load a VIM script file without having to exit and restart VIM
13. Move this open file into the previous VIM instance, and close this new instance. Potentially automate this,
    so that I only ever have one instance of VIM open.
14. Title case

[1]: http://vim.wikia.com/wiki/Best_Vim_Tips
[2]: https://github.com/tpope/vim-surround
[3]: http://ctags.sourceforge.net/
[4]: http://www.vim.org/scripts/script.php?script_id=273

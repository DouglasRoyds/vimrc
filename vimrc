" Douglas's vimrc
" Contains settings that apply equally to either Windows or Linux platforms, and any workstation.
" Specific configuration files for Windows, Gnome, WS1788, and so on are in the vimfiles/plugins directory.
" On Windows, symlink _vimrc and _gvimrc into $HOME (C:\Users\UserName) using the mklink command (as admin).
" Note that the path to the target file must be fully-qualified:
"     C:\Users\UserName> mklink _vimrc C:\Users\UserName\vimfiles\_vimrc

"-------------------------------------- Stuff from the standard vimrc file --------------------------------------------

" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible
set cpoptions-=a        " Don't change the alternate filename when using :read file

"-------------------------------------- Vundle ------------------------------------------------------------------------
" See https://github.com/gmarik/vundle

" Initialise
filetype off
set runtimepath+=~/.vim/bundle/vundle/,$HOME/vimfiles/bundle/vundle
call vundle#rc()

" Vundle must manage Vundle (required)
Bundle 'gmarik/vundle'

" GitHub
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-surround'

" vim-scripts repos
"Bundle 'L9'

" Non-GitHub
"Bundle 'git://git.wincent.com/command-t.git'

filetype plugin indent on     " Required

"-------------------------------------- Default settings --------------------------------------------------------------

" Allow backspacing over everything in insert mode
" This is overwritten by the mswin.vim settings - I don't know what these settings should be in the general case
set backspace=indent,eol,start

set history=50          " keep 50 lines of command line history
set ruler               " show the cursor position all the time
set showcmd             " display incomplete commands

" Default indenting and wrap
set autoindent          " Carry indent over to new lines
set nojoinspaces        " Don't insert two spaces after . ? and ! with Join command
set linebreak           " Word-wrap lines on screen at sensible characters, ie. not in the middle of words
set shiftround          " Round indent to multiples of shiftwidth with < and > commands
set expandtab           " To spaces
set shiftwidth=3        " Number of spaces to use
set softtabstop=3       " Allows tabstop to remain at 8, but the Tab key inserts 3
set tabstop=8           " For hard tab characters
set textwidth=128       " Maximum line length before inserting line break
set virtualedit=block   " Allow the cursor to move past the end of the line in visual block mode
set nowrap                    " Off by default - I have mapped F6 to toggle wrap
set whichwrap=b,s,<,>,[,]     " Move to previous/next line on BS, space, left/right keys in normal & insert modes
set nostartofline             " Don't move the cursor to the start of the line on page up/down (ctrl-U/D etc)
set display=lastline          " Show as much as possible of the last line on screen, rather than just the @ symbols
set listchars=eol:$,tab:T-,trail:.	" Special characters to display when :set list is on

" Text folding
" These are Greg Bodnar's options, and I haven't investigated them yet
set foldenable
set foldlevelstart=1

" File handling. Mac isn't in the default set
set fileformats=unix,dos,mac
set nobackup

" Characters that form pairs for the % command
set matchpairs=(:),{:},[:]

" list suffix patterns that are less likely to be used during tab-completion
set suffixes=.bak,~,.swp,.o,.log,.dvi,.idx,.toc,.dxe

set wildmode=longest,list           " Tab complete till longest common string, then list all matches
set diffopt=filler,vertical,iwhite  " Show filler lines, default to vertical diff, and ignore whitespace

" Complete silence. No flashing, no beeping, nothing.
" Turn the visualbell on, but set it to nothing at all
set visualbell
set t_vb=

"-------------------------------------- Colours -----------------------------------------------------------------------

" GNOME Terminal supports 256 colors, but doesn't advertise its support
" See http://askubuntu.com/questions/67/how-do-i-enable-full-color-support-in-terminal
if $COLORTERM == 'gnome-terminal'
  set t_Co=256
endif

" Switch syntax highlighting on, when the terminal has colors
if &t_Co > 2 || has("gui_running")
  syntax on
endif

" Background colour
" I keep my terminal very dark.
" gvim should adopt a background setting according to its loaded colorscheme.
if ! has('gui_running')
    set background=dark
endif

" Brute-force.
" TODO:  What's the elegant way of doing this?
" Setting ctermfg=6 turns off the cterm=bold bit
highlight Comment ctermfg=6

"-------------------------------------- Printing ----------------------------------------------------------------------

set printexpr=PrintFile(v:fname_in,v:cmdarg)
function! PrintFile(fname,args)
   " gtklp provides a (somewhat OTT) print dialog for lpr
   call system('gtklp' . ' ' . v:fname_in)
   call delete(v:fname_in)
   return v:shell_error
endfunc

set printoptions=left:10mm,top:10mm,right:10mm,bottom:10mm
set printheader=%>%t%=Page\ %N

"-------------------------------------- Spelling ----------------------------------------------------------------------

set nospell
set spelllang=en_nz
set spellfile=~/.vim/douglas.add,~/.vim/code.add
set spellsuggest=9

set thesaurus=~/.vim/mthesaur.txt

"-------------------------------------- Searching ---------------------------------------------------------------------

set incsearch
set hlsearch
set ignorecase
set smartcase

" File and directory search path:
"   1. The current file's directory
"   2. The current working directory
"   3. All directories below the current working directory, but only 5 deep
" When working within a project, I always (manually) set the current working
" directory to the root of the project.
set path=.,,**5
set cdpath=.,,**5

" Reduce the special characters that are recognised as part of a filename, to make gf more effective.
" @      A-Z,a-z
" 48-57  0-9
set isfname=@,48-57,/,.,-,_,+,#,$,%,~

" Grep
"  egrep       Full regular expressions, saving confusion about which characters are special and which are not
"  -H          Show the filename, even when only one file is searched
"  -I          --binary-files=without-match, that is, ignore binary files
"  -n          Line numbers
"  $*          Not a Bash variable - this is a special notation to Vim to drop all parameters in here.
"              Parameters can be quoted on the Ex command line, eg. :grep "this and that" %
set grepprg=egrep\ --exclude-dir={generated,.svn,tags}\ --exclude={*.html}\ -HIn\ $*

"-------------------------------------- Function keys -----------------------------------------------------------------

"       F3 will be Grep - Grep within this file
" Shift-F3 will be recursive grep
" Shift-F3 isn't working for now, so I'll make straight F3 do the recursive grep
"  Ctrl-F3 will be toggle highlight search
nmap <F3>   :grep '<C-R><C-W>' -rn .
nmap <S-F3> :grep <C-R><C-W> -rn .
nmap <C-F3> :set hlsearch!<CR>
imap <F3>   <C-O><F3>
imap <S-F3> <C-O><S-F3>
imap <C-F3> <C-O><C-F3>
" Just because I can't get Ctrl-F3 to work in the console
nmap <Leader>hls :set hlsearch!<CR>

" Ctrl-F4 will close the current window and buffer
" Use Ctrl-Shift-F4 if the file hasn't been saved
nmap <C-F4> :bd<CR>
nmap <C-S-F4> :bd!<CR>

" Toggle word-wrap
nmap <F6> :setl wrap!<bar>:set wrap?<CR>
imap <F6> <C-O><F6>

" Toggle spell-check
nmap <F12> :set spell!<CR>
imap <F12> <C-O><F12>

"-------------------------------------- Key-stroke mappings -----------------------------------------------------------

" Backspace key will delete, not just move the cursor
nmap <BS> X

" Back and forward to previous/next location, browser-style
nmap <M-Left> <C-O>
nmap <M-Right> <Tab>

" Make Y and S behave like other "capital" commands, and yank/substitute to the end of the line
map Y y$
map S c$

" I prefer to move up and down display-line-wise, rather than text line-wise.
nmap j gj
nmap k gk

" Movement key acceleration: Hold down the ctrl key to move up and down in
" steps of 5, or left and right in half screen-widths
nmap <c-J> 5j
nmap <c-K> 5k
nmap <c-H> :normal <C-R>=winwidth(0)/2<CR>h<CR>
nmap <c-L> :normal <C-R>=winwidth(0)/2<CR>l<CR>

" zZ scrolls the cursor to centre of the screen horizontally
" zs leaves the cursor 3 places in from the left edge, like zt does
" ze leaves the cursor 3 places in from the right edge, like zb does
nnoremap zZ zs:normal <C-R>=winwidth(0)/2<CR>zh<CR>
nnoremap zs zs3zh
nnoremap ze ze3zl

" Title Capitalisation
" Taken from Tip #617: Fun with case twiddling
" Start of word, any one letter is capitalised, any number (0 or more) letters are lowered
vnoremap <silent> T :s/\<\(\w\)\(\w*\)\>/\u\1\L\2/g<CR>
" Error: Changes Douglas's --> Douglas'S, so I need to change iskeyword for the duration
" Error: Changes MHz, dBm --> Mhz, Dbm, so I don't want to change mixed-case words
" Error: Need to add the list of words that shouldn't be capitalised, eg. the, is, of, ...
"           vnoremap T :s/\<\(is\\|of\\|the\)\>\\|\<\(\w\)\(\w*\)/\L\1\u\2\L\3/g<CR>
"        but this will leave an opening or closing "to Be or Not to?" not capitalised.
"        I think we're getting beyond what can be done in one regular expression here.
" How can I map gT<movement character> to do this?

" vimdiff
" do and dp work fine, but they don't jump to the next diff
nnoremap do :diffget<CR>]c
nnoremap dp :diffput<CR>]c

"-------------------------------------- Leader mappings ---------------------------------------------------------------

" The \ key is inconveniently located on my work keyboard
let mapleader=","
let maplocalleader=","

" Change directory to that containing the current file
nmap <Leader>cd :cd %:h <bar> pwd<cr>
nmap <Leader>lcd :lcd %:h <bar> pwd<cr>

" Copy the current fully-qualified filename and filepath into the clipboard
nmap <Leader>fn :let @+=expand("%:p")<cr>
nmap <Leader>fp :let @+=expand("%:p:h")<cr>

" Trim trailing spaces
nmap <Leader>ts :%s/\s\+$//g<CR><C-O>

" Twiddle words right and left.
" With very-magic turned on:
"     < and >     Whole-word delimiters
"     \k          Keyword characters from iskeyword
"     %#          Cursor position
"     \_.         Any character, including end-of-line
"     {-}         0 or more, but as few as possible (ie. like *, but not greedy)
" See http://vim.wikia.com/wiki/Exchanging_adjacent_words
nmap <Leader>tw :s/\v(<\k*%#\k*>)(\_.{-})(<\k+>)/\3\2\1/<CR><C-O>:set nohlsearch<CR>
nmap <Leader>tW :s/\v(<\k+>)(.{-})(<\k*%#\k*>)/\3\2\1/<CR><C-O>:set nohlsearch<CR>

" Preview the current file in the browser
" I have yet to work out a way to make this OS-independent
nmap <Leader>wb :!firefox '%' &<cr>

" Make the current file writable
" I'd like to hook this one into CVS some time - branch the current file
nmap <Leader>wr :silent !attrib -r %<CR>:set noreadonly<CR>

" Write and source the current file (works for vimrc)
nmap <Leader>ws :w<CR>:source %<CR>

"-------------------------------------- Window and buffer behaviour ---------------------------------------------------

" Caret key always writes and switches
set autowrite
inoremap <C-^> <Esc><C-^>

" I want new windows as big as possible, as I'll flick between them with <Leader>j and k
set winheight=999
set noequalalways
set browsedir=buffer
set scrolloff=2

" Ctrl-Tab to rotate between open buffers within the current window
nmap <C-Tab> :bn<CR>
nmap <C-S-Tab> :bp<CR>

" Go up or down one window and maximise it
" Move left and right one window won't change the window sizes
nmap <Leader>j <C-W>j<C-W>_
nmap <Leader>k <C-W>k<C-W>_
nmap <Leader>h <C-W>h
nmap <Leader>l <C-W>l

" Never show the irritating tab line at the top of the console
set showtabline=0

"-------------------------------------- Commenting/Uncommenting code --------------------------------------------------
" Horrors! .vimrc is not the place for this.
" I want one mapping for line comments, one for blocks.
" The file type should determine the resulting comment style.
" Can I select a line or block comment according to visual or normal mode?
" Kinda works:
nmap <Leader>// I// <Esc>
" Almost kinda works:
vmap <Leader>// s/*<CR>/<Esc>P
"" Line comments
"map <Leader># :s/^/#/<CR>                                   " Shell, gawk comment
"map <Leader>/ :s/^/\/\/ /<CR>                               " C++ comment
"map <Leader>" :s/^/\"/<CR>                                  " Vim comment
"map <Leader>c :s/^\/\/\\|^[#"]//<CR>                        " Remove line comments
"
"" Block comments - These aren't at all what I require - they put the comment around each individual line
""                  In fact, they're so bad that I'm not using them
"map <Leader>* :s/^\(.*\)$/\/\* \1 \*\//<CR>                             " C block comment
"map <Leader>< :s/^\(.*\)$/<!-- \1 -->/<CR>                              " HTML block comment
"map <Leader>d :s/^\([/(]\*\\|<!--\) \(.*\) \(\*[/)]\\|-->\)$/\2/<CR>    " Remove block comments

"-------------------------------------- Edit specific files -----------------------------------------------------------

" Find my vimrc file, which is symlinked out of ~/.vim or $HOME/vimfiles (on Windows)
command! Vimrc execute 'split '.findfile('vimrc', $HOME.'/.vim,'.$HOME.'/vimfiles')
command! Tips  split ~/Documents/Technology/Open\ source\ software/Applications\ and\ projects/Editors/Text/VIM/tips.txt

"-------------------------------------- Custom commands ---------------------------------------------------------------

" I frequently still have my finger on the shift key when I try to type the w of a :w command
command! W w
command! Ls ls

" I often want to write the current file and move on to the next file in the corrections list
command! Wcn w | :cn

" Convert a file to Dos/Unix format
" Copes with the mixed-format case, in which Vim has decided that, as not all lines end with a <CR><LF>, it must be a
" Unix file. Erase all the rogue <CR>s, then set the fileformat to Dos/Unix, which puts them all back correctly
command! Dos :%s/$//e | :%s// /e | set fileformat=dos
command! Unix :%s/$//e | :%s// /e | set fileformat=unix

" This works OK, but I also want to split the window vertically, and display
" the blame in the leftmost window, with scrolling locked to the current file.
command! Blame :!cvs annotate %

command! -complete=file -nargs=+ Bzr  :!bzr <args>
command! -complete=file -nargs=+ Cvs  :!cvs <args>
command! -nargs=+ Thes :!aiksaurus <args>

"-------------------------------------- Taglist plug-in settings ------------------------------------------------------

let Tlist_WinWidth="45"

" Open and close the tag list (taglist.vim):
nmap <Leader>tl :Tlist<CR><C-W>h

"-------------------------------------- Exuberant ctags --------------------------------------------------------------

" Run ctags on the cwd (default) or the provided directory
"  -R          Recursive
"  --totals    Nice little summary to give me some eye-candy
"  +q          Include an extra class-qualified tag entry for each tag which is a member of a class
"  +iaS        Added inheritance information, access of class members, and Signature of routine
"  +p          Add function prototypes
"              Above two settings required to allow omnicppcomplete to work
"              (see http://vim.wikia.com/wiki/C++_code_completion)
" TODO: Specifying a subdirectory (as the args) drops the resulting tags file into the cwd
command! -complete=dir -nargs=* Ctags :!ctags -R --totals --extra=+q --fields=+iaS --c++-kinds=+p <args>

" tags file search path:
"   1. The current file's directory, as this tags file will be the most up-to-date
"   2. The current working directory, to pick up this component's tags file
" TODO: Staging usr/lib
"set tags=./tags,./TAGS,tags,TAGS

augroup ctags
   autocmd!
   " Rerun ctags on the file when we save it
   " Must be run from the directory of the file being saved, as we can't know what the cwd is,
   " and it'd be a shame to issue ctags -R from the home directory, for instance
   "autocmd BufWritePost *.{c,h,cpp,hpp} :silent !cd %:p:h && ctags -R --extra=+q --fields=+iaS --c++-kinds=+p
augroup END

"-------------------------------------- VCSCommand plug-in -----------------------------------------------------------

" Automatically delete temporary VCS result buffers when hidden.
let VCSCommandDeleteOnHide="Yes"

"-------------------------------------- Autocommands -----------------------------------------------------------------
" Put everything in an autocmd group, so that we can delete them easily with the autocmd! command.
" This is required in case the vimrc is sourced twice (e.g. after editing), and is standard Vim practice (not my idea).
augroup vimrc
   autocmd!

   " Enable file type detection, file-type plug-ins, and indent files
   filetype plugin indent on

   " When editing a file, always jump to the last known cursor position.
   " Don't do it when the position is invalid or when inside an event handler (when dropping a file on gvim).
   autocmd BufRead *
      \ if line("'\"") > 0 && line("'\"") <= line("$") |
      \   exe "normal g`\"" |
      \ endif

   " Vim Tip 1375 (http://vim.wikia.com/wiki/Avoid_scrolling_when_switch_buffers)
   " Prevent Vim centring the current line in the window when switching buffers.
   " Leaves the current line at its original position in the window
   autocmd BufLeave * let b:winview = winsaveview()
   autocmd BufEnter * if (exists('b:winview')) | call winrestview(b:winview) | endif

augroup END

" Trim all trailing space on every write
" http://vim.wikia.com/wiki/Remove_unwanted_spaces
" In its own augroup so that it can be safely deleted by projects that don't want it
augroup trim_trailing_spaces
   autocmd!
   autocmd BufWritePre * :%s/\s\+$//e
augroup END

"-------------------------------------- Extra scripts and plugins ----------------------------------------------------

" ftplugin/man.vim has to be sourced at startup so that the :Man command is available
" They have done a bit of special trickery in the man.vim ftplugin file to avoid having a separate plugin/man.vim
runtime ftplugin/man.vim

" Source Douglas's various (optional) runtime configuration files
execute "runtime runtime/" . &term . ".vim"
execute "runtime runtime/" . hostname() . ".vim"


" Douglas's vimrc
" Contains settings that apply equally to either Windows or Linux platforms, and any workstation.
" Specific configuration files for Windows, Gnome, hostname, and so on can be put in the plugins directory.
" On Windows, make a directory junction $HOME/vimfiles (C:\Users\UserName):
"     C:\Users\UserName> mklink /J vimfiles workspace\vimrc

"-------------------------------------- Vundle ------------------------------------------------------------------------
" See https://github.com/VundleVim/Vundle.vim

filetype off
set runtimepath+=~/.vim/bundle/Vundle.vim/,$HOME/vimfiles/bundle/Vundle.vim
call vundle#begin()
Plugin 'https://github.com/VundleVim/Vundle.vim'         " Vundle must manage Vundle (required)

Plugin 'https://github.com/airblade/vim-gitgutter'       " Jump with ]c, stage/unstage hunks with <Leader>hs/hu
Plugin 'https://github.com/chrisbra/unicode.vim'         " Digraph search, autocompletion
Plugin 'https://github.com/ctrlpvim/ctrlp.vim'           " Fuzzy file, buffer, most-recently-used, ctag finder
Plugin 'https://github.com/drmikehenry/vim-fixkey'       " Non-ASCII terminal keys, eg. <S-F3>, <M-F3>
Plugin 'https://github.com/embear/vim-localvimrc'        " Source .local.vim file in the root of a project directory
Plugin 'https://github.com/jceb/vim-shootingstar'        " Like the magic * but start matching at the cursor position
Plugin 'https://github.com/justinmk/vim-sneak'           " ff and FF movements
Plugin 'https://github.com/moll/vim-bbye'                " Bdelete buffers without wrecking my window layout
Plugin 'https://github.com/tpope/vim-abolish'            " Subvert/child{,ren}/adult{,s}/g and coerce case with crs/m/c/u
Plugin 'https://github.com/tpope/vim-commentary'         " Comment stuff out with gcc, gcap, (visual) gc
Plugin 'https://github.com/tpope/vim-dispatch'           " Make and test in the background using tmux and F9
Plugin 'https://github.com/tpope/vim-fugitive'           " All things :Git and :Gstatus
Plugin 'https://github.com/tpope/vim-repeat'             " Makes the . command work with plugins, notably vim-surround
Plugin 'https://github.com/tpope/vim-speeddating'        " Ctrl-A/X for dates and times
Plugin 'https://github.com/tpope/vim-surround'           " Parentheses and quotes etc. with cs), ds>, ysiw], etc.
Plugin 'https://github.com/tpope/vim-unimpaired'         " Many mappings, eg. ]q for :cnext, and yoh for :set hlsearch!
Plugin 'https://github.com/tpope/vim-vinegar'            " Press - for a directory listing
Plugin 'https://github.com/vim-airline/vim-airline'      " Statusline
Plugin 'https://github.com/vim-airline/vim-airline-themes'
Plugin 'https://github.com/vim-scripts/DirDiff.vim'      " DirDiff dirA dirB<cr>, <CR> on a file to diff it

" Colorschemes
Plugin 'https://github.com/felixhummel/setcolors.vim'
Plugin 'https://github.com/morhetz/gruvbox'
Plugin 'https://github.com/nanotech/jellybeans.vim'
Plugin 'https://github.com/w0ng/vim-hybrid'
Plugin 'https://github.com/sainnhe/gruvbox-material'
Plugin 'https://github.com/sainnhe/sonokai'
Plugin 'https://github.com/cocopon/iceberg.vim'
Plugin 'https://github.com/sainnhe/everforest'

" Code completion using clangd, must be recompiled after update:
"     $ cd bundle/YouCompleteMe/
"     $ ./install.py --clangd-completer
Plugin 'https://github.com/ycm-core/YouCompleteMe'

call vundle#end()             " Required
filetype plugin indent on     " Reenable file type detection, file-type plug-ins, and indent files (required)

"-------------------------------------- Plug-in settings --------------------------------------------------------------

" Don't load localvimrc file in a sandbox, ie. allow it to do anything
" Store and restore decisions only if the answer was given in upper case (Y/N/A)
let g:localvimrc_name = ['.local.vim', '.IDR.local.vim']
let g:localvimrc_sandbox = 0
let g:localvimrc_persistent = 1
let g:localvimrc_persistence_file =  $HOME."/.localvimrc/persistent"

set updatetime=500                  " Speeds gitgutter response

" I've always really liked the s and S commands, so use ff and FF for vim-sneak
nmap ff <Plug>SneakForward
nmap FF <Plug>SneakBackward
"vmap ff <Plug>SneakForward      " Not working
"vmap FF <Plug>SneakBackward

noremap <Leader>bd :Bdelete<cr>

" Instructions at https://vi.stackexchange.com/a/16512
" Linux:
"     $ sudo apt install fonts-powerline
"     Don't use the font directly, just check that SourceCodePro for Powerline is available.
" Windows:
"     $ git clone --depth 1 https://github.com/powerline/fonts
"     Install the Adobe SourceCodePro fonts by dragging and dropping them (all) into the Fonts Settings.
"     Set the mintty font to SourceCodePro for Powerline.
let g:airline_theme='deus'
let g:airline_powerline_fonts = 1

let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]\.(git|hg|svn)$',
  \ 'file': '\v\.(exe|so|dll)$',
  \ }

" Don't use Vim's sw=2 sts=2 default settings, see /usr/share/vim/vim82/ftplugin/yaml.vim
let g:yaml_recommended_style = 0

"-------------------------------------- Default settings --------------------------------------------------------------

" This is overwritten by the mswin.vim settings - I don't know what these settings should be in the general case
set backspace=indent,eol,start   " Allow backspacing over everything in insert mode

set cpoptions-=a                    " Don't change the alternate filename when using :read file
set cryptmethod=blowfish            " Use :X to turn on encryption for a file
set diffopt=filler,vertical         " Show filler lines (useful for vertical splits), default to vertical diff
set fileformats=unix,dos,mac        " Mac isn't in the default set
set foldenable                      " On by default, toggle it with zi
set foldlevelstart=1                " Start with all but the top-level folds closed
set history=1000                    " lines of command-line history
set listchars=eol:$,tab:T-,trail:.  " Special characters to display when :set list is on
set matchpairs=(:),{:},[:]          " Characters that form pairs for the % command
set nobackup
set ruler                           " show the cursor position all the time
set showcmd                         " display incomplete commands
set t_vb=                           " Turn the visualbell on, but set it to nothing at all
set visualbell                      " Complete silence. No flashing, no beeping, nothing.
set wildignore=*.so,*.swp,*.zip     " Tab-completion file globs to ignore
set wildignorecase                  " Case-insensitive Tab completion
set wildmode=longest,list           " Tab complete till longest common string, then list all matches

set suffixes=.bak,~,.swp,.o,.log,.dvi,.idx,.toc,.dxe     " Extensions to demote during tab-completion

" Default indenting and wrap
set autoindent             " Carry indent over to new lines
set breakat=\ \	!@*+;:,?=  " But don't split filenames and paths
set breakindent            " Do indent lines wrapped by linebreak
set display=lastline       " Show as much as possible of the last line on screen, rather than just the @ symbols
set linebreak              " Word-wrap lines on screen at sensible characters, ie. not in the middle of words
set nojoinspaces           " Don't insert two spaces after . ? and ! with Join command
set nostartofline          " Don't move the cursor to the start of the line on page up/down (ctrl-U/D etc)
set nowrap                 " Off by default - I have mapped F6 to toggle wrap
set textwidth=107          " Maximum line length before inserting line break
set virtualedit=block      " Allow the cursor to move past the end of the line in visual block mode
set whichwrap=b,s,<,>,[,]  " Move to previous/next line on BS, space, left/right keys in normal & insert modes

" These are :set sr et sw=3 sts=3 ts=8
set expandtab           " To spaces
set modeline            " Might as well respect it if it's there
set shiftround          " Round indent to multiples of shiftwidth with < and > commands
set shiftwidth=3        " Number of spaces to use
set softtabstop=3       " Allows tabstop to remain at 8, but the Tab key inserts 3
set tabstop=8           " For hard tab characters

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

" I set the cursorline on with an autocmd on WinEnter (see the autocmds section below).
" With the aid of vim-unimpaired, cursorcolumn can be toggled with cou
set cursorline
highlight CursorLine   cterm=NONE term=NONE ctermbg=234
highlight CursorColumn cterm=NONE term=NONE ctermbg=234
highlight Normal     ctermbg=NONE guibg=NONE

let g:jellybeans_use_gui_italics = 0
let g:jellybeans_overrides = { 'Search': {'attr': 'reverse'} }    " Underline begone
let g:gruvbox_italic = 0
let g:gruvbox_material_disable_italic_comment = 1
let g:sonokai_disable_italic_comment = 1
let g:everforest_disable_italic_comment = 1

" The setcolors.vim script is sourced very late in the list of scriptnames,
" so the SetColors command is not available while sourcing the vimrc file.
augroup setcolors
   autocmd!
   autocmd VimEnter * SetColors industry torte jellybeans gruvbox gruvbox-material hybrid sonokai iceberg everforest
   autocmd ColorScheme * highlight Normal guibg=NONE ctermbg=NONE                   " Always transparent background
   autocmd ColorScheme * highlight CursorColumn cterm=NONE term=NONE ctermbg=234    " No underline cursorline, thanks
   autocmd ColorScheme * highlight CursorLine   cterm=NONE term=NONE ctermbg=234
   autocmd ColorScheme * highlight VertSplit    cterm=NONE term=NONE ctermbg=234
augroup END
colorscheme jellybeans

"-------------------------------------- Printing ----------------------------------------------------------------------

" :hardcopy
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

" Use ctrl-X-K/P to browse dictionary completions
set nospell
set spelllang=en_nz
set spellsuggest=9
if ! exists('+shellslash')    " ie. we're not on Windows
   " I have found no way of specifying a drive name under Windows
   " This works:     /Users/Us/vimfiles/douglas.add
   " This doesn't: C:/Users/Us/vimfiles/douglas.add
   set spellfile=~/.vim/douglas.add,~/.vim/code.add
endif

" Use ctrl-X-T/P to browse thesaurus completions
set thesaurus=~/.vim/mthesaur.txt

"-------------------------------------- Searching ---------------------------------------------------------------------

set incsearch
set hlsearch
set ignorecase
set smartcase

" File and directory search path:
"   1. . = The current file's directory
"   2. ,, = The current working directory
"   3. **5 = All directories below the current working directory, but only 5 deep
" When working within a project, I always (manually) set the current working directory to the root of the project.
" cdpath default value is taken from $CDPATH, with a , prepended to look in the current directory first.
" ... thoeretically: In practice, vim doesn't appear to be reading my $CDPATH at all.
set path=.,,**5
set cdpath+=**5

" Reduce the special characters that are recognised as part of a filename, to make gf more effective.
" @      A-Z,a-z
" 48-57  0-9
set isfname=@,48-57,/,.,-,_,+,#,$,%,~

" Grep
" Using ack2 in place of grep.
" See https://github.com/petdance/ack2
" Parameters can be single-quoted on the Ex command line, eg. :grep 'this and that' %
" The regex alternate operator, '|', needs to be escaped to prevent Vim interpreting it as the command separator
set grepprg=ack\ -H\ --ignore-dir=generated\ --nohtml

"-------------------------------------- Function keys -----------------------------------------------------------------

"       F3 = Grep for the word under the cursor
" Shift-F3 = Grep only in this file's subdirectory (and its children)
noremap   <F3> :grep '<C-R><C-W>'
noremap <S-F3> :grep '<C-R><C-W>' %:h
imap      <F3> <C-O><F3>
imap    <S-F3> <C-O><S-F3>

" Toggle word-wrap
nnoremap <F6> :setl wrap!<bar>:set wrap?<CR>
imap     <F6> <C-O><F6>

nnoremap <F9> :Dispatch<CR>

nnoremap <F12> :YcmCompleter GoTo<CR>

"-------------------------------------- Key-stroke mappings -----------------------------------------------------------

" Backspace key will delete, not just move the cursor
nnoremap <BS> X

" Unset the last search pattern by hitting return, removing highlighting without turning hlsearch off
" From https://stackoverflow.com/a/662914/2411520
nnoremap <silent> <CR> :nohlsearch<CR><CR>

" Back and forward to previous/next location, browser-style
nnoremap <M-Left> <C-O>
nnoremap <M-Right> <Tab>

" Make Y and S behave like other "capital" commands, and yank/substitute to the end of the line
noremap Y y$

" I prefer to move up and down display-line-wise, rather than text line-wise.
nnoremap j gj
nnoremap k gk

" Movement key acceleration: Hold down the ctrl key to move up and down in
" steps of 5, or left and right in half screen-widths
nnoremap <c-J> 5j
nnoremap <c-K> 5k
nnoremap <c-H> :normal <C-R>=winwidth(0)/2<CR>h<CR>
nnoremap <c-L> :normal <C-R>=winwidth(0)/2<CR>l<CR>

" zz leaves the cursor line 10 lines *above* the middle of the screen
" zZ scrolls the cursor to centre of the screen horizontally: zs, zZ, ze
" zs leaves the cursor 3 places in from the left edge, like zt does
" ze leaves the cursor 3 places in from the right edge, like zb does
nnoremap zz zt30<C-Y>
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
" do and dp work fine, but they don't jump to the next diff.
" In visual mode, do the get or put, but don't jump to the next diff.
" Further to vim-unimpaired's yod to toggle diffthis, I commonly want to just turn the lot off, hence yoD
nnoremap do :diffget<CR>]c
nnoremap dp :diffput<CR>]c
vnoremap do :diffget<CR>
vnoremap dp :diffput<CR>
nnoremap yoD :diffoff!<CR>

" I type :w<CR> in my code a lot
inoremap :w<CR> <C-O>:w<CR>
inoremap :wq<CR> <C-O>:wq<CR>

"-------------------------------------- Pyclewn -----------------------------------------------------------------------

nnoremap [op :Cmapkeys<CR>
nnoremap ]op :Cunmapkeys<CR>
nnoremap cop :<C-R>=strlen(mapcheck("R")) ? 'Cunmapkeys' : 'Cmapkeys' <CR><CR>

"-------------------------------------- Leader mappings ---------------------------------------------------------------

" The \ key is inconveniently located on my work keyboard
let mapleader=","
let maplocalleader=","

" Change directory to that containing the current file
nnoremap <Leader>cd :cd %:h <bar> pwd<cr>
nnoremap <Leader>lcd :lcd %:h <bar> pwd<cr>
nnoremap <Leader>.. :lcd .. <bar> pwd<cr>

" Copy the current fully-qualified filename and filepath into the clipboard
nnoremap <Leader>fn :let @+=expand("%:p")<cr>
nnoremap <Leader>fp :let @+=expand("%:p:h")<cr>

" Trim trailing spaces
nnoremap <Leader>tts :%s/\s\+$//g<CR><C-O>

" Twiddle words right and left.
" With very-magic turned on:
"     < and >     Whole-word delimiters
"     \k          Keyword characters from iskeyword
"     %#          Cursor position
"     \_.         Any character, including end-of-line
"     {-}         0 or more, but as few as possible (ie. like *, but not greedy)
" See http://vim.wikia.com/wiki/Exchanging_adjacent_words
nnoremap <Leader>tw :s/\v(<\k*%#\k*>)(\_.{-})(<\k+>)/\3\2\1/<CR><C-O>:set nohlsearch<CR>
nnoremap <Leader>tW :s/\v(<\k+>)(.{-})(<\k*%#\k*>)/\3\2\1/<CR><C-O>:set nohlsearch<CR>

" Preview the current file in the browser
" I have yet to work out a way to make this OS-independent
nnoremap <Leader>wb :!firefox '%' &<cr>

" Make the current file writable
" I'd like to hook this one into CVS some time - branch the current file
nnoremap <Leader>wr :silent !attrib -r %<CR>:set noreadonly<CR>

" Write and source the current file (works for vimrc)
nnoremap <Leader>ws :w<CR>:source %<CR>

"-------------------------------------- Window and buffer behaviour ---------------------------------------------------

" Caret key always writes and switches
set autowrite
inoremap <C-^> <Esc><C-^>

" Normally, I move up and down between windows with the leader mappings below, which also maximise the height.
" By leaving winheight at the default 1, I can optionally move with C-W j/k, leaving windows at their current heights.
" Turning off equalalways prevents my carefully chosen window heights being wrecked when I close one window.
" Equalise them manually using C-W =
set winheight=1
set noequalalways
set scrolloff=2
set splitright             " I prefer new vertical splits to appear on the right
set showtabline=0          " Never show the irritating tab line at the top of the console

" Ctrl-Tab to rotate between open buffers within the current window
nnoremap <C-Tab> :bn<CR>
nnoremap <C-S-Tab> :bp<CR>

" Go up or down one window and maximise it
nnoremap <Leader>j <C-W>j<C-W>_
nnoremap <Leader>k <C-W>k<C-W>_

"-------------------------------------- Custom commands ---------------------------------------------------------------

command! Vimrc execute 'split '.$MYVIMRC
"command! Tips  split ~/.vim/doc/tips.md

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
nnoremap <Leader>tl :Tlist<CR><C-W>h

"-------------------------------------- Exuberant ctags --------------------------------------------------------------

" This needs more work - I haven't actually been using ctags.
"     http://ctags.sourceforge.net/

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

"-------------------------------------- Autocommands -----------------------------------------------------------------
" Put everything in an autocmd group, so that we can delete them easily with the autocmd! command.
" This is required in case the vimrc is sourced twice (e.g. after editing), and is standard Vim practice (not my idea).
augroup vimrc
   autocmd!

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

   autocmd WinEnter * setlocal cursorline
   autocmd WinLeave * setlocal nocursorline

augroup END

"-------------------------------------- Extra scripts and plugins ----------------------------------------------------

" ftplugin/man.vim has to be sourced at startup so that the :Man command is available
" They have done a bit of special trickery in the man.vim ftplugin file to avoid having a separate plugin/man.vim
runtime ftplugin/man.vim

" Source Douglas's various (optional) runtime configuration files
execute "runtime runtime/" . &term . ".vim"
execute "runtime runtime/" . hostname() . ".vim"


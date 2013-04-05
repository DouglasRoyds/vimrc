" runtime/xterm.vim
" Vim settings when running an xterm (eg. gnome-terminal)

" Sourced from my .vimrc only when &term=xterm, but belt-and-braces
if &term != "xterm"
   finish
endif

" Enable key-mapping timeout at the normal 1 second,
" but shorten the ttimeoutlen (just for terminal key-codes) to only 100ms
" This allows us to (for instance) map <F20> O1;5S, without Vim waiting every time we press <Esc>
" See http://vim.wikia.com/index.php?title=Mapping_fast_keycodes_in_terminal_Vim
set timeout
set timeoutlen=1000
set ttimeoutlen=100

" Vim does not have a KEY CODE for <C-F4>, so we have to set the terminal keycode to some unused key,
" then map the unused key to our desired KEY CODE
" See :help terminal-options, KEY CODES
set <F14>=O1;5S
map! <F14> <C-F4>
set <S-F14>=O1;6S     " Doesn't work, regrettably
map! <S-F14> <C-S-F4>

set <xF1>=[Z          " Doesn't work either
map! <xF1> <C-S-Tab>


" Vim filetype detection file
" Language:     BitBake
" Author:       Ricardo Salveti <rsalveti@rsalveti.net>
" Copyright:    Copyright (C) 2008  Ricardo Salveti <rsalveti@rsalveti.net>
" Licence:      You may redistribute this under the same terms as Vim itself
"
" This sets up the syntax highlighting for BitBake files, like .bb, .bbclass and .inc

if &compatible || version < 600 || exists("b:loaded_bitbake_plugin")
    finish
endif

" .bb, .bbappend and .bbclass
au BufNewFile,BufRead *.{bb,bbappend,bbclass}  set filetype=sh

" .inc
au BufNewFile,BufRead *.inc		set filetype=sh

" .conf
" But only if conf/ is in the fully-qualified path
au BufNewFile,BufRead *.conf
    \ if (match(expand("%:p:h"), "/conf/") > 0) |
    \     set filetype=sh |
    \ endif


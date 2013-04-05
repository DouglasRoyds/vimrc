" Vim filetype detection file
" Language:     Kbuild
" Author:       Douglas

if &compatible || version < 600
    finish
endif

" Kbuild
au BufNewFile,BufRead Kbuild	set filetype=make


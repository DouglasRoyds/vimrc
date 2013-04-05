" Vim filetype "after" file
" Language:	make
" Maintainer:	Douglas
" Douglas's preferred Make settings

" Add a debug message for the variable under the cursor
nnoremap <buffer> <Leader>dm yiwo$(info <Esc>pA = $(<Esc>pA))<Esc>0

" Make tab characters visible as an Error
" FIXME: Doesn't seem to work
syntax match TAB_CHAR "\t"
highlight link TAB_CHAR Error


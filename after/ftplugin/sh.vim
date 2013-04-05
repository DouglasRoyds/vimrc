" Vim filetype "after" file
" Language:	sh
" Maintainer:	Douglas
" Douglas's preferred Bash settings

setlocal shiftwidth=3
setlocal softtabstop=3

" Add a debug message for the variable under the cursor
nnoremap <buffer> <Leader>dm yiwoecho "<Esc>pA = ${<Esc>pA}"<Esc>


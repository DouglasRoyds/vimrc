" Vim filetype "after" file
" Language:	Python
" Maintainer:	Douglas
" Douglas's preferred Python settings

setlocal shiftwidth=4
setlocal softtabstop=4

" Add a debug message for the variable under the cursor
nnoremap <buffer> <Leader>dm yiwoprint("<C-R>" = %s" % <C-R>")<ESC>

" Line comments
nnoremap <buffer> <Leader>#  I# <Esc>
vnoremap <buffer> <Leader>#  :s/\m^/# /<CR>
nnoremap <buffer> <Leader>d# :s/\m^\(\s*\)# /\1/e<CR>
vnoremap <buffer> <Leader>d# :s/\m^\(\s*\)# /\1/e<CR>


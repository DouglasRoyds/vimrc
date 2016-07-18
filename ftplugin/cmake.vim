" Vim filetype plugin file
" Language:	cmake
" Maintainer:	Douglas
" Douglas's preferred CMake settings

" Add a debug message for the variable under the cursor
nnoremap <buffer> <Leader>dm yiwomessage("<Esc>pA = ${<Esc>pA}")<Esc>

" Treat hyphenated words as keywords as well, eg. libthis-thing
setlocal iskeyword+=-


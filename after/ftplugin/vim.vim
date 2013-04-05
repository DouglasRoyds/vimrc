" Vim filetype "after" file
" Language:	Vim scripts, .vimrc
" Maintainer:	Douglas
" Douglas's preferred Vim-script settings

" Add a debug message for the variable under the cursor
"nnoremap <buffer> <Leader>dm yiwo$(info <Esc>pA = $(<Esc>pA))<Esc>

" Blank keywordprg has a special meaning, which is to search the Vim help
set keywordprg=

" Add a debug message for the variable under the cursor
nnoremap <buffer> <Leader>dm yiWoecho "<Esc>pA = " . <Esc>p


" .vim/ftplugin/markdown.vim
" Douglas's preferred plain text Markdown settings
" See http://daringfireball.net/projects/markdown/
" and http://www.stack.nl/~dimitri/doxygen/markdown.html

setlocal shiftwidth=4
setlocal softtabstop=4

" Keyboard mappings that make the current line a two-line title, level 0 through 4
nnoremap <buffer> <LocalLeader>t1 yypv$r=
nnoremap <buffer> <LocalLeader>t2 yypv$r-
nnoremap <buffer> <LocalLeader>t3 I### A ###
nnoremap <buffer> <LocalLeader>t4 I#### A ####
nnoremap <buffer> <LocalLeader>t5 I##### A #####

" Generate a markdown table-of-contents line for this heading
"
" This is a heading    <--- Place cursor on this line, and issue <Leader>toc
" -----------------
nnoremap <buffer> <LocalLeader>toc yyppkI * [A](#j0gu$:s# #-#gekJxA)

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

" Override my normal Web Browser mapping to open the generated HTML page
nnoremap <buffer> <LocalLeader>wb :!firefox '%:p:r.html' &<CR>

" Convert an ASCII-art tree into UTF-8
vnoremap <buffer> <LocalLeader>tr :s/\|--/├──/<CR>gv:s/`--/└──/<CR>gv:s/\|   /│   /g<CR>


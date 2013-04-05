" Vim filetype "after" file
" Language:	asciidoc
" Maintainer:	Douglas
" Douglas's preferred plain text AsciiDoc settings

compiler asciidoc
command! Asciidoc !asciidoc '%'

" Generate a pdf file in the same directory, with the same base name
"command! Asciidoc :write | !asciidoc "%"

let maplocalleader=","

" Keyboard mappings that make the current line a two-line title, level 0 through 4
nnoremap <buffer> <LocalLeader>t0 yypv$r=
nnoremap <buffer> <LocalLeader>t1 yypv$r-
nnoremap <buffer> <LocalLeader>t2 yypv$r~
nnoremap <buffer> <LocalLeader>t3 I==== 
nnoremap <buffer> <LocalLeader>t4 I===== 

" Override my normal Web Browser mapping to open the generated HTML page
nnoremap <buffer> <LocalLeader>wb :!firefox '%:p:r.html' &<CR>

" Convert an ASCII-art tree into UTF-8
vnoremap <buffer> <LocalLeader>tr :s/\|--/├──/<CR>gv:s/`--/└──/<CR>gv:s/\|   /│   /g<CR>


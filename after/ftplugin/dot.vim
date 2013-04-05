" Vim filetype "after" file
" Language:	dot
" Maintainer:	Douglas
" Only modifies the standard dot filetype settings

compiler dot

" Label - Take the dot keyword under the cursor, and create a new entry at the head of the file with a [label="Nice readable text"]
command! Label :exe "normal yiwgg/label\<CR>}O\<ESC>p>>A [label=\"\"];\<ESC>F\"Pbf_r ;.;.;.;.;.;."

" Preferred settings
set textwidth=0

" Generate a pdf file in the same directory, with the same base name
command! Dot :write | !dot -Tpdf -o "%:p:r.pdf" "%"
command! Png :write | !dot -Tpng -o "%:p:r.png" "%"
command! Neato :write | !neato -Tpdf -o "%:p:r.pdf" "%"

" Override my normal Web Browser mapping to open the generated PDF
nnoremap <buffer> <Leader>wb :!evince '%:p:r.pdf' &<CR>


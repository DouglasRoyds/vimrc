" Open .c, .h, .sm files
nnoremap <buffer> <Leader>c :edit %:r.c<cr>
nnoremap <buffer> <Leader>h :edit %:r.h<cr>
nnoremap <buffer> <Leader>sm  :edit %:r.sm<cr>

" Line comments
nnoremap <buffer> <Leader>// I// <Esc>
vnoremap <buffer> <Leader>// :s/^/\/\/ /<CR>
nnoremap <buffer> <Leader>d/ :s/^\(\s*\)\/\/ /\1/e<CR>
vnoremap <buffer> <Leader>d/ :s/^\(\s*\)\/\/ /\1/e<CR>


" .vim/after/ftplugin/cpp.vim
" Douglas's additional C++ settings

" Open .cpp, .hpp, .sm files
nnoremap <buffer> <Leader>cpp :edit %:r.cpp<cr>
nnoremap <buffer> <Leader>hpp :edit %:r.hpp<cr>
nnoremap <buffer> <Leader>sm  :edit %:r.sm<cr>

" Line comments
nnoremap <buffer> <Leader>// I// <Esc>
vnoremap <buffer> <Leader>// :s/^/\/\/ /<CR>
nnoremap <buffer> <Leader>d/ :s/^\(\s*\)\/\/ /\1/e<CR>
vnoremap <buffer> <Leader>d/ :s/^\(\s*\)\/\/ /\1/e<CR>

" Block comments
nnoremap <buffer> <Leader>* ^C/*<CR><CR>/<Esc>kA <Esc>p
vnoremap <buffer> <Leader>* s/*<CR>/<Esc>P

" Add a debug message for the variable under the cursor
nnoremap <buffer> <Leader>dm yiwostd::cout << "<Esc>pA = " << <Esc>pA << std::endl;<Esc>


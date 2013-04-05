" Bazaar
" Maintainer: Douglas

" Make all Bazaar commands available on the :Bzr keyword
command! -complete=file -nargs=+ Bzr :!bzr <args>


" Automake filetype "after" file
" Language:	automake
" Maintainer:	Douglas
" Only modifies the standard automake filetype settings

" Not working for some reason
" I had to manually source this file
syntax match configcomment "\(dnl.*\)\|\(#.*\)"
syntax match TAB_CHAR "\t"
highlight link TAB_CHAR Error

" My automake preferences
" Undoing the damage wrought by /usr/share/vim/vim71/ftplugin/make.vim
setlocal expandtab
setlocal softtabstop=3


" Subversion commit tmp-file detection

" svn-commit.tmp, svn-commit.2.tmp
au BufNewFile,BufRead svn-commit*.tmp set filetype=diff


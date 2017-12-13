" Subversion
" Maintainer: Douglas

" Make all subversion commands available on the :Svn keyword
command! -complete=file -nargs=+ Svn :!svn <args>

command! -complete=file -nargs=+ SvnDiff call SubversionDiff(<q-args>)
command! SvnBlame call SubversionBlame()
command! -nargs=1 SvnCat call SubversionCat(<q-args>)

function! SubversionDiff(args)
   let targetFilename = expand("%")
   let tempFilename = expand("%:t")
   exe 'split "/tmp/diff_' . tempFilename . '"'
   " Empty the file of any previous diff contents
   exe "normal ggVGx"
   exe "silent read! svn diff" . a:args
   exe "set syntax=diff"
   exe "normal gg"
endfun

function! SubversionBlame()
   let targetFilename = expand("%")
   exe "setl scrollbind"
   exe "vertical new"
   exe "setl scrollbind"
   exe "vertical resize 18"
   exe "setl buftype=nofile"
   exe "setl bufhidden=hide"
   exe "file " . expand("%:t")
   exe "setl nowrap"
   exe "setl modifiable"
   exe "silent read! svn blame " . targetFilename
   exe "normal ggdd"
   exe "setl nomodifiable"
endfun

function! SubversionCat(url)
   let targetFilename = expand("%")
   exe "new"
   exe "set buftype=nofile"
   exe "set bufhidden=hide"
   exe "file " . a:url
   exe "set modifiable"
   exe "silent read! svn cat " . a:url
   exe "normal ggdd"
endfun


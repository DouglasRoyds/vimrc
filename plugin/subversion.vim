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

function! SubversionTrunkDir(filename)
   let l:trunkdir = ''
   let l:filename = fnamemodify(a:filename, ":p")
   let l:filedir = fnamemodify(l:filename, ":h")

   let l:svndir = finddir('.svn', l:filedir . ';' . $HOME)
   if match(l:svndir, '.svn') != -1

      " Regrettably, I can not use verymagic in a substitute() function, hence the sea of backslashes
      let l:trunkdir = substitute(l:filename,
                                    \ '\(.*/\)\(trunk\|\(branches\|vendor\|tags\)/[^/]\+\)/.*',
                                    \ '\1\2',
                                    \ "")
      if l:trunkdir == l:filename
         " There was no trunk/branches/tags directory, so <Leader>trk will just lcd into the file directory
         let l:trunkdir = l:filedir
      endif
   endif
   return l:trunkdir
endfun

function! SubversionSetBufferMappings(filename)
   if exists("b:svn_buffer_mappings_already_set") || exists("b:git_repo_dir")
      return
   endif
   let b:svn_buffer_mappings_already_set = 1

   let b:svn_trunk_dir = SubversionTrunkDir(a:filename)
   if empty(b:svn_trunk_dir)
      unlet b:svn_trunk_dir
      nnoremap <buffer> <LocalLeader>trk <Nop>
      return
   endif

   " Grep out the externals messages, as I find them annoying
   " If Grep finds no matches (or even no input), it returns 1, which Vim reports
   " Map an exit code == 1 to success, all other exit codes to failure
   nnoremap <buffer> <Leader>vs :!svn status <Bar> egrep -v '^X\|external\|^$' <Bar><Bar> [ $? -eq 1 ] <cr>
   nnoremap <buffer> <Leader>vdd :!svn diff -x-wu % \| colordiff<cr>
   nnoremap <buffer> <Leader>vda :!svn diff -x-wu --no-diff-deleted \| colordiff \| less -r<cr>

   " lcd applies to the *window*, not to the buffer
   nnoremap <buffer> <LocalLeader>trk :exe "lcd" fnameescape(b:svn_trunk_dir) <bar> pwd <cr>

endfun

augroup subversion
   autocmd!
   autocmd BufWinEnter * call SubversionSetBufferMappings(expand("%"))
augroup END


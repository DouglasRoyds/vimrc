" local.home.vim
" *Hard link* me as ~/.local.vim
" Can't use a symlink, as it fools g:localvimrc_script and friends

" ------------------------------------ Every BufWinEnter --------------------------------------------

" ------------------------------------ Once per edited file -----------------------------------------

if g:localvimrc_sourced_once_for_file
   finish
endif

" Give git the priority: If we've found a .git dir, don't look for svn
let b:gitdir = finddir('.git', g:localvimrc_file . ';' . g:localvimrc_script_dir)
if match(b:gitdir, '.git') != -1

   " Remove the trailing /.git and fully-qualify
   let b:gitdir = fnamemodify(b:gitdir, ':h')
   if match(b:gitdir, '/') != 0
      let b:gitdir = getcwd() . '/' . b:gitdir
   endif
   nnoremap <buffer> <LocalLeader>git :execute 'lcd' fnameescape(b:gitdir) <bar> pwd <cr>

   "" In a git checkout
   nnoremap <buffer> <Leader>vs :Git status <cr>
   nnoremap <buffer> <Leader>vss :Gstatus <cr>
   nnoremap <buffer> <Leader>vdd :Git diff % <cr>
   nnoremap <buffer> <Leader>vda :Git diff -D -M <cr>

   " Set colour white and clear the screen
   " While git-gutter is triping up the console output
   nnoremap <buffer> <Leader>tput :!tput sgr0 && tput clear <cr>

   nnoremap <buffer> <LocalLeader>trk <Nop>
   finish
endif

" Svn
let b:svndir = finddir('.svn', g:localvimrc_file_dir . ';' . g:localvimrc_script_dir)
if match(b:svndir, '.svn') != -1

   " Grep out the externals messages, as I find them annoying
   " If Grep finds no matches (or even no input), it returns 1, which Vim reports
   " Map an exit code == 1 to success, all other exit codes to failure
   nnoremap <buffer> <Leader>vs :!svn status <Bar> egrep -v '^X\|external\|^$' <Bar><Bar> [ $? -eq 1 ] <cr>
   nnoremap <buffer> <Leader>vdd :!svn diff -x-wu % \| colordiff<cr>
   nnoremap <buffer> <Leader>vda :!svn diff -x-wu --no-diff-deleted \| colordiff \| less -r<cr>

   " Regrettably, I can not use verymagic in a substitute() function, hence the sea of backslashes
   let b:trunkdir = substitute(g:localvimrc_file,
                                 \ '\(.*/\)\(trunk\|\(branches\|vendor\|tags\)/[^/]\+\)/.*',
                                 \ '\1\2',
                                 \ "")
   if b:trunkdir == g:localvimrc_file
      " There was no trunk/branches/tags directory, so <Leader>trk will just lcd into the file directory
      let b:trunkdir = g:localvimrc_file_dir
   endif
   " lcd applies to the *window*, not to the buffer
   nnoremap <buffer> <LocalLeader>trk :execute 'lcd' fnameescape(b:trunkdir) <bar> pwd <cr>

   nnoremap <buffer> <LocalLeader>git <Nop>
   nnoremap <buffer> <Leader>tput <Nop>

endif

" ------------------------------------ Once per vim instance ----------------------------------------

"if g:localvimrc_sourced_once
"   finish
"endif


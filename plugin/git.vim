" Git
" Maintainer: Douglas

function! GitRepoDir(filename)
   let l:gitdir = ''
   let l:filename = fnamemodify(a:filename, ":p")
   let l:filedir = fnamemodify(l:filename, ":h")

   let l:gitdir = finddir('.git', l:filedir . ';' . $HOME)
   if match(l:gitdir, '.git') != -1
      let l:gitdir = fnamemodify(l:gitdir, ':p:h:h')
   endif
   return l:gitdir
endfun

function! GitSetBufferMappings(filename)
   if exists("b:git_buffer_mappings_already_set")
      return
   endif
   let b:git_buffer_mappings_already_set = 1

   let b:git_repo_dir = GitRepoDir(a:filename)
   if empty(b:git_repo_dir)
      unlet b:git_repo_dir

      " I frequently type these ones brainlessly, so make them no-ops
      nnoremap <buffer> <LocalLeader>git <Nop>
      nnoremap <buffer> <Leader>tput <Nop>
      return
   endif

   nnoremap <buffer> <LocalLeader>git :execute 'lcd' fnameescape(b:git_repo_dir) <bar> pwd <cr>
   nnoremap <buffer> <LocalLeader>vs  :Git status <cr>
   nnoremap <buffer> <LocalLeader>vss :Gstatus <cr>
   nnoremap <buffer> <LocalLeader>vdd :Git diff % <cr>
   nnoremap <buffer> <LocalLeader>vda :Git diff -D -M <cr>
   nnoremap <buffer> <LocalLeader>vlo :Git log --oneline --graph --decorate --all <cr>

   " Set colour white and clear the screen
   " Just while git-gutter is still tripping up the console output
   nnoremap <buffer> <LocalLeader>tput :!tput sgr0 && tput clear <cr>

endfun

augroup git
   autocmd!
   autocmd BufWinEnter * call GitSetBufferMappings(expand("%"))
augroup END


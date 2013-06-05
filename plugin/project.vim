" project.vim
" Douglas's .project.vim approach to managing projects
" Searches upwards through the directory tree to find a .project.vim file.
" Sources it if it's there, as it contains settings specific to this project.
" Not protected with a g:loaded_scriptname variable, as I want to be able to edit and re-source it.

function! s:source_project_vim_file()
   try
      execute "source " . findfile(".project.vim", ".;")
   catch
      " Silently do nothing
   endtry
endfunction

augroup project_vim
   autocmd!
   autocmd BufNewFile,BufRead * call s:source_project_vim_file()
augroup end


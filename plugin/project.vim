" project.vim
" Douglas's .project.vim approach to managing projects
" Searches upwards through the directory tree to find a .project.vim file.
" Sources it if it's there, as it contains settings specific to this project.
" The .project.vim file can optionally let b:project_file_find_next = 1 to continue the search upwards.

function! s:source_project_vim_file()
   let s:search_dir = expand('%:p:h')
   let b:project_file_find_next = 1
   while b:project_file_find_next
      " Default behaviour is not to continue searching upwards after sourcing .project.vim
      let b:project_file_find_next = 0
      let s:project_file = findfile(".project.vim", s:search_dir . ';')
      try
         " In a try clause, as this plugin was failing in the presence of vim-fugitive
         execute "source " . s:project_file
      catch
         break
      endtry

      " We did find a project file.
      " Now we want to search again, starting at the next directory up.
      " This project file's directory could be:
      "     /
      "     (blank), ie. the project file was found in the cwd
      "     relative/ to the cwd
      "     /fully/qualified/
      " In all cases, we fully-qualify the s:project_file_dir
      let s:project_file_dir = substitute(s:project_file, ".project.vim", "", "")
      if s:project_file_dir == '/'
         " All done
         break
      endif
      if s:project_file_dir !~ '^/'
         let s:project_file_dir = getcwd() . '/' . s:project_file_dir
      endif
      let s:search_dir = substitute(s:project_file_dir, '/[^/]\+/$', '/', '')
   endwhile
endfunction

augroup project_vim
   autocmd!
   autocmd BufNewFile,BufRead * call s:source_project_vim_file()
augroup end


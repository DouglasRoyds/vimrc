" Vim compiler file
" Douglas's "after" file
" TODO:  Make this file work!!!
" Compiler:     ATT dot
" Maintainer:	Douglas

" Don't check current_compiler to override settings from a default plugin
" See :help CompilerSet
let current_compiler = "dot"

if exists(":CompilerSet") != 2
   command -nargs=* CompilerSet setlocal <args>
endif

CompilerSet makeprg=dot\ -Tpdf\ \"%:p\"\ -o\ \"%:p:r.pdf\"

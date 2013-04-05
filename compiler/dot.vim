" Vim compiler file
" Compiler:	Graphviz Dot
" Maintainer:	Douglas

if exists("current_compiler")
  finish
endif
let current_compiler = "dot"

if exists(":CompilerSet") != 2		" older Vim always used :setlocal
  command -nargs=* CompilerSet setlocal <args>
endif

" dot
CompilerSet makeprg=dot\ png\ o\ "%:p:r.png"\ "%"

" sample warning: foo.html:8:1: Warning: inserting missing 'foobar' element
" sample error:   foo.html:9:2: Error: <foobar> is not recognized!
"CompilerSet errorformat=%f:%l:%c:\ Error:%m,%f:%l:%c:\ Warning:%m,%-G%.%#

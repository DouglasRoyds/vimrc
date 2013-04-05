" Vim compiler file
" Compiler:	HTML Tidy
" Maintainer:	Doug Kearns <djkea2@gus.gscit.monash.edu.au>
"              This version has been modified by Douglas
" URL:		http://gus.gscit.monash.edu.au/~djkea2/vim/compiler/tidy.vim

if exists("current_compiler")
  finish
endif
let current_compiler = "tidy"

if exists(":CompilerSet") != 2		" older Vim always used :setlocal
  command -nargs=* CompilerSet setlocal <args>
endif

" tidy
"     -quiet            Supresses the sermon
"     --gnu-emacs yes   A more easily parsed error/warning format
"     -modify           Modify the file in-place. I want to enforce the formatting, and will modify my own default tidy
"                       config file if necessary
CompilerSet makeprg=tidy\ -quiet\ --gnu-emacs\ yes\ -modify\ -utf8\ '%'

" sample warning: foo.html:8:1: Warning: inserting missing 'foobar' element
" sample error:   foo.html:9:2: Error: <foobar> is not recognized!
CompilerSet errorformat=%f:%l:%c:\ Error:%m,%f:%l:%c:\ Warning:%m,%-G%.%#

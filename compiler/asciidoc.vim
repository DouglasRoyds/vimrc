" Vim compiler file
" Compiler:	AsciiDoc
" Maintainer:	Douglas Royds

if exists("current_compiler")
  finish
endif
let current_compiler = "asciidoc"

if exists(":CompilerSet") != 2		" older Vim always used :setlocal
  command -nargs=* CompilerSet setlocal <args>
endif

" a2x
"     Using a2x to generate xhtml, as it does a more complete job than the default asciidoc command
"        -f          Output format xhtml
"        --icons     Use admonition and navigation icon images in output documents.
"                    These must already be in ./images/icons
" TODO:  Add the --copy option, so that icons and stylesheets are copied over automatically.
"        From where?
CompilerSet makeprg=a2x\ --verbose\ -f\ xhtml\ --icons\ --icons-dir=./images/icons\ '%'

" TODO:  Set up the errorformat:
"        asciidoc: WARNING: Software_Configuration_Management.txt: line 443: list item index: expected 2 got 3
"        asciidoc: ERROR: Tait_component_build_and_debug.txt: line 151: empty section is not valid
"        Software_Configuration_Management.xml:2251: element xref: validity error : IDREF attribute linkend references an unknown ID "_Variants"
CompilerSet errorformat=%p:\ WARNING:\ %f:\ line\ %l:\ %m
CompilerSet errorformat+=%f:%l:\ %m

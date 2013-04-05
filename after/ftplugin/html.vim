" Vim filetype "after" file
" Language:	HTML
" Maintainer:	Douglas
" Only modifies the standard HTML filetype settings

compiler tidy

" Set equalprg for HTML
" See http://vim.wikia.com/wiki/Cleanup_your_HTML
"     exe '...'.&errorfile       We need to include the name of the errorfile in the command,
"                                so we need Vim to do the string concatenation for us.
"                                This step wasn't necessary for the makeprg (see compiler/tidy.vim),
"                                as Vim :make handles capturing of the compiler output automatically
"     setlocal                   Only for this buffer
"     tidy                       HTML tidy
"        -quiet                  No sermons, thanks
"        --show-body-only true   Print an HTML fragment - tidy won't expect head and body tags
"        -file                   Write errors and warnings to the specified file
exe 'setlocal equalprg=tidy\ -quiet\ --show-body-only\ true\ -file\ '.&errorfile

command! Highlight normal Ospan.highlight {background-color: yellow;}

" Make the visual block a <span class="highlight">
vmap <Leader>hl xi<span class="highlight"><Esc>gpi</span><Esc>

" Descript - Delete one Java script block
nmap <Leader>ds /<script<CR>v/<\/script>/e<CR>x

" Go to the corresponding .txt file, normally an AsciiDoc source
nmap <Leader>txt :edit %:r.txt<cr>

" Make tab characters visible as an Error
syntax match TAB_CHAR "\t"
highlight link TAB_CHAR Error

" My HTML preferences
set textwidth=120

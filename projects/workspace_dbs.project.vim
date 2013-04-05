" ~/workspace/dbs/.project.vim

nmap <Leader>db :cd ~/workspace/dbs/ <bar> pwd<cr>
nmap <Leader>to :cd ~/workspace/dbs/tait.openembedded/trunk/ <bar> pwd<cr>
nmap <Leader>oe :cd ~/workspace/dbs/org.openembedded.dev/branches/2010-02-23/ <bar> pwd<cr>

" Change to the root directory of a local working copy, eg. the trunk/ directory
" Find trunk/, branches/branchname, vendor/branchname, or tags/tagname, and trim off any trailing elements of the path.
" Regrettably, I can not use verymagic in a substitute() function, hence the sea of backslashes
let b:trunkdir = substitute(expand("%:p"),
                              \ '\(.*/\)\(trunk\|\(branches\|vendor\|tags\)/[^/]\+\)/.*',
                              \ '\1\2',
                              \ "")
nmap <buffer> <LocalLeader>tr :execute 'cd' fnameescape(b:trunkdir) <bar> pwd <cr>


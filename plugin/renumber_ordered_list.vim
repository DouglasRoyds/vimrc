" Corrects the numbering of a list, numbering from the value in the first line of the range
" Maintainer: Douglas Royds
" Last Change: 20 October 2008

" Numbers must be left-aligned
" Tolerates leading characters (eg. comment marks)
" The starting value is the first number found in the first line of the selected range
" A test example:
"     3. This is a numbered item
"     1. Another item that
"        wraps onto a second line
"     12. This item has a number
"        embedded within line number 2, which is not adjusted.
"        It also starts a line with a number, which is not adjusted:
"        3.
"     5. A numbered item doesn't have to have any trailing text:
"     4.
function! <SID>Renumber_Ordered_List() range
   let s:number_item = '[0-9]\+\.'
   if search(s:number_item, 'c', a:firstline) > 0
      let s:counter = expand("<cword>")
      let s:prefix = substitute(getline("."), s:number_item.'.*$', "", "")
      execute a:firstline . "," . a:lastline .
         \ 'g/'.s:prefix.s:number_item.'/' .
         \ 's/[0-9]\+/\=s:counter/' .
         \ '| let s:counter+=1'
   else
      throw "No numbered item found in the first line"
   endif
endfunction

" Renumber a visually-selected ordered list
vnoremap <Leader>rl :call <SID>Renumber_Ordered_List()<CR>



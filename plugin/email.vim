" Send the current file as an email
" Maintainer: Douglas Royds

" Skip the rest if it was already done.
"if exists("*s:Send_Email_From_Vim")
"   finish
"endif

function! <SID>Send_Email_From_Vim()
  " Remove any previous match.
   let subject=input("Subject: ")
   let address=input("Address: ")
   execute "!( echo To: " address ";"
            \ "echo From: qbhtynf.eblqf@gnvg.pb.am | tr a-zA-Z n-za-mN-ZA-M;"
            \ "echo Subject: " subject ";"
            \ "cat '%') | sendmail -t"
endfunction

command! Sendmail :call <SID>Send_Email_From_Vim()


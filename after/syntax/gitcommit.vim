" This line needs to match the corresponding line in /usr/share/vim/vim*/syntax/gitcommit.vim
syn match   gitcommitSummary	"^.*\%<91v." contained containedin=gitcommitFirstLine nextgroup=gitcommitOverflow contains=@Spell


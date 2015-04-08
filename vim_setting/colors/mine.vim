" First remove all existing highlighting.
" 0=black 1=red3 2=green3 3=yellow3 4=blue 5=magenta3 6=cyan3 7=gray90
" 8=gray10 9=red 10=green 11=yellow 12=blue 13=magenta 14=cyan 15=white

set background=light
hi clear
if exists("syntax_on")
	syntax reset
endif

let colors_name = "mine"

" hi Normal ctermbg=15 ctermfg=0

hi SpecialKey term=bold ctermfg=4 guifg=Blue
hi NonText term=bold cterm=bold ctermfg=4 gui=bold guifg=Blue
hi Directory term=bold ctermfg=4 guifg=Blue
hi ErrorMsg term=standout cterm=bold ctermfg=7 ctermbg=1 gui=bold guifg=White guibg=Red
hi IncSearch term=reverse ctermfg=4 ctermbg=7
hi Search term=reverse  ctermfg=4 ctermbg=7
hi MoreMsg term=bold ctermfg=2 gui=bold guifg=SeaGreen
hi ModeMsg term=bold cterm=bold gui=bold
"hi LineNr term=underline ctermfg=4 guifg=Red3
hi Question term=standout ctermfg=2 gui=bold guifg=SeaGreen
hi StatusLine term=bold,reverse cterm=bold ctermfg=7 ctermbg=4 gui=bold guifg=White guibg=Black
hi StatusLineNC term=reverse cterm=reverse gui=bold guifg=PeachPuff guibg=Gray45
hi VertSplit term=reverse cterm=bold ctermfg=4 ctermbg=3 gui=bold guifg=White guibg=Gray45
hi Title term=bold ctermfg=5 gui=bold guifg=DeepPink3
hi Visual term=reverse cterm=reverse gui=reverse guifg=Grey80 guibg=fg
hi VisualNOS term=bold,underline cterm=bold,underline gui=bold,underline
hi WarningMsg term=standout ctermfg=1 gui=bold guifg=Red
hi TabLineSel cterm=bold ctermfg=4 ctermbg=3
hi TabLine cterm=reverse
hi WildMenu term=standout cterm=reverse ctermfg=0 ctermbg=7 guifg=Black guibg=Yellow
hi Folded term=standout ctermfg=4 ctermbg=8 guifg=Black guibg=#e3c1a5
hi FoldColumn term=standout ctermfg=4 ctermbg=7 guifg=DarkBlue guibg=Gray80
hi DiffAdd term=bold ctermfg=0 ctermbg=6 guibg=White
hi DiffChange term=bold ctermfg=0 ctermbg=6 guibg=#edb5cd
hi DiffDelete term=bold ctermfg=0 ctermbg=6 gui=bold guifg=LightBlue guibg=#f6e8d0
hi DiffText term=reverse ctermbg=6 gui=bold guibg=#ff8060
hi Cursor ctermbg=black guifg=bg guibg=fg
hi lCursor ctermbg=black guifg=bg guibg=fg
hi MatchParen cterm=bold ctermfg=red ctermbg=white

" Colors for syntax highlighting
hi Comment term=bold ctermfg=4 guifg=#406090
hi Constant term=underline cterm=bold ctermfg=0 guifg=#c00058
hi Special term=bold ctermfg=2 guifg=SlateBlue
hi Identifier ctermfg=6 guifg=DarkCyan
hi Statement term=bold ctermfg=1 gui=bold guifg=Brown
hi PreProc term=underline ctermfg=2 guifg=Magenta3
hi Type term=underline ctermfg=5 gui=bold guifg=SeaGreen
hi Ignore cterm=bold ctermfg=8 guifg=bg
"hi Error term=reverse cterm=reverse ctermfg=black ctermbg=white gui=bold guifg=White guibg=Red
hi Todo term=standout ctermfg=0 ctermbg=white guifg=Blue guibg=Yellow

if version >= 700
	hi SpellBad cterm=underline ctermfg=Red ctermbg=white
	hi SpellCap cterm=underline ctermfg=Red ctermbg=white
	hi SpellLocal cterm=underline ctermfg=Red ctermbg=white
	hi SpellRare cterm=underline ctermfg=Red ctermbg=white
endif

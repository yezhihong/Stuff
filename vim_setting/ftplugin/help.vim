if exists("b:user_did_helpftplugin")
	finish
endif
let b:user_did_helpftplugin = 1

if &ma && !&readonly
	if has("autocmd")
		"autocmd BufRead,BufNewFile *.txt call s:Init()
	endif

	setlocal fo=tq
	setlocal textwidth=80
	setlocal spell spelllang=en_us


	"s:Init(){{{
	function! s:Init()
		let con=match(getline(1),'-notes*')
		if con>=0
			let line=matchstr(getline(1),'[^*].*\(_\|-\)\@=')
			call s:DefineKeyWord(line)
			call s:DefineMargin(5,9)
		else
			call s:DefineKeyWord("NONE")
			call s:DefineMargin(5,9)
		endif
		unlet con line
	endfunction
	"}}}

	"s:DefineKeyWord(kWord){{{
	function! s:DefineKeyWord(kWord)
		let s:thiskWord=a:kWord
	endfunction
	"}}}

	"s:DefineMargin(lm,rm){{{
	function! s:DefineMargin(lm,rm)
		"leftedge=colno of first alphabetic character
		"rightedge=colno of last any character
		let s:leftedge=a:lm+1
		let s:rightedge=&tw-a:rm
	endfunction
	"}}}

	"s:AddTitle(pars){{{
	function! s:AddTitle(...)
		let par_title=a:1
		let par_char=a:2
		if ( a:0!=3 )
			let par_num=-1
		else
			let par_num=a:3
		endif

		let l:lenleft=s:rightedge
		"create l:tnum
		if ( par_num!=-1 )
			let l:len=strlen(par_num)+1
			let l:tnum=par_num."."
		else
			let l:len=1
			let l:tnum=" "
		endif
		"create l:first_sp
		if ( l:len>=(s:leftedge-1) )
			let l:first_sp=MakeChars(1," ")
			let l:lenleft=l:lenleft-l:len-1
		else
			let l:first_sp=MakeChars(s:leftedge-l:len-1," ")
			let l:lenleft=l:lenleft-s:leftedge-1
		endif
		"create l:title
		let l:len=strlen(par_title)
		if ( l:len<1 )
			let l:title="No Title"
			let l:len=8
		else
			let l:title=par_title
		endif
		let l:lenleft=l:lenleft-l:len
		"create l:second_sp and l:lastpart
		let l:len=strlen(par_title)
		"3 means 2 special-chars and 1 "-"
		let l:lenleft=l:lenleft-l:len-3
		let l:len=strlen(s:thiskWord)
		let l:lenleft=l:lenleft-l:len
		let l:second_sp=MakeChars(l:lenleft," ")
		let l:lastpart=par_char.s:thiskWord."-".l:title.par_char
		exe "normal o".l:tnum.l:first_sp.l:title.l:second_sp.l:lastpart."\<ESC>^"
		unlet l:len l:tnum l:first_sp l:title l:second_sp l:lastpart l:lenleft
	endfunction
	"}}}

	if !exists("b:no_user_helpftplugin_maps")
		noremap <buffer> ,/ O<C-R>=MakeChars(&tw-2,"=")<CR><ESC>j$
		noremap <buffer> ,, A ><CR><CR><<UP>
		inoremap <buffer> ,, <ESC>A ><CR><CR><<UP>
	endif
	let b:no_user_helpftplugin_maps=1

	command! -buffer -nargs=? DefineKeyWord call s:DefineKeyWord(<f-args>)
	command! -buffer -nargs=+ DefineMargin call s:DefineMargin(<f-args>)
	command! -buffer -nargs=? Addstar normal i*<args>*<ESC>
	command! -buffer -nargs=? Addbar normal i|<args>|<ESC>
	command! -buffer -nargs=* AddTitle call s:Init() |call s:AddTitle(<f-args>)

endif

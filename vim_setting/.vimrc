"Tip 2,67,91,129,823
" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
" let &guioptions = substitute(&guioptions, "t", "", "g")

" Don't use Ex mode, use Q for formatting
map Q gq

source $DEF_VIM/.vim/plugin/vimspell.vim
let spell_insert_mode=0 "This avoids space doesn't work in insert mode

"vim-latexsuite{{{
if version >= 700
	let g:tex_flavor='latex'
endif
"This map has to be in .vimrc, see help latex-suite.txt
map <C-h> <Plug>IMAP_JumpForward 
"}}}

"General Setting{{{
"if version >= 600
if version >= 100
	" set nocompatible
	set nocp
	"set vb t_vb=
	set history=50
	set title
	set ignorecase
	set smartcase
	set ruler
	set showcmd
	set incsearch
	set backspace=indent,eol,start
	set listchars=tab:>-,trail:.
	set shellslash "This is for win32 users
" grep will sometimes skip displaying the file name if you
" search in a singe file. This will confuse Latex-Suite. Set your grep
" program to always generate a file-name.
	set grepprg=grep\ -nH\ $*
	set wildmenu
	set wildmode=longest:full
	set sessionoptions+=unix,slash " UNIX and MS-WINDOWS
	set path+=./../include,./include " mainly for C and C++
	set showmatch
	set matchtime=1
	set infercase "usr_24 24.3
	set nrformats-=octal " usr_26 26.2
	set laststatus=2
	set mouse=a
	set nostartofline
	"set viminfo=!,'25,\"100,:20,%,n~/.viminfo
	"next two lines will enable vim to show chinese
	let &termencoding=&encoding
	set fileencodings=utf-8,gbk
	set dictionary+=/usr/share/dict/words
	if &t_Co > 2 || has("gui_running")
		syntax enable
		let g:load_doxygen_syntax=1
		set hlsearch
	endif
	" Set this, if you will open all windows for files specified
	" on the commandline at vim startup.
	if !exists("g:open_all_win")
		let g:open_all_win=1
	endif

	set foldenable
	set foldmethod=marker
	set foldtext=MyFoldText()
	colorscheme mine
	" keymap mkview loadview
	set nobackup
	set termencoding=utf-8 "support Chinese display
	set writebackup  "See usr_07.txt Notes
	" Only do this part when compiled with support for autocommands.
	if has("autocmd")

		" Enable file type detection.
		" Use the default filetype settings, so that mail gets 'tw' set to 72,
		" 'cindent' is on in C files, etc.
		" Also load indent files, to automatically do language-dependent indenting.
		filetype plugin indent on
		set shiftwidth=4
		set softtabstop=4
		set tabstop=4

		" Put these in an autocmd group, so that we can delete them easily.
		augroup RestorePosition
			au!
			" For all text files set 'textwidth' to 80 characters.
			autocmd FileType text setlocal textwidth=80

			" When editing a file, always jump to the last known cursor position.
			" Don't do it when the position is invalid or when inside an event handler
			" (happens when dropping a file on gvim).
			au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
						\| exe "normal! g'\"" | endif
			"	    autocmd BufReadPost *
			"			\ if &ft!="help" && &modifiable==1 |
			"			\   normal ,dggVG=,z=zM |
			"			\   :echo "" |
			"			\ endif
			"	    autocmd BufWritePost * normal ,dggVG=,z=zM
			autocmd BufWinEnter * norm! zv
		augroup END
	else
		set autoindent		" always set autoindenting on
	endif " has("autocmd")

endif

"}}}

"Keyboard Mapping{{{
	"Window Mapping{{{
	map <C-j> <C-w>w
	map <F3> :new<CR>
	map <S-F3> :vnew<CR>
	map <C-=> <C-w>=
	map <C-l> <C-w>L
	"maximum window
	map <F9> <C-w>_
	"}}}
	"Tab Mapping{{{
	if version >= 700
		map <F5> :tabnew<CR>
		map <C-k> gt
	endif
	"}}}
	"Others Mapping{{{
	"for coding
	imap {<SPACE>} <C-r>=BracketsCompletion("{","}")<CR>
	"imap [] <C-r>=BracketsCompletion("[","]")<CR>
	"imap () <C-r>=BracketsCompletion("(",")")<CR>
	"imap <> <C-r>=BracketsCompletion("<",">")<CR>
	"imap '' <C-r>=BracketsCompletion("'","'")<CR>
	""Be careful next map: '"',not """
	"imap "" <C-r>=BracketsCompletion('"','"')<CR>
	imap /*/ <C-r>=BracketsCompletion("/*","*/")<CR>
	"Command+F=?(MAC)
	imap {f} <C-r>=BracketsCompletion("function","endfunction")<CR>

	map ,w :call <SID>BrowserURL()<CR>
	"vmap {} <ESC>:call BracketsCompletion("{","}")<CR>
	"vmap \[] <ESC>:call BracketsCompletion("[","]")<CR>
	"vmap () <ESC>:call BracketsCompletion("(",")")<CR>
	"vmap <> <ESC>:call BracketsCompletion("<",">")<CR>
	"vmap '' <ESC>:call BracketsCompletion("'","'")<CR>
	"vmap "" <ESC>:call BracketsCompletion('"','"')<CR>
	vmap /*/ <ESC>:call BracketsCompletion("/*","*/")<CR>
	"for multi-line/word copy/paste
	map \y "Jy
	map \d "Jd
	map \p "Jp
	map \P "JP
	map \c qjq

	"Edit file in same directory See Tip2
	map ,d :%s/\s*$//<CR><F1>
	map ,e :e <C-R>=expand("%:p:h") . "/" <CR>
	map ,h :h <C-r><C-w><CR>

	"map ,= :call <SID>SaveView()<CR>ggVG=:g/^/:call <SID>AlignFold()<CR><F1>zM:call <SID>RestoreView()<CR>:echo ""<CR>
	map ,= maHmbggVG=zR:g/{\{3}/call AlignFold()<CR><F1>zM,d'b'azv
	map ,zm maHmb:call <SID>AddFoldMarkLevel()<CR><F1>'bzo'a
	map ,zd maHmb:call <SID>DelFoldMarkLevel()<CR><F1>'bzo'a

	map <DOWN> gj
	map <UP> gk
	map <F1> :let &hlsearch=!&hlsearch<CR>:echo "hlsearch Changed"<CR>
	map <SPACE> :call <SID>ToggleFold()<CR>
	vmap / y/<C-R>"<CR>

	"Spell Map
	map <F4> <Leader>ss
	map <F4>q <Leader>sq
	map <F7> <Leader>sn
	map <F8> <Leader>s?
	if version >= 700
		map <F4> :let &spell=!&spell<CR>:echo "spell Changed."<CR>
		map <F7> ]s
		map <F8> z=
	endif
	"}}}
"}}}

"New Command{{{
" Fold + insert title
command! -nargs=? -range CreateFolder <line1>,<line2>fo |foldopen |normal f{i<args><ESC>zc
command! -nargs=0 OpenAllWin call OpenAllWin()
"}}}

"Functions{{{
	"AllBuffers(cmnd){{{
	"See tips70
	function <SID>AllBuffers(cmnd)
		let cmnd = a:cmnd
		let i=1
		while (i <= bufnr("$"))
			if bufexists(i)
				execute "buffer" i
				execute cmnd
			endif
			let i = i+1
		endwhile
	endfunction
	"}}}
	"ToggleFold{{{
	function <SID>ToggleFold()
		let fl=foldlevel(".")
		let fc=foldclosed(".")
		if ( fl > 0 )
			if ( fc < 0 )
				foldclose
			else
				foldopen
			endif
		endif
		unlet fl
		unlet fc
		echo
	endfunction
	"}}}
	"MakeChars(count,char){{{
	function MakeChars(count,char)
		let i = 0
		let l:chars=""
		while i < a:count
			let l:chars = l:chars . a:char
			let i = i + 1
		endwhile
		return l:chars
	endfunctio
	"}}}
	"MakeSpaces(count){{{
	function <SID>MakeSpaces(count)
		return MakeChars(a:count," ")
	endfunction
	"}}}
	"MakeDashes(count){{{
	function <SID>MakeDashes(count)
		return MakeChars(a:count,"-")
	endfunction
	"}}}
	"AlignFold{{{
	function AlignFold()
		let l:fl=foldlevel(".")
		if ( l:fl>1 )
			"lfs=last foldstart lfl=last foldlevel
			let l:i=line(".")
			"			let l:lfl=l:fl
			"			while l:lfl!=(l:fl-1)
			"				let l:lfs=-1
			"				while  l:lfs<0
			"					let l:i=l:i-1
			"					let l:lfs=match(getline(l:i),'{\{3,}')
			"				endwhile
			"				let l:lfl=foldlevel(l:i)
			"			endwhile
			let l:i=<SID>FindFoldStartorEnd(l:i,-1,"start")
			if indent(l:i) == indent(".")
				let l:i=line(".")
				"let l:fl=foldlevel(".")+1
				"while l:fl>foldlevel(".")
				"	let l:fs=-1
				"	while l:fs<0
				"		let l:i=l:i+1
				"		let l:fs=match(getline(l:i),'}\{3,}')
				"	endwhile
				"	let l:fl=foldlevel(l:i)
				"endwhile
				let l:i=<SID>FindFoldStartorEnd(l:i,0,"end")
				exe "normal ".line(".")."GV".l:i."G>>"
			endif
		endif
	endfunction
	"}}}
	"<SID>FindFoldStartorEnd(line,level,startend){{{
	function <SID>FindFoldStartorEnd(line,level,startend)
		"ex: foldlevel(line)=3
		"level=-1, try to find level 2 foldstart lineNo
		"startend=start or end, just string
		let l:fl=foldlevel(a:line)
		if ( l:fl>0 && (l:fl+a:level)>0 )
			let l:i=a:line
			if ( a:level>0 )
				let l:dir=1
			elseif ( a:level<0 )
				let l:dir=-1
			else
				if a:startend=~"end"
					let l:dir=1
				else
					let l:dir=-1
				endif
			endif
			let l:lfl=l:fl+a:level+1
			while l:lfl!=(l:fl+a:level)
				let l:lfs=-1
				while  l:lfs<0
					let l:i=l:i+l:dir
					if a:startend=~"end"
						let l:lfs=match(getline(l:i),'}\{3,}')
					else
						let l:lfs=match(getline(l:i),'{\{3,}')
					endif
				endwhile
				let l:lfl=foldlevel(l:i)
			endwhile
			return l:i
		else
			return -1
		endif
	endfunction
	"}}}
	"AddFoldMarkLevel{{{
	function <SID>AddFoldMarkLevel()
		:%s/\({{\s*$\&..\)\|\({{\s*\*\/\s*$\&..\)/\="{{".foldlevel(".")/
	endfunction
	"}}}
	"DelFoldMarkLevel{{{
	function <SID>DelFoldMarkLevel()
		:%s/\({\d*\s*$\&.*\d\=\)\|\({\d*\*\/\s*$\&.*\d\)/{/
	endfunction
	"}}}
	"MyFoldText{{{
	" "." in user41.5 , Line 492 Do not add space between var and "."
	function MyFoldText()
		let l:i=nextnonblank(v:foldstart)
		if ( l:i < v:foldend )
			let l:ind=indent(l:i)
		else
			let l:i=prevnonblank(v:foldstart)
			if ( l:i > 1 )
				let l:ind=indent(l:i)
			else
				let l:ind=0
			endif
		endif
		let l:MySpaces=<SID>MakeSpaces(l:ind)
		let l:line = getline(v:foldstart)
		let l:sub=matchstr(l:line,'[a-zA-Z~<][^{]*')
		if ( l:sub=="" )
			let l:sub="No Title"
		endif
		let l:sub=l:MySpaces.l:sub." ".v:folddashes." (".((v:foldend+1)-v:foldstart)
		if ((v:foldend + 1)- v:foldstart) == 1
			let l:sub = l:sub . " line)"
		else
			let l:sub = l:sub . " lines)"
		endif
		return l:sub
	endfunction
	"}}}
	"BracketsCompletion(bra,ket){{{
	function BracketsCompletion(bra,ket) range
		if mode()=="i"
			let l:str=strpart(getline("."),0,col(".")-1)
			let l:con=match(l:str,'^\s*$')
			if l:con==-1
				return a:bra.a:ket."\<LEFT>"
			else
				return a:bra."\<CR>\<ESC>A\<CR>".a:ket."\<UP>\<ESC>\^i"
			endif
			unlet l:str
			unlet l:con
		else
			let l:line1=line("'<")
			let l:line2=line("'>")+2
			exe "normal ".l:line1."G^"
			exe "normal O\<CR>".a:bra."\<ESC>"
			exe "normal ".l:line2."G^"
			exe "normal o\<CR>\<UP>".a:ket."\<ESC>"
			unlet l:line1
			unlet l:line2
		endif
	endfunction
	"}}}
	"BrowserURL{{{
	function <SID>BrowserURL()
		let l:line=getline(".")
		let l:line=matchstr(l:line,"http[^ ]*")
		if l:line!=""
			call <SID>OpenBrowser(l:line)
		else
			echoerr "NO URL IN THE LINE"
		endif
		unlet l:line
	endfunction
	"}}}
	"OpenBrowser(url){{{
	function <SID>OpenBrowser(url)
		if ( $OS =~ "darwin" )
			exe "silent !open -a firefox ".a:url." &"
		elseif ( $OS =~ "linux" )
			exe "silent !firefox ".a:url." &"

			"	    exe "silent !firefox -remote \"openURL(".a:url.",new-tab)\" &"
		endif
	endfunction
	"}}}
	""<SID>SaveView(){{{
	"function <SID>SaveView()
	"	let g:sid_view=winsaveview()
	"	let g:sid_oldfostatuslist=[]
	"	g/^\s*["/# ].*{\{3,}.*$/:call add(g:sid_oldfostatuslist,foldclosed("."))
	"	let g:sid_savefe=&foldenable
	"	let &foldenable=1
	"endfunction
	""}}}
	""<SID>RestoreView(){{{
	"function <SID>RestoreView()
	"	let g:sid_foldstart=[]
	"	let g:sid_newfostatuslist=[]
	"	g/^\s*["/# ].*{\{3,}.*$/:call add(g:sid_foldstart,line("."))
	"	g/^\s*["/# ].*{\{3,}.*$/:call add(g:sid_newfostatuslist,foldclosed("."))
	"	call <SID>RestoreFoldView()
	"	call winrestview(g:sid_view)
	"	let &foldenable=g:sid_savefe
	"	unlet g:sid_view
	"	unlet g:sid_savefe
	"	unlet g:sid_foldstart
	"	unlet g:sid_oldfostatuslist
	"	unlet g:sid_newfostatuslist
	"endfunction
	""}}}
	""<SID>RestoreFoldView(){{{
	"function <SID>RestoreFoldView()
	"	let l:i=0
	"	while ( l:i < len(g:sid_oldfostatuslist) )
	"		exe "normal ".g:sid_foldstart[l:i]."G"
	"		if ( g:sid_oldfostatuslist[l:i]!=g:sid_newfostatuslist[l:i] )
	"			if ( g:sid_oldfostatuslist[l:i]>0 && g:sid_newfostatuslist[l:i]<0 )
	"				foldclose
	"			elseif ( g:sid_oldfostatuslist[l:i]<0 && g:sid_newfostatuslist[l:i]>0 )
	"				foldopen
	"			endif
	"		endif
	"		let l:i=l:i+1
	"	endwhile
	"	unlet l:i
	"endfunction
	""}}}
	" Function OpenAllWin() {{{
	" Opens windows for all files in the command line.
	" Variable "opened" is used for testing, if window for file was already opene|| d
	" or not. This is prevention for repeat window opening after ViM config file
	" reload.
	"
	function! OpenAllWin()
		" save Vim option to variable
		let s:save_split = &splitbelow
		set splitbelow

		let s:i = 1
		if g:open_all_win == 1
			while s:i < argc()
				if bufwinnr(argv(s:i)) == -1    " buffer doesn't exis|| ts or doesn't have window
					exec ":split " . argv(s:i)
				endif
				let s:i = s:i + 1
			endwhile
		endif

		" restore Vim option from variable
		if s:save_split
			set splitbelow
		else
			set nosplitbelow
		endif
	endfunction
	" OpenAllWin() }}}
	if exists("g:open_all_win") " {{{
		if g:open_all_win == 1
			" Open all windows only if we are not running (g)vimdiff
			if match(v:progname, "diff") < 0
				call OpenAllWin()
			endif
		endif
		" turn g:open_all_win off after opening all windows
		" it prevents reopen windows after 2nd sourcing .vimrc
		let g:open_all_win = 0
	endif " }}}
"}}}

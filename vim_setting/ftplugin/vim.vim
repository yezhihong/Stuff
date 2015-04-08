if exists("b:user_did_vimftplugin")
    finish
endif
let b:user_did_vimftplugin = 1

setlocal fo=tq

if !exists("b:no_user_vimftplugin_maps")
    noremap <buffer> ,c :call <SID>MakeFolder("function","endfunction")<CR>
    noremap <buffer> <LocalLeader>ff :exe "normal ".<SID>FindMatchLineNo("function","endfunction")."G^"<CR>
    noremap <buffer>  <LocalLeader>fi :exe "normal ".<SID>FindMatchLineNo("if","endif")."G^"<CR>
    vnoremap <buffer> ,ci :CreateFolder Include<CR>
    noremap <buffer> ,/ I"<ESC>^
    noremap <buffer> ,\ ^x
endif
let b:no_user_vimftplugin_maps=1

"s:MakeFolder(kWa,kWb){{{
function! s:MakeFolder(kWa,kWb)
    let l:line=getline(".")
    let l:a=line(".")
    let l:b=<SID>FindMatchLineNo(a:kWa,a:kWb)
    if ( l:b!=l:a )
	if ( l:a<l:b )
	    let l:line=matchstr(getline(l:a),'\(function!\=\s\+\)\@<=\(.*$\)')
	    exe "normal ".l:a."GO\<ESC>"
	    let l:b=l:b+1
	    exe "normal ".l:b."Go\<ESC>"
	    let l:b=l:b+1
	    exe "normal ".l:a."GV".l:b."G"
	else
	    let l:line=matchstr(getline(l:b),'\(function!\=\s\+\)\@<=\(.*$\)')
	    exe "normal ".l:a."Go\<ESC>"
	    let l:a=l:a+1
	    exe "normal ".l:b."GO\<ESC>"
	    let l:a=l:a+1
	    exe "normal ".l:a."GV".l:b."G"
	endif
	if ( l:line=="" )
	    let l:line="No Title"
	endif
	exe "normal :CreateFolder ".l:line."\<CR>"
	exe "normal ".l:b."G"
    else
	exe "normal ".l:a."G\<ESC>"
    endif
    unlet l:line l:a l:b
endfunction
"}}}

"s:FindMatchLineNo(kWordS,kWordE){{{
function! s:FindMatchLineNo(kWordS,kWordE)
    "1=pos,-1=neg direciton
    "bWord=begin,f=final
    let l:line=getline(".")
    let l:i=line(".")
    if ( match(l:line,'\(^\s*\)\@<='.a:kWordS)>=0 )
	let l:bWord=a:kWordS
	let l:dir=1
	let l:fWord=a:kWordE
    elseif ( match(l:line,'\(^\s*\)\@<='.a:kWordE)>=0 )
	let l:bWord=a:kWordE
	let l:dir=-1
	let l:fWord=a:kWordS
    else
	let l:dir=0
    endif
    if ( l:dir!=0 )
	let l:reg=1
	while ( l:reg>=1 )
	    let l:i=l:i+l:dir
	    let l:line=getline(l:i)
	    if ( match(l:line,'\(^\s*\)\@<='.l:fWord)>=0 )
		let l:reg=l:reg-1
	    elseif ( match(l:line,'\(^\s*\)\@<='.l:bWord)>=0 )
		let l:reg=l:reg+1
	    endif
	endwhile
	unlet l:dir l:bWord l:fWord
	unlet l:line l:reg
    else
	unlet l:dir
	unlet l:line
    endif
    return l:i
endfunction
"}}}

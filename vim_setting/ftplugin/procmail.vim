if exists("b:user_did_procmailftplugin")
    finish
endif
let b:user_did_procmailftplugin = 1

setlocal fo=tq

if !exists("b:no_user_procmailftplugin_maps")
    noremap <buffer> ,c :silent! call <SID>MakeFolder()<CR>
    vnoremap <buffer> ,ci :CreateFolder Include<CR> 
    noremap <buffer> ,/ I#<ESC>^
    noremap <buffer> ,\ ^x
endif
let b:no_user_procmailftplugin_maps=1

"MakeFolder(){{{
"if !exists("*s:MakeFolder()")
    function! s:MakeFolder()
	let l:line=getline(".")
	if ( l:line=="" )
	    let l:line="No Title"
	endif
	exe "normal O\<ESC>V]]%"
	exe "normal :CreateFolder ".l:line."\<CR>"
	exe "normal zo]]%a\<CR>\<ESC>zc"
	unlet l:line
    endfunction
"endif
"}}}

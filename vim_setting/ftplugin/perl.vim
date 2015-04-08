if exists("b:user_did_perlftplugin")
    finish
endif
let b:user_did_perlftplugin = 1

setlocal fo=tq

if !exists("b:no_user_perlftplugin_maps")
    noremap <buffer> ,c :silent! call <SID>MakeFolder()<CR>
    vnoremap <buffer> ,ci :CreateFolder Include<CR>
    noremap <buffer> ,/ I#<ESC>^
    noremap <buffer> ,\ ^x
endif
let b:no_user_perlftplugin_maps=1

command! -buffer -nargs=+ AddPrint call s:AddPrint(<f-args>)

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

"s:AddPrint(...){{{
function! s:AddPrint(...)
	let par_title=a:1
	let outline="normal o"."print \'".par_title."=\',".par_title.",\"\\n\";"
	let outline=outline."\<ESC>"
	exe outline
	if ( a:0!=1 )
		exe "normal O"."#ifdef DEBUG_".par_title."_array\<ESC>"
		exe "normal jo"."#endif\<ESC>"
		exe "normal ggO"."#define DEBUG_".par_title."_array\<ESC>\<C-o>"
	endif
endfunction
"}}}

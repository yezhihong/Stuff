if exists("b:user_did_cftplugin")
	finish
endif
let b:user_did_cftplugin = 1

setlocal fo=tq

"C_Format(){{{
"    if !exists("*s:C_Format()")
function! s:C_Format()
	"make }else become }         not including comment line
	"			else
	%s/^\s*}\s*\(else\)\@=/}\r/ge
	"make blabla{ become blabla	    not including comment line
	"			    {
	%s/\(^[^/]*\a.*\)\@<={/\r{/ge
	"must clean trail space, otherwise in CreateFolder command will behave wired
	"like this, --'CreateFolder void www() '-->/*void www( ){...
	normal ,d
	"make comment for function
	g/\(^[^/"=->()]*\)\@<=\(::\)/:call s:MakeFolder()
	normal ,=
endfunction
"endif
"}}}

"MakeFolder(){{{
"if !exists("*s:MakeFolder()")
function! s:MakeFolder()
	exe "normal 0"
	let l:verybegin=col(".")
	exe "normal ^"
	let l:begin=col(".")
	if ( l:verybegin<l:begin )
		exe "normal 0v^hd"
	endif
	let l:line=getline(".")
	let l:head=""
	let l:tail=""
	if ( l:line=~"::" )
		"head not include the space,if yes,'^\a.*\s\+\(\a.*::\)\@='
		let l:head=matchstr(l:line,'^\a.*\(\s\+\a.*::\)\@=')
		let l:tail=matchstr(l:line,'\(::\)\@<=\([a-zA-Z~].*\)')
		let l:line=l:head." ".l:tail
	elseif ( l:line=~"(.*)" )
		let l:line=matchstr(l:line,'\<\w.*')
	endif
	if ( l:line=="" )
		let l:line="No Title"
	endif
	let l:i=line(".")
	let l:head=getline(l:i)
	while ( l:head!~"{" )
		let l:i=l:i+1
		let l:head=getline(l:i)
	endwhile
	echo l:line
	echo l:i
	let l:i=l:i+1
	exe "normal O\<ESC>V".l:i."G%"
	exe "normal :CreateFolder ".l:line."\<CR>"
	exe "normal zo".l:i."G^%a\<CR>\<ESC>zc"
	unlet l:line
	unlet l:head
	unlet l:tail
	unlet l:i
endfunction
"endif
"}}}

"s:AddCout(...){{{
function! s:AddCout(...)
	let par_title=a:1
	exe "normal o"."cout<<\"DEBUG-->".par_title."=\"<<".par_title."<<endl;\<ESC>"
	if ( a:0!=1 )
		exe "normal O"."#ifdef DEBUG_".par_title."\<ESC>"
		exe "normal jo"."#endif\<ESC>"
		exe "normal ggO"."#define DEBUG_".par_title."\<ESC>\<C-o>"
	endif
endfunction
"}}}

"s:AddFor(...){{{
function! s:AddFor(...)
	let par_counter_name=a:1
	let par_Max_name=a:2
	exe "normal o"."for ( ".par_counter_name."=0; ".par_counter_name."<".par_Max_name."; ".par_counter_name."++ )\<CR>{ }"
endfunction
"}}}

"s:AddPrintf(...){{{
function! s:AddPrintf(...)
	let par_title=a:1
	let par_titile_type=a:2
	let par_count=a:3
	let par_count_type=a:4
	let outline="normal o"."printf(\"".par_title."[%".par_count_type."]=%".par_titile_type."\\n\",".par_count.",".par_title."[".par_count."]"
	if ( par_titile_type=="s" )
		let outline=outline.".data()"
	endif
	let outline=outline."\<ESC>"
	exe outline
	exe "normal A".");\<ESC>"
	if ( a:0!=4 )
		exe "normal O"."#ifdef DEBUG_".par_title."_array\<ESC>"
		exe "normal jo"."#endif\<ESC>"
		exe "normal ggO"."#define DEBUG_".par_title."_array\<ESC>\<C-o>"
	endif
endfunction
"}}}

"c_Command{{{
"command! -nargs=? -range CreateFolder <line1>,<line2>fo |foldopen |normal f*a<args><ESC>zc
command! -buffer -nargs=+ AddCout call s:AddCout(<f-args>)
command! -buffer -nargs=+ AddFor call s:AddFor(<f-args>)
command! -buffer -nargs=+ AddPrintf call s:AddPrintf(<f-args>)
"}}}

"c_Map{{{
if !exists("b:no_user_cftplugin_maps")
	map <buffer> <Leader>c= :silent! call <SID>C_Format()<CR><CR>
	map <buffer> ,c :silent! call <SID>MakeFolder()<CR>
	map <buffer> ,ci :CreateFolder Include<CR>
	map <buffer> ,cit :CreateFolder Introduction<CR>
	map <buffer> ,cd :CreateFolder Define<CR>
	map <buffer> ,/ I//<ESC>^
	map <buffer> ,\ ^2x
	let b:no_user_cftplugin_maps=1
endif
"}}}

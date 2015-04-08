if exists("b:user_did_texftplugin")
	finish
endif
let b:user_did_texftplugin = 1

setlocal fo=tq
setlocal foldtext=MyFoldText()
setlocal isk+=:,_

"tex_Map{{{
if !exists("b:no_user_texftplugin_maps")
" if you write your \label's as \label{fig:something}, then if you
" type in \ref{fig: and press <C-n> you will automatically cycle through
" all the figure labels. Very useful!
	map <buffer> ,/ I%<ESC>^
	map <buffer> ,\ ^x
	map <C-l> <Plug>IMAP_JumpBack
	let b:no_user_cftplugin_maps=1
endif
"}}}

"doesn't work
"let g:Tex_DefaultTargetFormat = 'pdf'
"let g:Tex_MultipleCompileFormats = 'pdf'
"let g:Tex_CompileRule_pdf = 'seetex $*'
"let g:Tex_ViewRule_pdf = 'xpdf'

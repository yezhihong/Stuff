if exists("b:user_did_fortranftplugin")
    finish
endif
let b:user_did_fortranftplugin = 1

setlocal fo=tq

if !exists("b:no_user_fortranftplugin_maps")
    "vnoremap <buffer> ,ci :CreateFolder Include<CR> 
    noremap <buffer> ,/ I!<ESC>^
    noremap <buffer> ,\ ^x
endif
let b:no_user_fortranftplugin_maps=1

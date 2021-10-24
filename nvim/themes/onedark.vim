" Toggle the transparency of the background
let g:opaquebg=1
function! ToggleBG()
    if (g:opaquebg)
        hi Normal guibg=NONE
        let g:opaquebg=0
    else
        colorscheme onedark
        let g:opaquebg=1
    endif
endfunction
nmap <leader>t :call ToggleBG()<CR>

hi Comment cterm=italic
let g:onedark_hide_endofbuffer=1
let g:onedark_terminal_italics=1
let g:onedark_termcolors=256
let g:onedark_style = 'warm'

syntax on
colorscheme onedark

call ToggleBG()

" checks if your terminal has 24-bit color support
if (has("termguicolors"))
    set termguicolors
    hi LineNr ctermbg=NONE guibg=NONE
endif

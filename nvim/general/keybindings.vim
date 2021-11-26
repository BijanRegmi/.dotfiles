# Set leader key
let g:mapleader = "\<Space>"

# Toggle the background between blurTransparent and opaque
nmap <leader>t :call ToggleBG()<CR>

nmap <leader>m :bp<CR>                  " Go to previous tab
nmap <leader>n :bn<CR>                  " Go to next tab
nmap <C-w> :bd<CR>                      " Delete current tab

# Commenter
nmap <C-/> <Plug>NERDCommenterToggle        " Single line comment
vmap <C-/> <Plug>NERDCommenterToggle<CR>gv  " Multi line comment

# Ranger
nmap <leader>r :RnvimrToggle<CR>

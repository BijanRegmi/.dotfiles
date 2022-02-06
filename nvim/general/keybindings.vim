let g:mapleader = "\<Space>"                " Set the leader key to Space

nnoremap <leader>p :bp<CR>                  " Go to previous tab
nnoremap <leader>n :bn<CR>                  " Go to next tab
nnoremap <leader>w :bd<CR>                  " Close current tab

nnoremap <leader>\ :vsp<CR>                 " Open vertical   split
nnoremap <leader>- :sp<CR>                  " Open horizontal split

noremap <leader>r :RnvimrToggle<CR>         " Open Ranger

nnoremap <C-J> <C-W><C-J>                   " Move to left  split window
nnoremap <C-K> <C-W><C-K>                   " Move to below split window
nnoremap <C-L> <C-W><C-L>                   " Move to right split window
nnoremap <C-H> <C-W><C-H>                   " Move to above split window
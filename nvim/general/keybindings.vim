let g:mapleader = "\<Space>"                        " Set the leader key to Space

nnoremap <silent> <C-r> :source $MYVIMRC<CR>        " Reload vimrc file
nnoremap <C-s> :w<CR>                               " Save current buffer
nnoremap <C-t> :tabnew<CR>                          " Open new tab

nnoremap <silent> <leader>w :bd<CR>                 " Close current buffer

nnoremap <silent> <leader>\ :vsp<CR>                " Open vertical split
nnoremap <silent> <leader>- :sp<CR>                 " Open horizontal split

" Move lines up and down with Alt+j/k
nnoremap <A-j> :m .+1<CR>==
nnoremap <A-k> :m .-2<CR>==
inoremap <A-j> <Esc>:m .+1<CR>==gi
inoremap <A-k> <Esc>:m .-2<CR>==gi
vnoremap <A-j> :m '>+1<CR>gv=gv
vnoremap <A-k> :m '<-2<CR>gv=gv

" Buffer Line Mappings
nnoremap <silent> <C-n> :BufferLineCycleNext<CR>    " Go to next buffer
nnoremap <silent> <C-p> :BufferLineCyclePrev<CR>    " Go to previous buffer
nnoremap <silent> <leader>n :BufferLineMoveNext<CR> " Move current buffer to right
nnoremap <silent> <leader>p :BufferLineMovePrev<CR> " Move current buffer to left
nnoremap <silent> <leader>g :BufferLinePick<CR>     " Pick a buffer to go to
nnoremap <silent><leader>1 <Cmd>BufferLineGoToBuffer 1<CR>
nnoremap <silent><leader>2 <Cmd>BufferLineGoToBuffer 2<CR>
nnoremap <silent><leader>3 <Cmd>BufferLineGoToBuffer 3<CR>
nnoremap <silent><leader>4 <Cmd>BufferLineGoToBuffer 4<CR>
nnoremap <silent><leader>5 <Cmd>BufferLineGoToBuffer 5<CR>
nnoremap <silent><leader>6 <Cmd>BufferLineGoToBuffer 6<CR>
nnoremap <silent><leader>7 <Cmd>BufferLineGoToBuffer 7<CR>
nnoremap <silent><leader>8 <Cmd>BufferLineGoToBuffer 8<CR>
nnoremap <silent><leader>9 <Cmd>BufferLineGoToBuffer 9<CR>

" Navigate between windows
nnoremap <leader>j <C-W><C-J>                       " Move to left  split window
nnoremap <leader>k <C-W><C-K>                       " Move to below split window
nnoremap <leader>l <C-W><C-L>                       " Move to right split window
nnoremap <leader>h <C-W><C-H>                       " Move to above split window

" Explorer
nnoremap <silent> <C-e> :NERDTreeFocus<CR>          " Focus on explorer
nnoremap <silent> <C-b> :NERDTreeToggle<CR>         " Show/Hide explorer
nnoremap <silent> <leader>f :NERDTreeFind<CR>       " Reveal in explorer

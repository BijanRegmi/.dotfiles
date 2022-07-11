let g:mapleader = "\<Space>"                        " Set the leader key to Space

nnoremap <silent> <C-r> :source $MYVIMRC<CR>        " Reload vimrc file
nnoremap <C-s> :w<CR>                               " Save current buffer
nnoremap <C-t> :tabnew<CR>                          " Open new tab

" Input maninpulation
nnoremap <A-j> :m .+1<CR>==                         " Move line down
nnoremap <A-k> :m .-2<CR>==                         " Move line up
inoremap <A-j> <Esc>:m .+1<CR>==gi                  " Move line down
inoremap <A-k> <Esc>:m .-2<CR>==gi                  " Move line up
vnoremap <A-j> :m '>+1<CR>gv=gv                     " Move block of lines down
vnoremap <A-k> :m '<-2<CR>gv=gv                     " Move block of lines up

" Buffer
nnoremap <silent> <C-n> :BufferLineCycleNext<CR>    " Go to next buffer
nnoremap <silent> <C-p> :BufferLineCyclePrev<CR>    " Go to previous buffer
nnoremap <silent> <leader>n :BufferLineMoveNext<CR> " Move current buffer to right
nnoremap <silent> <leader>p :BufferLineMovePrev<CR> " Move current buffer to left
nnoremap <silent> <leader>w :bd<CR>                 " Close current buffer
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

" Window
nnoremap <silent> <leader>\ :vsp<CR>                " Open vertical split
nnoremap <silent> <leader>- :sp<CR>                 " Open horizontal split
nnoremap <leader>j <C-W><C-J>                       " Move to left  split window
nnoremap <leader>k <C-W><C-K>                       " Move to below split window
nnoremap <leader>l <C-W><C-L>                       " Move to right split window
nnoremap <leader>h <C-W><C-H>                       " Move to above split window
nnoremap re :resize<CR>                             " Max number of rows
nnoremap rs :resize 0<CR>                           " 0 rows
nnoremap ce :vertical resize<CR>                    " Max number of columns
nnoremap cs :vertical resize 0<CR>                  " 0 columns

" Explorer
nnoremap <silent> <C-e> :NERDTreeFocus<CR>          " Focus on explorer
nnoremap <silent> <C-b> :NERDTreeToggle<CR>         " Show/Hide explorer
nnoremap <silent> <leader>f :NERDTreeFind<CR>       " Reveal in explorer

""""""""""""""""""""""""""""""""""""""""
"
" Vim-Plug core
"
""""""""""""""""""""""""""""""""""""""""

set nocompatible

let vimplug_exists=expand('~/.vim/autoload/plug.vim')

if !filereadable(vimplug_exists)
  if !executable("curl")
    echoerr "You have to install curl or first install vim-plug yourself"
    execute "q!"
  endif
  echo "Installing Vim-Plug..."
  echo ""
  silent !\curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall
endif

call plug#begin(expand('~/.vim/plugged'))

""""""""""""""""""""""""""""""""""""""""
"
" Plug install packages
"
""""""""""""""""""""""""""""""""""""""""

Plug 'vimwiki/vimwiki'
Plug 'kien/ctrlp.vim'
Plug 'scrooloose/nerdtree'
Plug 'jiangmiao/auto-pairs'
Plug 'python-mode/python-mode'
Plug 'majutsushi/tagbar'

call plug#end()

""""""""""""""""""""""""""""""""""""""""
"
" General
"
""""""""""""""""""""""""""""""""""""""""

" We will have lots of issues without this
filetype plugin indent on
syntax enable
set clipboard=unnamed,unnamedplus

" File settings
set noswapfile
set nobackup
set hidden
set autoread
set fileformats=unix,dos,mac

" Modelines
set modeline
set modelines=10

" Reload .vimrc on write
autocmd! bufwritepost .vimrc source %

" Numbers!
set number
set relativenumber

" Tab config
set expandtab tabstop=4 shiftwidth=4

" Backspace config
set backspace=indent,eol,start

" Follow this leader
let mapleader=','

" Footer
set wildmenu
set showcmd
set laststatus=2
set statusline=[%n]%F%m%r%h%w%=(%{&ff}/%Y)\ (line\ %l\/%L,\ col\ %c)\

" Remember cursor position
augroup vimrc-remember-cursor-position
  autocmd!
  autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
augroup END

" Scroll offset
set scrolloff=3

"" Searching
set hlsearch
set incsearch
set ignorecase
set smartcase
nnoremap n nzzzv
nnoremap N Nzzzv
nnoremap <leader>/ :noh<cr>

" Split navigation
set splitbelow
set splitright
noremap <Leader>h :<C-u>split<CR>
noremap <Leader>v :<C-u>vsplit<CR>
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l
noremap <C-h> <C-w>h

" Buffer navigation
noremap <Leader>c :bd<CR>
noremap <Leader>x :bn<CR>
noremap <Leader>z :bp<CR>
noremap <Leader>b :ls<CR>:b 

" Maintain visual mode after shifting
vmap < <gv
vmap > >gv

" Move visual block
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

" Line inserts in normal mode
nnoremap <CR> o<ESC>

" Close buffer and open new vertical split
nnoremap <leader>k :bd<bar>vs<bar>bn<CR>

" Write and quit
nnoremap <Leader>q :q<CR>
nnoremap <Leader>w :w<CR>
cnoreabbrev W! w!
cnoreabbrev Q! q!
cnoreabbrev Qall! qall!
cnoreabbrev Wq wq
cnoreabbrev Wa wa
cnoreabbrev wQ wq
cnoreabbrev WQ wq
cnoreabbrev W w
cnoreabbrev Q q
cnoreabbrev Qall qall

""""""""""""""""""""""""""""""""""""""""
"
" Plug packages
"
""""""""""""""""""""""""""""""""""""""""

" Ctrlp
let g:ctrlp_map='<Leader>e'
let g:ctrlp_show_hidden=1
let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']

" NerdTree
nnoremap <Leader>t :NERDTreeToggle<CR>
nnoremap <Leader>y :NERDTreeFind<CR>

" Tagbar
nnoremap <Leader>o :TagbarToggle<CR>
let g:tagbar_autofocus = 1

" Pymode
let g:pymode_folding=0
let g:pymode_python="python3"

" Vimwiki
let g:vimwiki_list=[{'path':'~/.wiki'}]

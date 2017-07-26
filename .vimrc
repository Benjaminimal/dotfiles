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
Plug 'majutsushi/tagbar'
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-surround'
Plug 'Valloric/YouCompleteMe'
Plug 'sukima/xmledit'
Plug 'morhetz/gruvbox'
Plug 'yegappan/grep'
Plug 'vim-syntastic/syntastic'

" Language specific
Plug 'python-mode/python-mode'
Plug 'Glench/Vim-Jinja2-Syntax'
Plug 'pangloss/vim-javascript'

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
set encoding=utf-8

" Modelines
set modeline
set modelines=10

" Reload .vimrc on write
autocmd! bufwritepost .vimrc source %

" Colors
set t_Co=256
colorscheme gruvbox
set background=dark

" Numbers!
set number
set relativenumber

" Tab config
set expandtab tabstop=4 softtabstop=4 shiftwidth=4

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
nnoremap <Leader>q! :q!<CR>
nnoremap <Leader>qa :qa<CR>
nnoremap <Leader>qa! :qa!<CR>
nnoremap <Leader>w :w<CR>
nnoremap <Leader>wq :wq<CR>
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
" Filetypes
"
""""""""""""""""""""""""""""""""""""""""

autocmd FileType yaml setlocal ts=2 sw=2 sts=2 et
autocmd FileType html setlocal ts=2 sw=2 sts=2 et
autocmd FileType jinja setlocal ts=2 sw=2 sts=2 et
autocmd FileType css setlocal ts=2 sw=2 sts=2 et

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
let g:tagbar_autofocus=1

" YCM
let g:ycm_collect_identifiers_from_tags_files=1
let g:ycm_use_ultisnips_completer=1
let g:ycm_seed_identifiers_with_syntax=1
let g:ycm_complete_in_comments=1
let g:ycm_complete_in_strings=1
let g:ycm_autoclose_preview_window_after_insertion=1
let g:ycm_python_binary_path='python'

" Vimwiki
let g:vimwiki_list=[{'path':'~/.wiki'}]

" grep.vim
nnoremap <silent> <leader>f :Rgrep<CR>
let Grep_Default_Options = '-IR'
let Grep_Skip_Files = '*.log *.db'
let Grep_Skip_Dirs = '.git node_modules'

" Pymode
let g:pymode_folding=0
let g:pymode_breakpoint=0
let g:pymode_rope=0
let g:pymode_lint=0
let g:pymode_python="python3"

" Eclim
let g:EclimCompletionMethod = 'omnifunc'

" Syntastic
let g:syntastic_python_checkers=["flake8"]
let g:syntastic_python_flake8_args="--ignore=E501"
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 1
let g:syntastic_aggregate_errors = 1

let g:syntastic_error_symbol='✗'
let g:syntastic_warning_symbol='⚠'
let g:syntastic_style_error_symbol = '✗'
let g:syntastic_style_warning_symbol = '⚠'

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

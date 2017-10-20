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
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'scrooloose/nerdtree'
Plug 'majutsushi/tagbar'
Plug 'qpkorr/vim-bufkill'
Plug 'itchyny/lightline.vim'
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-surround'
Plug 'Valloric/YouCompleteMe'
Plug 'sukima/xmledit'
Plug 'morhetz/gruvbox'
Plug 'mileszs/ack.vim'
Plug 'w0rp/ale'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'airblade/vim-gitgutter'
Plug 'guywald1/vim-prismo'

" Python
Plug 'python-mode/python-mode'
Plug 'Glench/Vim-Jinja2-Syntax'

" Javascript
Plug 'pangloss/vim-javascript'
Plug 'ternjs/tern_for_vim'

" Typescript
Plug 'leafgarland/typescript-vim'
Plug 'Quramy/tsuquyomi'

" Processing
Plug 'sophacles/vim-processing'

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

" Cursorline
set cursorline

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
set noshowmode
" TODO: see if we need this
" set statusline=[%n]%F%m%r%h%w%=(%{&ff}/%Y)\ (line\ %l\/%L,\ col\ %c)\

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
noremap <Leader>c :BD<CR>
noremap <Leader>x :bn<CR>
noremap <Leader>z :bp<CR>
noremap <Leader>b :Buffer<CR>

" Maintain visual mode after shifting
vmap < <gv
vmap > >gv

" Move visual block
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

" Line inserts in normal mode
nnoremap <CR> o<ESC>

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
" Filetypes
"
""""""""""""""""""""""""""""""""""""""""

autocmd FileType yaml setlocal ts=2 sw=2 sts=2 et
autocmd FileType html setlocal ts=2 sw=2 sts=2 et
autocmd FileType jinja setlocal ts=2 sw=2 sts=2 et
autocmd FileType css setlocal ts=2 sw=2 sts=2 et
autocmd FileType typescript setlocal ts=2 sw=2 sts=2 et

""""""""""""""""""""""""""""""""""""""""
"
" Plug packages
"
""""""""""""""""""""""""""""""""""""""""

" fzf
nnoremap <Leader>e :Files<CR>

" NerdTree
nnoremap <Leader>t :NERDTreeToggle<CR>
nnoremap <Leader>y :NERDTreeFind<CR>
let NERDTreeIgnore=['htmlcov', '__pycache__']

" Tagbar
nnoremap <Leader>o :TagbarToggle<CR>
let g:tagbar_autofocus=1
let g:tagbar_sort=0

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

" Ack
nnoremap <Leader>f :Ack!<Space>
let g:ackprg = 'ag --vimgrep'

" vim-fugitive
nnoremap <Leader>gs :Gstatus<CR>
nnoremap <Leader>gd :Gvdiff<CR>
nnoremap <Leader>gw :Gwrite 
nnoremap <Leader>gc :Gcommit<CR>
nnoremap <Leader>gpu :Gpush<CR>
nnoremap <Leader>gul :Gpull<CR>
nnoremap <Leader>grm :Gremove<CR>
nnoremap <Leader>gmv :Gmove 
nnoremap <Leader>gre :Gread<CR>
nnoremap <Leader>gb :Gbrowse<CR>
nnoremap <Leader>gl :Glog<CR>

" vim-gitgutter
set updatetime=250

" vim-prismo
nnoremap <Leader>p :Prismo<CR>
let g:prismo_dash='-'

" Pymode
let g:pymode_folding=0
let g:pymode_breakpoint=0
let g:pymode_rope=0
let g:pymode_lint=0
let g:pymode_python="python3"

" Eclim
let g:EclimCompletionMethod = 'omnifunc'

" Gitgutter
let g:gitgutter_sign_added = '∙'
let g:gitgutter_sign_modified = '∙'
let g:gitgutter_sign_removed = '∙'
let g:gitgutter_sign_modified_removed = '∙'

" Ale
let g:ale_sign_warning = '▲'
let g:ale_sign_error = '✗'
nmap <silent> [e <Plug>(ale_previous_wrap)
nmap <silent> ]e <Plug>(ale_next_wrap)

" Lightline
let g:lightline = {
\ 'colorscheme': 'wombat',
\ 'active': {
\   'left': [['mode', 'paste'], ['filename', 'modified']],
\   'right': [['lineinfo'], ['percent'], ['filetype'], ['readonly', 'linter_warnings', 'linter_errors', 'linter_ok']]
\ },
\ 'component_expand': {
\   'linter_warnings': 'LightlineLinterWarnings',
\   'linter_errors': 'LightlineLinterErrors',
\   'linter_ok': 'LightlineLinterOK'
\ },
\ 'component_type': {
\   'linter_warnings': 'warning',
\   'linter_errors': 'error',
\   'linter_ok': 'ok'
\ },
\ }
autocmd User ALELint call lightline#update()

" ale + lightline
function! LightlineLinterWarnings() abort
  let l:counts = ale#statusline#Count(bufnr(''))
  let l:all_errors = l:counts.error + l:counts.style_error
  let l:all_non_errors = l:counts.total - l:all_errors
  return l:counts.total == 0 ? '' : printf('%d ◆', all_non_errors)
endfunction

function! LightlineLinterErrors() abort
  let l:counts = ale#statusline#Count(bufnr(''))
  let l:all_errors = l:counts.error + l:counts.style_error
  let l:all_non_errors = l:counts.total - l:all_errors
  return l:counts.total == 0 ? '' : printf('%d ✗', all_errors)
endfunction

function! LightlineLinterOK() abort
  let l:counts = ale#statusline#Count(bufnr(''))
  let l:all_errors = l:counts.error + l:counts.style_error
  let l:all_non_errors = l:counts.total - l:all_errors
  return l:counts.total == 0 ? '✓' : ''
endfunction

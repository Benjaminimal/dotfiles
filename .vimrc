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

""""""""""""""""""""""""""""""""""""""""
"
" Plug install packages
"
""""""""""""""""""""""""""""""""""""""""

call plug#begin(expand('~/.vim/plugged'))

Plug 'chriskempson/base16-vim'
Plug 'sheerun/vim-polyglot'
Plug 'scrooloose/nerdtree'
Plug 'qpkorr/vim-bufkill'
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'simeji/winresizer'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'mileszs/ack.vim'
Plug 'majutsushi/tagbar'
Plug 'itchyny/lightline.vim'
Plug 'w0rp/ale'
Plug 'Valloric/YouCompleteMe', { 'do': 'python3 install.py --clang-completer --ts-completer --java-completer' }

" Git
Plug 'airblade/vim-gitgutter'
" Plug 'tpope/vim-fugitive'
" Plug 'tpope/vim-rhubarb'

" Snippets
" Plug 'SirVer/ultisnips'
" Plug 'honza/vim-snippets'

" Python
Plug 'python-mode/python-mode'

" LaTeX
Plug 'lervag/vimtex'

" Html
" Plug 'valloric/MatchTagAlways'
" Plug 'sukima/xmledit'
" Plug 'mattn/emmet-vim'

" Css
Plug 'ap/vim-css-color'

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
set termguicolors
set background=dark
colorscheme base16-google-dark

" Cursorline
set cursorline

" Numbers!
set number
set relativenumber

" Tab config
set expandtab tabstop=4 softtabstop=4 shiftwidth=4

" Backspace config
set backspace=indent,eol,start

" Footer
set wildmenu
set showcmd
set laststatus=2
set noshowmode

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

" Split navigation
set splitbelow
set splitright

" Filetypes
autocmd FileType yaml setlocal ts=2 sw=2 sts=2 et
autocmd FileType html setlocal ts=2 sw=2 sts=2 et
autocmd FileType htmldjango setlocal ts=2 sw=2 sts=2 et
autocmd FileType css setlocal ts=2 sw=2 sts=2 et
autocmd FileType scss setlocal ts=2 sw=2 sts=2 et
autocmd FileType javascript setlocal ts=2 sw=2 sts=2 et
autocmd FileType json setlocal ts=2 sw=2 sts=2 et
autocmd FileType typescript setlocal ts=2 sw=2 sts=2 et
autocmd FileType tex setlocal ts=2 sw=2 sts=2 et
autocmd FileType matlab setlocal ts=2 sw=2 sts=2 et
autocmd FileType haskell setlocal ts=2 sw=2 sts=2 et
autocmd FileType sql setlocal ts=2 sw=2 sts=2 et
autocmd FileType pgsql setlocal ts=2 sw=2 sts=2 et
autocmd BufNewFile,BufRead *.sql set syntax=pgsql

""""""""""""""""""""""""""""""""""""""""
"
" Plug packages
"
""""""""""""""""""""""""""""""""""""""""

" NerdTree
let NERDTreeIgnore=['htmlcov', '__pycache__']

" Tagbar
let g:tagbar_autofocus=1
let g:tagbar_sort=0

" polygot
let g:polyglot_disabled = [
    \'python',
    \'latex',
    \]

" auto-pairs
func! SetHtmldjangoAutoPairs()
    let b:AutoPairs = deepcopy(g:AutoPairs)
    let b:AutoPairs['%'] = '%'
endfunction
autocmd FileType htmldjango call SetHtmldjangoAutoPairs()
func! SetLatexAutoPairs()
    let b:AutoPairs = deepcopy(g:AutoPairs)
    let b:AutoPairs['$'] = '$'
endfunction
autocmd FileType tex call SetLatexAutoPairs()
func! SetVimAutoPairs()
    let b:AutoPairs = deepcopy(g:AutoPairs)
    let b:AutoPairs['"'] = ''
endfunction
autocmd FileType vim call SetVimAutoPairs()

" fzf
let g:fzf_layout = { 'down': '~20%' }

" YCM
let g:ycm_collect_identifiers_from_tags_files=1
let g:ycm_use_ultisnips_completer=1
let g:ycm_seed_identifiers_with_syntax=1
let g:ycm_complete_in_comments=1
let g:ycm_complete_in_strings=1
let g:ycm_autoclose_preview_window_after_insertion=1
let g:ycm_python_binary_path='python3'
let g:ycm_semantic_triggers =  {
    \   'c' : ['->', '.'],
    \   'objc' : ['->', '.', 're!\[[_a-zA-Z]+\w*\s', 're!^\s*[^\W\d]\w*\s',
    \             're!\[.*\]\s'],
    \   'ocaml' : ['.', '#'],
    \   'cpp,objcpp' : ['->', '.', '::'],
    \   'perl' : ['->'],
    \   'php' : ['->', '::'],
    \   'cs,java,javascript,typescript,d,perl6,scala,vb,elixir,go' : ['.'],
    \   'ruby' : ['.', '::'],
    \   'lua' : ['.', ':'],
    \   'erlang' : [':'],
    \   'python' : ['.', 're!import.+', 'from ', 'def '],
    \   'html,htmldjango' : [' ', '<'],
    \   'css' : ['re!^\s{2,}', 're!:\s+'],
    \ }
let g:ycm_semantic_triggers.tex = g:vimtex#re#youcompleteme
let g:ycm_filetype_blacklist = {
    \ 'tagbar' : 1,
    \ 'qf' : 1,
    \ 'notes' : 1,
    \ 'markdown' : 1,
    \ 'unite' : 1,
    \ 'vimwiki' : 1,
    \ 'pandoc' : 1,
    \ 'infolog' : 1,
    \ 'mail' : 1
    \}

" Ack
let g:ackprg = 'ag --vimgrep'

" Ale
let g:ale_sign_warning = '▲'
let g:ale_sign_error = '✗'
let g:ale_python_flake8_args = '--ignore=E501,E402'
" TODO: yaml fixer not working
let g:ale_fixers = {
            \ 'python': ['autopep8'],
            \ 'javascript': ['prettier'],
            \ 'css': ['prettier'],
            \ 'scss': ['prettier'],
            \ 'json': ['fixjson'],
            \ 'yaml': ['prettier'],
            \ 'c': ['clang-format']
            \}

" Lightline
let g:lightline = {
\ 'colorscheme': 'wombat',
\ 'active': {
\   'left': [['mode', 'paste'], ['relativepath', 'modified']],
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

" Ale + Lightline
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

" Gitgutter
set updatetime=250
let g:gitgutter_sign_added = '∙'
let g:gitgutter_sign_modified = '∙'
let g:gitgutter_sign_removed = '∙'
let g:gitgutter_sign_modified_removed = '∙'

" Pthon-Mode
let g:pymode_python = 'python3'
let g:pymode_syntax = 1
let g:pymode_folding = 0
let g:pymode_lint = 0
let g:pymode_rope = 1

" Vimtex
let g:vimtex_syntax_enabled=0
let g:tex_flavor = "tex"
autocmd FileType tex imap <buffer> ]] <CR><plug>(vimtex-delim-close)<ESC>O

""""""""""""""""""""""""""""""""""""""""
"
" Keymaps
"
""""""""""""""""""""""""""""""""""""""""

" Follow this leader
let mapleader=','
let maplocalleader='\'

" Searching
nnoremap n nzzzv
nnoremap N Nzzzv
nnoremap <leader>/ :noh<cr>

" File navigation <leader>f
nnoremap <Leader>ff :Files<CR>
nnoremap <Leader>fw :w<CR>
nnoremap <Leader>fq :q<CR>
nnoremap <Leader>ft :NERDTreeToggle<CR>

" Split navigation
noremap <Leader>x :<C-u>split<CR>
noremap <Leader>v :<C-u>vsplit<CR>
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l
noremap <C-h> <C-w>h

" Buffer navigation <leader>b
noremap <Leader>bb :Buffer<CR>
noremap <Leader>bc :BD<CR>
noremap <Leader>bC :bd<CR>
noremap <Leader>bn :bn<CR>
noremap <Leader>bp :bp<CR>

" Code navigation <leader>c
nnoremap <Leader>cc :Ack!<Space>
nnoremap <Leader>cf :ALEFix<CR>
nnoremap <Leader>ct :TagbarToggle<CR>
nnoremap <Leader>cg :YcmCompleter GoToDefinition<CR>
nnoremap <Leader>cd :YcmCompleter GoToDeclaration<CR>
nnoremap <Leader>cr :YcmCompleter GoToReferences<CR>
nnoremap <Leader>ct :YcmCompleter GetType<CR>
" TODO: YCM refactoring commands

" Error navigation
nmap <silent> [e <Plug>(ale_previous_wrap)
nmap <silent> ]e <Plug>(ale_next_wrap)

" Maintain visual mode after shifting
vmap < <gv
vmap > >gv

" Move visual block
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

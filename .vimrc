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

Plug 'sheerun/vim-polyglot'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'scrooloose/nerdtree'
Plug 'majutsushi/tagbar'
Plug 'qpkorr/vim-bufkill'
Plug 'itchyny/lightline.vim'
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-surround'
Plug 'Valloric/YouCompleteMe', { 'do': './install.py --clang-completer --ts-completer --java-completer' }
Plug 'chriskempson/base16-vim'
Plug 'mileszs/ack.vim'
Plug 'w0rp/ale'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'airblade/vim-gitgutter'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'simeji/winresizer'

" Python
Plug 'python-mode/python-mode'

" Html
Plug 'valloric/MatchTagAlways'
Plug 'sukima/xmledit'
Plug 'mattn/emmet-vim'

" Css
Plug 'ap/vim-css-color'

"  LaTeX
Plug 'lervag/vimtex'

" Markdown
Plug 'shime/vim-livedown'

" Matlab
Plug 'vim-scripts/MatlabFilesEdition'

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
let base16colorspace="256"
set t_Co=256
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

" YCM
let g:ycm_collect_identifiers_from_tags_files=1
let g:ycm_use_ultisnips_completer=1
let g:ycm_seed_identifiers_with_syntax=1
let g:ycm_complete_in_comments=1
let g:ycm_complete_in_strings=1
let g:ycm_autoclose_preview_window_after_insertion=1
let g:ycm_python_binary_path='python'
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

" vim-gitgutter
set updatetime=250

" Gitgutter
let g:gitgutter_sign_added = '∙'
let g:gitgutter_sign_modified = '∙'
let g:gitgutter_sign_removed = '∙'
let g:gitgutter_sign_modified_removed = '∙'

" Ale
let g:ale_sign_warning = '▲'
let g:ale_sign_error = '✗'
let g:ale_python_flake8_args = '--ignore=E501,E402'

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

" polygot
let g:polyglot_disabled = [
    \'python',
    \'latex',
    \]

" python-mode
let g:pymode_python = 'python3'
let g:pymode_syntax = 1
let g:pymode_folding = 0
let g:pymode_lint = 0
let g:pymode_rope = 1

" auto-pairs
function SetHtmldjangoAutoPairs()
    let b:AutoPairs = deepcopy(g:AutoPairs)
    let b:AutoPairs['%'] = '%'
endfunction
autocmd FileType htmldjango call SetHtmldjangoAutoPairs()
au FileType tex let b:AutoPairs = {
        \   "(": ")",
        \   "{": "}",
        \   "[": "]",
        \   "'": "'",
        \   '"': '"',
        \   "$": "$"
        \}

" commentary
au FileType matlab setlocal commentstring=\%\ %s


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
nnoremap <Leader>ct :TagbarToggle<CR>
nnoremap <Leader>cg :YcmCompleter GoToDefinitionElseDeclaration<CR>
nnoremap <Leader>cf :Ack!<Space>
let g:pymode_breakpoint_bind = '<leader>cb'
let g:pymode_rope_show_doc_bind = 'K'

" Git <leader>g
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
nmap <silent> [e <Plug>(ale_previous_wrap)
nmap <silent> ]e <Plug>(ale_next_wrap)

" Snippets <leader>s
let g:UltiSnipsExpandTrigger = "<leader>ss"
let g:UltiSnipsJumpForwardTrigger = "<leader>ss"
let g:UltiSnipsJumpBackwardTrigger = "<leader>sp"
let g:UltiSnipsListSnippets = "<leader>sl"

" Maintain visual mode after shifting
vmap < <gv
vmap > >gv

" Move visual block
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

" Line inserts in normal mode
nnoremap <CR> o<ESC>

" vimtex
let g:vimtex_syntax_enabled=0
let g:tex_flavor = "tex"
au FileType tex imap <buffer> ]] <CR><plug>(vimtex-delim-close)<ESC>O

" livedown
autocmd FileType markdown nnoremap <buffer> <leader>ll :LivedownPreview<CR>
autocmd FileType markdown nnoremap <buffer> <leader>ls :LivedownKill<CR>
autocmd FileType markdown nnoremap <buffer> <leader>lt :LivedownToggle<CR>

"""""""""""""""""""""""""""""""""""""""
"
" Functions
"
""""""""""""""""""""""""""""""""""""""""

" Writing Prose
function ProseMode()
    set formatoptions=aw2tq
    setlocal spell spelllang=en_gb
    nnoremap \s eas<C-X><C-S>
endfu
com! Prose call ProseMode()
" TODO: find a way to call und undo this. Maybe a keybind

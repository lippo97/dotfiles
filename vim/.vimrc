set nocompatible              " be iMproved, required
filetype off                  " required

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'dylanaraps/wal.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/nerdcommenter'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'tpope/vim-vinegar'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-repeat'
Plugin 'rstacruz/vim-closer'

" Python syntax
"Plugin 'vim-python/python-syntax'
Plugin 'sheerun/vim-polyglot'

" Javascript and JSX syntax
Plugin 'pangloss/vim-javascript'
Plugin 'mxw/vim-jsx'
Plugin 'valloric/MatchTagAlways'

"Typescript syntax
Plugin 'leafgarland/typescript-vim'

Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'
Plugin 'junegunn/goyo.vim'
Plugin 'tpope/vim-abolish'
Plugin 'vimwiki/vimwiki'
Plugin 'mattn/emmet-vim'
Plugin 'metakirby5/codi.vim'

Plugin 'file:///home/filo/vim-protelis'
"Plugin 'prabirshrestha/async.vim'
"Plugin 'prabirshrestha/vim-lsp'
"Plugin 'prabirshrestha/asyncomplete.vim'
"Plugin 'prabirshrestha/asyncomplete-lsp.vim'
"Plugin 'neoclide/coc.nvim'

call vundle#end()            " required

filetype plugin indent on    " required
syntax enable

colorscheme wal
highlight Comment cterm=italic

set smartcase
set hlsearch
set incsearch

set expandtab
set smarttab
set shiftwidth=2
set tabstop=2
set ai
set si
set wrap
set number
set relativenumber
set encoding=utf-8
set fileencoding=utf-8
set noshowmode
set clipboard=unnamed
set updatetime=300

set hidden

inoremap jk <Esc>
let mapleader=","
vnoremap ; :
nnoremap ; :
noremap <C-n> :NERDTreeToggle<CR>

map <C-j> <C-W>J
map <C-k> <C-W>K
map <C-h> <C-W>H
map <C-l> <C-W>L
vnoremap > >gv
vnoremap < <gv
noremap <leader>m :noh<cr>

"nnoremap <leader>l :bnext<cr>
"nnoremap <leader>h :bprevious<cr>
nnoremap <C-J> :bnext<cr>
nnoremap <C-K> :bprevious<cr>
nnoremap <leader>bl :ls<cr>:b<space>

nnoremap <leader>q :bp <BAR> bd #<cr>
"nnoremap <leader>at :ALEToggle<cr>

noremap <F5> :so ~/.vimrc<CR>
noremap <F6> :PluginInstall<CR>
noremap <F8> :Goyo<CR>

let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'
let g:NERDTreeIgnore=['node_modules']

" Ignore some folders and files for CtrlP indexing
let g:ctrlp_custom_ignore = {
    \ 'dir':  '\.git$\|\.yardoc\|node_modules\|build\|log\|tmp$',
    \ 'file': '\.so$\|\.dat$|\.DS_Store$'
    \ }

"let g:airline#extensions#tabline#enabled = 1
"let g:airline_theme='wal'

let g:mta_filetypes = {
  \ 'javascript.jsx': 1,
  \}

" better key bindings for UltiSnipsExpandTrigger
let g:UltiSnipsExpandTrigger = "<tab>"
let g:UltiSnipsListSnippets = "<c-l>"
let g:UltiSnipsJumpForwardTrigger = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<c-k>"
let g:UltiSnipsSnippetDirectories=[$HOME.'/.vim/UltiSnips']


let g:vimwiki_list = [{'path': '~/vimwiki/',
                      \ 'syntax': 'markdown', 'ext': '.md'}]

let g:python_highlight_string_formatting = 1
let g:python_highlight_string_format = 1
let g:python_highlight_indent_errors = 1
let g:python_highlight_operators = 1

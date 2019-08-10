set nocompatible              " be iMproved, required
filetype off                  " required

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/nerdcommenter'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'tpope/vim-vinegar'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-repeat'
Plugin 'rstacruz/vim-closer'

" Javascript and JSX syntax
Plugin 'pangloss/vim-javascript'
Plugin 'mxw/vim-jsx'
Plugin 'valloric/MatchTagAlways'

Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'
Plugin 'junegunn/goyo.vim'
Plugin 'tpope/vim-abolish'
Plugin 'vimwiki/vimwiki'
Plugin 'mattn/emmet-vim'

call vundle#end()            " required

filetype plugin indent on    " required
syntax enable

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

set hidden

imap jk <Esc>
let mapleader=","
vnoremap ; :
nnoremap ; :
noremap <C-n> :NERDTreeToggle<CR>

map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l
vnoremap > >gv
vnoremap < <gv
noremap <leader>m :noh<cr>

nnoremap <leader>l :bnext<cr>
nnoremap <leader>h :bprevious<cr>
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
    \ 'dir':  '\.git$\|\.yardoc\|node_modules\|log\|tmp$',
    \ 'file': '\.so$\|\.dat$|\.DS_Store$'
    \ }

let g:airline#extensions#tabline#enabled = 1
let g:airline_theme='seagull'

let g:mta_filetypes = {
  \ 'javascript.jsx': 1,
  \}

" better key bindings for UltiSnipsExpandTrigger
let g:UltiSnipsExpandTrigger = "<tab>"
let g:UltiSnipsListSnippets = "<c-l>"
let g:UltiSnipsJumpForwardTrigger = "<c-j>"
let g:UltiSnipsJumpBackwardTrigger = "<c-k>"
let g:UltiSnipsSnippetDirectories=[$HOME.'/.vim/UltiSnips']


let g:vimwiki_list = [{'path': '~/vimwiki/',
                      \ 'syntax': 'markdown', 'ext': '.md'}]

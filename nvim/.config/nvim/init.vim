set nocompatible              " be iMproved, required
filetype off                  " required

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'

Plugin 'arcticicestudio/nord-vim'
Plugin 'vim-airline/vim-airline'
Plugin 'scrooloose/nerdcommenter'
Plugin 'scrooloose/nerdtree'
Plugin 'junegunn/fzf'
Plugin 'junegunn/fzf.vim'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-abolish'

Plugin 'honza/vim-snippets'


call vundle#end()            " required
filetype plugin indent on    " required

syntax on
filetype on
filetype plugin on
filetype indent on

colorscheme nord

set noshowmode " Since vim-airline does
set hlsearch
set nowrap
set number
set relativenumber
set hidden
set expandtab
set shiftwidth=4
set softtabstop=4
set tabstop=4

set splitbelow
set splitright

" allow project specific settings
set exrc
set secure

hi Comment gui=italic cterm=italic

let mapleader=" "
inoremap jk <Esc>
nnoremap <silent> <leader>ff :Files<cr>
nnoremap <silent> <leader>bk :bd<cr>
nnoremap <silent> <leader>bb :ls<cr>:b
nnoremap <silent> <leader>q :bd<cr>
nnoremap <silent> <leader>h :bprev<cr>
nnoremap <silent> <leader>l :bnext<cr>

vnoremap < <gv
vnoremap > >gv
nnoremap <c-p> :Files<cr>
""" Airline
let g:airline#extensions#tabline#enabled = 1
let g:airline_theme='nord'
let g:airline#extensions#tabline#formatter = 'unique_tail'
""" Nerdtree
nnoremap <c-n> :NERDTreeToggle<cr>

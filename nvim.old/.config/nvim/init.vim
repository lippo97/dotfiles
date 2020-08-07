""""""""""""""""""""""""
"  Vundle and Plugins  "
""""""""""""""""""""""""
set nocompatible              " be iMproved, required
filetype off                  " required

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'

" Airline
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'

" Nerd commenter
Plugin 'scrooloose/nerdcommenter'
Plugin 'scrooloose/nerdtree'
 "Vim vinegar
"Plugin 'tpope/vim-vinegar'
" Replacement for ctrl-p
Plugin 'junegunn/fzf'
Plugin 'junegunn/fzf.vim'
" Surround and repeat by tpope
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-abolish'
" Argument text-object support
Plugin 'inkarkat/argtextobj.vim'
" Codi
Plugin 'metakirby5/codi.vim'
" VimWiki
Plugin 'vimwiki/vimwiki'

" Vim god mode
Plugin 'neoclide/coc.nvim'
" Snippets for everything
Plugin 'honza/vim-snippets'

" Vim gradle wrapper
Plugin 'hdiniz/vim-gradle'

" Syntax highlight and indent for kotlin
Plugin 'udalov/kotlin-vim'
" Syntax highlight and indent for typescript
Plugin 'leafgarland/typescript-vim'
" Syntax highlight and indent for javascript
Plugin 'pangloss/vim-javascript'
" Syntax highlight and indent for jsx
Plugin 'maxmellon/vim-jsx-pretty'
Plugin 'jparise/vim-graphql'
Plugin 'mattn/emmet-vim'

" Colorschemes
Plugin 'morhetz/gruvbox'
Plugin 'tomasr/molokai'

" Tmux navigation
Plugin 'christoomey/vim-tmux-navigator'

" Vim-fuigitive
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-dispatch'

call vundle#end()            " required
filetype plugin indent on    " required
"""""""""""""""""""""""
"  Vim configuration  "
"""""""""""""""""""""""
"" Settings
""" Vim settings
syntax on
filetype on
filetype plugin on
filetype indent on

colorscheme gruvbox

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

""" Vimwiki
let g:vimwiki_list = [{'path': '~/vimwiki/',
                      \ 'syntax': 'markdown', 'ext': '.md'}]
""" Syntax

" Function to detect current word syntax
nmap <leader>z :call <SID>SynStack()<CR>
function! <SID>SynStack()
    if !exists("*synstack")
        return
    endif
    echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc
"" Autocmds

"" Vim map
""" General
let mapleader=","
inoremap jk <Esc>
nnoremap ; :
vnoremap ; :
nnoremap <leader>m :noh<cr>
nnoremap <silent> <leader>ec :e $MYVIMRC<cr>
nnoremap <silent> <leader>so :source $MYVIMRC<cr>
nnoremap <silent> <leader>pi :PluginInstall <cr>
nnoremap <silent> <leader>q :bd<cr>
nnoremap <silent> <leader>h :bprev<cr>
nnoremap <silent> <leader>l :bnext<cr>

" Vim tmux navigation
let g:tmux_navigator_no_mappings = 1
let g:tmux_navigator_save_on_switch = 1

nnoremap <silent> <c-h> :TmuxNavigateLeft<cr>
nnoremap <silent> <c-j> :TmuxNavigateDown<cr>
nnoremap <silent> <c-k> :TmuxNavigateUp<cr>
nnoremap <silent> <c-l> :TmuxNavigateRight<cr>
nnoremap <silent> <c-/> :TmuxNavigatePrevious<cr>

vnoremap < <gv
vnoremap > >gv
""" Fzf
nnoremap <c-p> :Files<cr>
nnoremap <c-b> :Buffers<cr>
nnoremap <leader>rg :Rg<cr>
""" Netrw
"let g:netrw_banner = 0
"let g:netrw_liststyle = 3
"let g:netrw_browse_split = 4
"let g:netrw_altv = 1
"let g:netrw_winsize = 25
""" Airline
let g:airline#extensions#tabline#enabled = 1
let g:airline_theme='gruvbox'
let g:airline#extensions#tabline#formatter = 'unique_tail'
""" Nerdtree
nnoremap <c-n> :NERDTreeToggle<cr>

""" Emmet-vim
let g:user_emmet_expandabbr_key = '<c-t>'
"""""""""""""""""""""""
"  Coc configuration  "
"""""""""""""""""""""""

" Smaller updatetime for CursorHold & CursorHoldI
set updatetime=300

" don't give |ins-completion-menu| messages.
set shortmess+=c

" always show signcolumns
set signcolumn=yes

" Some server have issues with backup files, see #649
set nobackup
set nowritebackup

" Better display for messages
set cmdheight=1

" Use <c-space> for trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

"inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
"inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" Use `[c` and `]c` for navigate diagnostics
nmap <silent> [c <Plug>(coc-diagnostic-prev)
nmap <silent> ]c <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Remap for do codeAction of current line
 nmap <leader>ac <Plug>(coc-codeaction)

" Remap for do action format
"nmap <silent> F <Plug>(coc-action-format) "does not work
" nnoremap <silent> F :call CocAction('format')<CR>

" Show signature help
autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')

" Use K for show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if &filetype == 'vim'
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
 nmap <leader>rn <Plug>(coc-rename)

" Show all diagnostics
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Find symbol of current document
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
" nnoremap <silent> <space>p  :<C-u>CocListResume<CR>

" close preview (shown for hover / signature help)
nnoremap <leader>p :pclose<CR>
" nnoremap <leader> <Esc> :pclose<CR>

"nnoremap <silent> <M-Z> :ccl<CR>

" COC Snippets

" Use <C-l> for trigger snippet expand.
"imap <C-l> <Plug>(coc-snippets-expand)

" Use <C-j> for select text for visual placeholder of snippet.
vmap <C-j> <Plug>(coc-snippets-select)

" Use <C-j> for jump to next placeholder, it's default of coc.nvim
let g:coc_snippet_next = '<c-j>'

" Use <C-k> for jump to previous placeholder, it's default of coc.nvim
let g:coc_snippet_prev = '<c-k>'

" Use <C-j> for both expand and jump (make expand higher priority.)
imap <C-j> <Plug>(coc-snippets-expand-jump)

inoremap <silent><expr> <TAB>
      \ pumvisible() ? coc#_select_confirm() :
      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

"let g:coc_snippet_next = '<tab>'
"""""""""""""""""""""""""""
"  Defining this folding  "
"""""""""""""""""""""""""""
"" Autofolding .vimrc
" see http://vimcasts.org/episodes/writing-a-custom-fold-expression/
""" defines a foldlevel for each line of code
function! VimFolds(lnum)
  let s:thisline = getline(a:lnum)
  if match(s:thisline, '^"" ') >= 0
    return '>2'
  endif
  if match(s:thisline, '^""" ') >= 0
    return '>3'
  endif
  let s:two_following_lines = 0
  if line(a:lnum) + 2 <= line('$')
    let s:line_1_after = getline(a:lnum+1)
    let s:line_2_after = getline(a:lnum+2)
    let s:two_following_lines = 1
  endif
  if !s:two_following_lines
      return '='
    endif
  else
    if (match(s:thisline, '^"""""') >= 0) &&
       \ (match(s:line_1_after, '^"  ') >= 0) &&
       \ (match(s:line_2_after, '^""""') >= 0)
      return '>1'
    else
      return '='
    endif
  endif
endfunction

""" defines a foldtext
function! VimFoldText()
  " handle special case of normal comment first
  let s:info = '('.string(v:foldend-v:foldstart).' lines)'
  if v:foldlevel == 1
    let s:line = ' ◇ '.getline(v:foldstart+1)[3:-2]
  elseif v:foldlevel == 2
    let s:line = '   ●  '.getline(v:foldstart)[3:]
  elseif v:foldlevel == 3
    let s:line = '     ▪ '.getline(v:foldstart)[4:]
  endif
  if strwidth(s:line) > 80 - len(s:info) - 3
    return s:line[:79-len(s:info)-3+len(s:line)-strwidth(s:line)].'...'.s:info
  else
    return s:line.repeat(' ', 80 - strwidth(s:line) - len(s:info)).s:info
  endif
endfunction

""" set foldsettings automatically for vim files
augroup fold_vimrc
  autocmd!
  autocmd FileType vim
                   \ setlocal foldmethod=expr |
                   \ setlocal foldexpr=VimFolds(v:lnum) |
                   \ setlocal foldtext=VimFoldText() |
     "              \ set foldcolumn=2 foldminlines=2
augroup END

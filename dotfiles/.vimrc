set nocompatible
set nowrap
set autoindent
set hlsearch
set ruler
set scrolloff=3
set shortmess=fiIlnxtToO
set showcmd
set showmode
set sidescroll=1
set tabstop=2
set shiftwidth=2
set expandtab
set wildmenu
set number
set hidden
set ignorecase 
set smartcase
set title

syntax on
filetype on
filetype indent on
filetype plugin on
compiler ruby
set nocp

:nmap <F1> nop
:imap <F1> nop
:nmap <C-l> :set invnumber<CR>

autocmd FileType ruby,eruby set omnifunc=rubycomplete#Complete
autocmd FileType ruby,eruby let g:rubycomplete_buffer_loading = 1
autocmd FileType ruby,eruby let g:rubycomplete_rails = 1
autocmd FileType ruby,eruby let g:rubycomplete_classes_in_global = 1

highlight Pmenu ctermbg=238 gui=bold
set background=dark
colorscheme molokai

set laststatus=2
let g:buftabs_in_statusline=1
let g:buftabs_separator=":"
let g:buftabs_marker_modified = "*"
let mapleader=","

:noremap <C-i> <ESC>mzgg=G''
:noremap <C-b> :bnext!<CR>

set autoindent
set expandtab
set hidden
set hlsearch
set ignorecase 
set nocompatible
set nowrap
set number
set ruler
set scrolloff=3
set shortmess=fiIlnxtToO
set showcmd
set showmode
set sidescroll=1
set smartcase
set title
set wildmenu

set tabstop=2
set shiftwidth=2

set completeopt=preview

syntax on
filetype on
filetype indent on
filetype plugin on
compiler ruby

autocmd FileType ruby,eruby set omnifunc=rubycomplete#Complete
autocmd FileType ruby,eruby let g:rubycomplete_buffer_loading = 1
autocmd FileType ruby,eruby let g:rubycomplete_rails = 1
autocmd FileType ruby,eruby let g:rubycomplete_classes_in_global = 1
autocmd FileType python setl shiftwidth=4 tabstop=4

set background=dark
colorscheme molokai

set laststatus=2
set statusline=
set statusline+=%f\ " file name
set statusline+=%h%1*%m%r%w%0* " flag
set statusline+=%= " right align
set statusline+=%-14.(%l,%c%V%)\ %<%P " offset

let g:buftabs_in_statusline=1
let g:buftabs_separator=":"
let g:buftabs_marker_modified = "*"
let mapleader=","
let python_highlight_all=1

noremap <C-i> <ESC>mzgg=G''
noremap <C-b> :bnext!<CR>
noremap <C-l> :set invnumber<CR>

"set listchars=tab:»\ ,trail:·,eol:¶
nmap <silent> <leader>s :set nolist!<CR>


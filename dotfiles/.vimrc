" vundler stuff
set nocompatible
filetype off
set rtp+=~/.vim/bundle/vundle
call vundle#rc()

Bundle 'gmarik/vundle'
Bundle 'Solarized'
Bundle 'snipMate'
Bundle 'vim-ruby/vim-ruby'
Bundle "rails.vim"
Bundle 'matchit.zip'
Bundle 'scrooloose/nerdtree'
Bundle 'buftabs'
Bundle 'scratch'
Bundle 'tpope/vim-surround'
Bundle 'taglist.vim'
Bundle 'blueyed/vim-autoclose'

filetype plugin indent on

set autoindent
set expandtab
set hidden
set hlsearch
set ignorecase 
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
set smarttab

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
try
  colorscheme solarized
catch
  colorscheme default
endtry

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

noremap <leader>i mzgg=G''
noremap <C-b> :bnext!<CR>
noremap <C-l> :set invnumber<CR>
noremap <C-i> ==j

try
  set listchars=tab:»\ ,trail:·,eol:¶
catch
endtry

nmap <silent> <leader>s :set nolist!<CR>
let g:CommandTMatchWindowAtTop=1 " show window at top

map <Esc><Esc> :w<CR>


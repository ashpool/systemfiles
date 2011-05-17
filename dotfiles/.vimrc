set nocompatible
set autoindent
set hlsearch
set laststatus=2
set ruler
set scrolloff=3
set shortmess=fiIlnxtToO
set showcmd
set showmode
set sidescroll=1
set tabstop=2
set shiftwidth=2
set expandtab
set viminfo=%,'50,\"100,:100,n~/.viminfo
set wildmenu
set wrap
set number
syntax on
filetype on
filetype indent on
filetype plugin on
compiler ruby
set nocp
:nmap <F1> nop
:imap <F1> nop
:nmap <C-l> :set invnumber<CR>
"ruby
autocmd FileType ruby,eruby set omnifunc=rubycomplete#Complete
autocmd FileType ruby,eruby let g:rubycomplete_buffer_loading = 1
autocmd FileType ruby,eruby let g:rubycomplete_rails = 1
autocmd FileType ruby,eruby let g:rubycomplete_classes_in_global = 1
"improve autocomplete menu color
highlight Pmenu ctermbg=238 gui=bold
set background=dark
colorscheme ir_black

set laststatus=2
:let g:buftabs_in_statusline=1



"Vundle setup
set nocompatible " viMproved.
filetype off
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" Bundles.
Bundle 'gmarik/vundle'
Bundle 'kien/ctrlp.vim'
Bundle 'scrooloose/nerdtree'
Bundle 'Lokaltog/vim-easymotion'
Bundle 'scrooloose/syntastic'
Bundle 'tpope/vim-fugitive'
Bundle 'Lokaltog/vim-powerline'
Bundle 'flazz/vim-colorschemes'
Bundle 'altercation/vim-colors-solarized'
Bundle 'rstacruz/sparkup'
Bundle 'tpope/vim-surround'
Bundle 'vim-scripts/trailing-whitespace'
Bundle 'Raimondi/YAIFA'

Bundle 'hail2u/vim-css3-syntax'
Bundle 'skammer/vim-css-color'
Bundle 'groenewege/vim-less'

Bundle 'airblade/vim-gitgutter'
Bundle 'vim-scripts/taglist.vim'
" https://github.com/pangloss/vim-javascript
Bundle "pangloss/vim-javascript"

filetype plugin indent on " required!
" end Vundle setup

if $TERM == "xterm-256color" || $TERM == "screen-256color" || $COLORTERM == "gnome-terminal"
 set t_Co=256
endif

syntax on
if has('gui_running')
  set background=light
else
  set background=dark
endif

colorscheme solarized

" Leader
let mapleader = ","

" EDITOR SETTINGS
set ignorecase          " case insensitive searching
set smartcase           " but become case sensitive if you type uppercase characters
" this can cause problems with other filetypes
" see comment on this SO question http://stackoverflow.com/questions/234564/tab-key-4-spaces-and-auto-indent-after-curly-braces-in-vim/234578#234578
set smartindent         " smart auto indenting
set autoindent          " on new lines, match indent of previous line
set copyindent          " copy the previous indentation on autoindenting
set cindent             " smart indenting for c-like code
set cino=b1,g0,N-s,t0,(0,W4  " see :h cinoptions-values
set smarttab            " smart tab handling for indenting
set magic               " change the way backslashes are used in
" search patterns
set bs=indent,eol,start " Allow backspacing over everything in insert mode
set nobackup            " no backup~ files.
set smartindent

" Better search
set incsearch
set ignorecase
set smartcase
" set hlsearch
set nohlsearch
nmap \q :nohlsearch<CR>

" Better background handling
:nmap <C-e> :e#<CR>


" Easymotion
let g:EasyMotion_leader_key = '<Leader>'


" Map CtrlP buffer search to ;
:nmap ; :CtrlPBuffer<CR>

" Line numbers
:set number

" :let g:ctrlp_map = '<Leader>t'
" :let g:ctrlp_match_window_bottom = 0
" :let g:ctrlp_match_window_reversed = 0
" :let g:ctrlp_custom_ignore = '\v\~$|\.(o|swp|pyc|wav|mp3|ogg|blend)$|(^|[/\\])\.(hg|git|bzr)($|[/\\])|__init__\.py'
" :let g:ctrlp_working_path_mode = 0
" :let g:ctrlp_dotfiles = 0
" :let g:ctrlp_switch_buffer = 0

" Config for "pangloss/vim-javascript"
let g:html_indent_inctags = "html,body,head,tbody"
let g:html_indent_script1 = "inc"
let g:html_indent_style1 = "inc"

" :nmap \t :set expandtab tabstop=4 shiftwidth=4 softtabstop=4<CR>
" :nmap \T :set expandtab tabstop=8 shiftwidth=8 softtabstop=4<CR>
" :nmap \M :set noexpandtab tabstop=8 softtabstop=4 shiftwidth=4<CR>
" :nmap \m :set expandtab tabstop=2 shiftwidth=2 softtabstop=2<CR>
" " backup to ~/.tmp
set expandtab tabstop=2 softtabstop=2 shiftwidth=2
set backup
set backupdir=~/.vim-tmp,~/.tmp,~/tmp
set backupskip=/tmp/*,/private/tmp/*
set directory=~/.vim-tmp,~/.tmp,~/tmp
set writebackup """ "

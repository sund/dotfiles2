"" Configuration

"" Basic Settings

filetype plugin indent on
syntax on
autocmd Filetype gitcommit setlocal spell textwidth=72
set encoding=utf-8
set guifont=Menlo:h14
set scrolloff=3
set autoindent
set showmode
set showcmd
set hidden
set wildmenu
set wildmode=list:longest
set visualbell
set cursorline
set ttyfast
set ruler
set backspace=indent,eol,start
set laststatus=2
set relativenumber
"set undofile
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set showmatch

"" Aesthetics
" long lines

set wrap
set textwidth=79
set formatoptions=qrn1
set colorcolumn=80

" show invis chars like TextMate

"set list
"set listchars=tab:▸\ ,eol:¬

"" Mappings and shortcuts

"" Search and moving

"nnoremap / /\v
"vnoremap / /\v
set ignorecase
set smartcase
set gdefault
set incsearch
set showmatch
set hlsearch
nnoremap <leader><space> :noh<cr>
nnoremap <tab> %
vnoremap <tab> %

" backups and swap
"set nobackup

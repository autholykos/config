set nocompatible " No compatibility with old VI, required
filetype off " required

" Set runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

  Plugin 'VundleVim/Vundle.vim'
  Plugin 'lifepillar/vim-solarized8'
  Plugin 'tpope/vim-fugitive'
  Plugin 'fatih/vim-go'			" golang support

call vundle#end()
filetype plugin indent on

" Solarized Configuration "{{{
syntax enable
set background=dark
colorscheme solarized8
"}}}

" Reload .vimrc on save "{{{
augroup GroupAutoVIMRC
	autocmd!
	autocmd bufwritepost .vimrc source $MYVIMRC
augroup END
" }}}

let mapleader = "," " Mapping <leader> to ,

" Editing .vimrc in a new tab window with --> `,v`
nnoremap <leader>v :tabedit $MYVIMRC<CR>
set cursorline " Highlight current line
" When jumping somewhere, make sure there are at least 5 lines from the bottom
" or top
set scrolloff=5

" When I search for things, I want the match to be in the middle of the screen
nnoremap n nzz
nnoremap N Nzz
nnoremap * *zz
nnoremap # #zz
nnoremap g* g*zz
nnoremap g# g#zz

" Rid of annoyances "{{{
set noerrorbells
set novisualbell
set t_vb=
"}}}

" Ignore a bunch of backup, config, binary files
set wildignore+=*.a,*.o,*.pyc
set wildignore+=*.bmp,*.gif,*.jpg,*.ico,*.png
set wildignore+=.DS_Store,.git,.hg,.svn
set wildignore+=*.swp,*.tmp,*~

" I use git, no need for backups
set nobackup
set nowritebackup
set noswapfile
set encoding=utf-8

" Indentation and bracket management "{{{
" I'll take my tabs 4 spaces, ty
set softtabstop=4
set shiftwidth=4 " << >> in- dedent of 4 spaces
set copyindent " copy structure of indentation as well
set shiftround " use multiple of shiftwidth when shifting
set showmatch " highlight matching brackets
set autochdir " vim will change to the directory containing the file
set autowrite " saves file content automatically if make command is called
"}}}

:imap jk <Esc>

" Golang related settings "{{{
autocmd FileType go nmap <leader>b <Plug>(go-build)
autocmd FileType go nmap <leader>r <Plug>(go-run)

let g:go_fmt_command = "goimports"

" style
let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_functions = 1

let g:go_metalinter_autosave = 1
let g:go_metalinter_autosave_enabled = ['vet', 'golint']
"}}}


set nocompatible " No compatibility with old VI, required

"**************************************
"" Vim-Plug core
"**************************************
let vimplug_exists=expand('~/.vim/autoload/plug.vim')

let g:vim_bootstrap_langs = "go"
let g:vim_bootstrap_editor = "vim"

if !filereadable(vimplug_exists)
    if !executable("curl")
	echoerr "you have to install curl first or install vim-plug yourself"
	execute "q!"
    endif
    echo "Installing Vim-Plug"
    echo ""
    silent exec "!\curl -fLo " . vimplug_exists . " --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
    let g:not_finish_vimplug = "yes"

    autocmd VimEnter * PlugInstall
endif

" Required:
call plug#begin(expand('~/.vim/plugged'))

Plug 'scrooloose/nerdtree'
Plug 'jistr/vim-nerdtree-tabs'
Plug 'tpope/vim-fugitive'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

if isdirectory('/usr/local/opt/fzf')
    Plug '/usr/local/opt/fzf' | Plug 'junegunn/fzf.vim'
else
    Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --bin' }
    Plug 'junegunn/fzf.vim'
endif
let g:make = 'gmake'
if exists('make')
    let g:make = 'make'
endif
"***************************************************
"" Colors
"**************************************************
Plug 'tomasr/molokai'
Plug 'dracula/vim',{'as':'dracula'}
Plug 'morhetz/gruvbox'

"****************************************************
"" Development Bundle
"****************************************************
Plug 'fatih/vim-go', {'do': ':GoInstallBinaries'}			"golang support
Plug 'neoclide/coc.nvim', {'branch': 'release'} "PLS client
Plug 'prettier/vim-prettier', {
  \ 'do': 'yarn install',
  \ 'branch': 'release/1.x',
  \ 'for': [
    \ 'javascript',
    \ 'typescript',
    \ 'css',
    \ 'less',
    \ 'scss',
    \ 'json',
    \ 'graphql',
    \ 'markdown',
    \ 'vue',
    \ 'lua',
    \ 'php',
    \ 'python',
    \ 'ruby',
    \ 'html',
    \ 'swift' ] }

call plug#end()

" Required
filetype plugin indent on

"*****************************************************************************
" CORE SETUP
"*****************************************************************************

"{{{
" remove trailing whitespaces
command! FixWhitespace :%s/\s\+$//e

" Reload .vimrc on save
augroup GroupAutoVIMRC
	autocmd!
	autocmd bufwritepost .vimrc source $MYVIMRC
augroup END

let mapleader = "," " Mapping <leader> to ,

" Editing .vimrc in a new tab window with --> `,v`
nnoremap <leader>v :tabedit $MYVIMRC<CR>
" fixing backspace
set backspace=indent,eol,start

" Encoding
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8
set ttyfast

syntax on
set ruler
" terminal emulation
nnoremap <silent> <leader>sh :terminal<CR>
" getting rid of annoying CTRL-s freeze
nnoremap <silent> <C-s> :w<CR>

" Hybrid line number
set number relativenumber

augroup numbertoggle
    autocmd!
    autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
    autocmd BufLeave,FocusLost,InsertEnter * set norelativenumber
augroup end
" Fixing the backspace problem for xterm
" if &term == "xterm-256color"
"   set t_kb=^?
" endif
"}}}


"*****************************************************************************
"" INDENTATION, BRACKETS AND VISUAL STUFF
"*****************************************************************************
"{{{

" I'll take my tabs 4 spaces, ty
set tabstop=4
set softtabstop=0
set shiftwidth=4 " << >> in- dedent of 4 spaces
set expandtab

set copyindent " copy structure of indentation as well
set shiftround " use multiple of shiftwidth when shifting
set showmatch " highlight matching brackets
" set autochdir " vim will change to the directory containing the file
set autowrite " saves file content automatically if make command is called
nnoremap <silent> <C-s> :w<CR> " save file instead of locking the damn screen

inoremap {<CR> {<CR>}<ESC><S-o>
inoremap [<CR> [<CR>]<ESC><S-o>
inoremap (<CR> (<CR>)<ESC><S-o>

"" Switching windows
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l
noremap <C-h> <C-w>h

"" Vmap for maintain Visual Mode after shifting > and <
vmap < <gv
vmap > >gv

"" Move visual block
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

set fileformats=unix,dos,mac
if exists('$SHELL')
    set shell=$SHELL
else 
    set shell=/bin/sh
endif

" Session management
let g:session_directory = "~/.vim/session"
let g:session_autoload = "no"
let g:session_autosave = "no"
let g:session_command_aliases = 1
" }}}

"*****************************************************
" COLORSCHEME AND VISUALIZATION SETUP
"*****************************************************

let no_buffer_menu=1
"silent! colorscheme dracula
silent! colorscheme gruvbox

set t_Co=256
set guioptions=egmrti
set gfn=PragmataPro\ Mono\ Liga:h12

" Vim 8 supports truecolor terminal out of the box
set termguicolors

"" Split
noremap <Leader>h :<C-u>split<CR>
noremap <Leader>v :<C-u>vsplit<CR>

" Am I on MACOS?
if has("gui_running")
    if has("gui_mac") || has("gui_macvim")
        set guifont=Menlo:h12
        set transparency=7
    endif
else
    " Most probably not on MACOS
    let g:CSApprox_loaded = 1

    " IndentLine
    let g:indentLine_enabled = 1
    let g:indentLine_concealcursor = 0
    let g:indentLine_char = '┆'
    let g:indentLine_faster = 1


    if $COLORTERM == 'gnome-terminal'
        set term=gnome-256color
    else
        if $TERM == 'xterm'
            set term=xterm-256color
        endif
    endif
  
endif

set background=dark
if &term =~ '256color'
    set t_ut=
endif

" When jumping somewhere, make sure there are at least 5 lines from the bottom
set scrolloff=5

" ******************************************************
" NERDTree
" ******************************************************

"{{{
let g:NERDTreeChDirMode=0 " prevent NERDTree to chdir into the open file
let g:NERDTreeIgnore=['\.rbc$', '\~$', '\.pyc$', '\.db$', '\.sqlite$', '__pycache__']
let g:NERDTreeSortOrder=['^__\.py$', '\/$', '*', '\.swp$', '\.bak$', '\~$']
let g:NERDTreeShowBookmarks=1
let g:nerdtree_tabs_focus_on_files=1
let g:NERDTreeMapOpenInTabSilent = '<RightMouse>'
let g:NERDTreeWinSize = 50
nnoremap <silent> <F2> :NERDTreeFind<CR>
nnoremap <silent> <F3> :NERDTreeToggle<CR>
"}}}

"****************************************************************************
" CURSOR RULES
"***************************************************************************
"{{{
set cursorline " Highlight current line or top

"" Remember cursor position
augroup vimrc-remember-cursor-position
  autocmd!
  autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
augroup END

" Change cursor to underscore when in insert mode
" if &term =~ "xterm\\|rxvt"
"     "use an orange underscore in insert mode
"     let &t_SI .= "\<Esc>]12;orange\x7[4 q"
"     "use a block cursor in all others
"     let &t_EI .= "\<Esc>]12;gray\x7[2 q"
"     " reset cursor when vim exits
"     autocmd VimLeave * silent !echo -ne "\033]12;gray\007"
" endif

"}}}

"*****************************************************************************
" AUTOCMD RULES
"*****************************************************************************
"{{{

"" The PC is fast enough, do syntax highlight syncing from start unless 200 lines
augroup vimrc-sync-fromstart
  autocmd!
  autocmd BufEnter * :syntax sync maxlines=200
augroup END

" Defining wrapping
if !exists('*s:setupWrapping')
    function s:setupWrapping()
        set wrap
        set wm=2
        set textwidth=79
    endfunction
endif

augroup vimrc_wrapping
    autocmd!
    autocmd BufRead,BufNewFile *.txt call s:setupWrapping()
augroup end

"" make/cmake
augroup vimrc-make-cmake
  autocmd!
  autocmd FileType make setlocal noexpandtab
  autocmd BufNewFile,BufRead CMakeLists.txt setlocal filetype=cmake
augroup END

set autoread

" When I search for things, I want the match to be in the middle of the screen
nnoremap n nzzzv
nnoremap N Nzzzv
nnoremap * *zz
nnoremap # #zz
nnoremap g* g*zz
nnoremap g# g#zz

" Rid of annoyances
set noerrorbells
set novisualbell
set t_vb=

" Ignore a bunch of backup, config, binary files
set wildmode=list:longest,list:full
set wildignore+=*.a,*.o,*.so,*.obj,*.pyc,__pycache__,*.prof,*.log
set wildignore+=*.bmp,*.gif,*.jpg,*.ico,*.png
set wildignore+=.DS_Store,.git,.hg,.svn
set wildignore+=*.swp,*.tmp,*~
set wildignore+=*.zip,*.tgz,*.db,*.sqlite

" I am annoyed by swap files. I know that git is not a solution but I am OK
" with it
set nobackup
set nowritebackup
set noswapfile
set encoding=utf-8

" folding
set foldmethod=manual
set foldnestmax=10
set nofoldenable
set foldlevel=2

:imap jk <Esc>
"}}}

""******************************************************************
" COC SETUP
""******************************************************************
"{{{

" Installing coc extensions
let s:coc_extensions = [
  \ 'coc-html',
  \ 'coc-css',
  \ 'coc-tsserver',
  \ 'coc-json' ]

for extension in s:coc_extensions
    call coc#add_extension(extension)
endfor

set cmdheight=2 " Number of screen lines to use for the command-line
set updatetime=300 " Used by coc for diagnostic messages and CursorHold
set shortmess+=c " disable | ins-completion-menu | messages
set signcolumn=yes " signcolumn 

"" Use tab for triggering completion with characters ahead and navigate
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()

inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col -1] =~# '\s'
endfunction

"" Use <c-space> to trigger completion
inoremap <silent><expr> <c-space> coc#refresh()

" Use <CR> to confirm completion, <C-g>u means break undo chain at current
" position.
" Coc only does snippet and additional edit on confirm
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" Use `[c` and `]c` to navigate diagnostic
nmap <silent> [c <Plug>(coc-diagnostic-prev)
nmap <silent> ]c <Plug>(coc-diagnostic-next)

""""""""""""""""""""""""""""""""""""""""
" Remap keys for gotos
""""""""""""""""""""""""""""""""""""""""
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

"" Use k to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
    if(index(['vim','help'], &filetype) >= 0)
        execute 'h '.expand('<cword>')
    else
        call CocAction('doHover;)
    endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Use `:Format` for formatting current buffer
command! -nargs=0 Format :call CocAction('format')
" Use `:Fold` for folding current buffer
command! -nargs=0 Fold :call CocAction('fold')
" Use `:Format` for formatting current buffer
command! -nargs=0 OR :call CocAction('runCommand', 'editor.action.organizeImport')

" Using CocList
" Show all diagnostic
nnoremap <silent> <space>a :<C-u>Coclist diagnostics<CR>
" Show commands
nnoremap <silent> <space>c :<C-u>Coclist commands<CR>
" Search symbols
nnoremap <silent> <space>s :<C-u>Coclist -I symbols<CR>
" Search symbols in current document
nnoremap <silent> <space>o :<C-u>Coclist outline<CR>

"}}}

"*****************************************************************************
"" FUZZY FINDING (FZF), GREP OPTIONS (RIPGREP) & SEARCH CONFIG
"*****************************************************************************
"{{{

" Searching 
set hlsearch
set incsearch
set ignorecase
set smartcase


" Enabling FZF with RIPGREP
if executable('rg')
  let $FZF_DEFAULT_COMMAND = 'rg --files --hidden --follow --glob "!.git/*"'
  set grepprg=rg\ --vimgrep
  command! -bang -nargs=* Find call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --hidden --follow --glob "!.git/*" --color "always" '.shellescape(<q-args>).'| tr -d "\017"', 1, <bang>0)
else 
    let $FZF_DEFAULT_COMMAND =  "find * -path '*/\.*' -prune -o -path 'node_modules/**' -prune -o -path 'target/**' -prune -o -path 'dist/**' -prune -o  -type f -print -o -type l -print 2> /dev/null"
endif

" Ctrl-p like functionalities but with fzf
nnoremap <C-p> :Files<CR>
" Searching for content within the file
nnoremap <C-f> :Rg<CR>

nnoremap <silent> <leader>b :Buffers<CR>
nnoremap <silent> <leader>e :FZF -m<CR>
"Recovery commands from history through FZF
nmap <leader>y :History:<CR>

" grep.vim
let Grep_Default_Options = '-IR'
let Grep_Skip_Files = '*.log *.db'
let Grep_Skip_Dirs = '.git node_modules'

"" Clean search (highlight)
nnoremap <silent> <leader><space> :noh<cr>
"}}}

"*****************************************************************************
"" BUFFER
"*****************************************************************************
"{{{

" Enable hidden buffers
set hidden 

"" Buffer nav
noremap <leader>z :bp<CR>
noremap <leader>q :bp<CR>
noremap <leader>x :bn<CR>
noremap <leader>w :bn<CR>

"" Close buffer
noremap <leader>c :bd<CR>
"}}}


"*****************************************************************************
" LOCAL RELATED CONFIG
"*****************************************************************************
"{{{
"" Include user's local vim config
if filereadable(expand("~/.vimrc.local"))
  source ~/.vimrc.local
endif
"}}}

"*****************************************************************************
"" STATUS & AIRLINE STATUSBAR
"*****************************************************************************

"{{{
" vim-airline
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif

set laststatus=2
set modeline
set modelines=10

set title
set titleold="Terminal"
set titlestring=%F
set statusline=%F%m%r%h%w%=(%{&ff}/%Y)\ (line\ %l\/%L,\ col\ %c)\

if exists("*fugitive#statusline")
    set statusline+=%{fugitive#statusline()}
endif

set statusline+=%{coc#status()}

" vim-airline
let g:airline_theme = 'powerlineish'
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#ale#enabled = 0
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tagbar#enabled = 1
let g:airline_skip_empty_sections = 1

if !exists('g:airline_powerline_fonts')
  let g:airline#extensions#tabline#left_sep = ' '
  let g:airline#extensions#tabline#left_alt_sep = '|'
  let g:airline_left_sep          = '▶'
  let g:airline_left_alt_sep      = '»'
  let g:airline_right_sep         = '◀'
  let g:airline_right_alt_sep     = '«'
  let g:airline#extensions#branch#prefix     = '⤴' "➔, ➥, ⎇
  let g:airline#extensions#readonly#symbol   = '⊘'
  let g:airline#extensions#linecolumn#prefix = '¶'
  let g:airline#extensions#paste#symbol      = 'ρ'
  let g:airline_symbols.linenr    = '␊'
  let g:airline_symbols.branch    = '⎇'
  let g:airline_symbols.paste     = 'ρ'
  let g:airline_symbols.paste     = 'Þ'
  let g:airline_symbols.paste     = '∥'
  let g:airline_symbols.whitespace = 'Ξ'
else
  let g:airline#extensions#tabline#left_sep = ''
  let g:airline#extensions#tabline#left_alt_sep = ''

  " powerline symbols
  let g:airline_left_sep = ''
  let g:airline_left_alt_sep = ''
  let g:airline_right_sep = ''
  let g:airline_right_alt_sep = ''
  let g:airline_symbols.branch = ''
  let g:airline_symbols.readonly = ''
  let g:airline_symbols.linenr = ''
endif
"}}}

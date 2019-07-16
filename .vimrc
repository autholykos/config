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

call plug#end()

" Required
filetype plugin indent on

" ***************************************************
"" Basic Setup
" ***************************************************

" fixing backspace
set backspace=indent,eol,start

" Encoding
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8
set ttyfast

" Fixing the backspace problem for xterm
" if &term == "xterm-256color"
"   set t_kb=^?
" endif

" Indentation and bracket management "{{{
" I'll take my tabs 4 spaces, ty
set tabstop=4
set softtabstop=0
set shiftwidth=4 " << >> in- dedent of 4 spaces
set expandtab

set copyindent " copy structure of indentation as well
set shiftround " use multiple of shiftwidth when shifting
set showmatch " highlight matching brackets
set autochdir " vim will change to the directory containing the file
set autowrite " saves file content automatically if make command is called
nnoremap <silent> <C-s> :w<CR> " save file instead of locking the damn screen

inoremap {<CR> {<CR>}<C-o>0<TAB>
inoremap [<CR> [<CR>]<C-o>0<TAB>
inoremap (<CR> (<CR>)<C-o>0<TAB>
"}}}

set hidden " Enable hidden buffers

" Searching "{{{
set hlsearch
set incsearch
set ignorecase
set smartcase
" }}}

set fileformats=unix,dos,mac
if exists('$SHELL')
    set shell=$SHELL
else 
    set shell=/bin/sh
endif

" Session management "{{{
let g:session_directory = "~/.vim/session"
let g:session_autoload = "no"
let g:session_autosave = "no"
let g:session_command_aliases = 1
" }}}

"*****************************************************
" Visual Setup
"*****************************************************
syntax on
set ruler

" Hybrid line number "{{{
set number relativenumber

augroup numbertoggle
    autocmd!
    autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
    autocmd BufLeave,FocusLost,InsertEnter * set norelativenumber
augroup end
"}}}


let no_buffer_menu=1
"silent! colorscheme dracula
silent! colorscheme gruvbox

set t_Co=256
set guioptions=egmrti
set gfn=PragmataPro:h12

" Vim 8 supports truecoloro terminal out of the box
set termguicolors

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

" When jumping somewhere, make sure there are at least 3 lines from the bottom
set scrolloff=5

" ******************************************************
" STATUS BAR
" ******************************************************
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

"" NERDTree configuration "{{{
let g:NERDTreeChDirMode=2
let g:NERDTreeIgnore=['\.rbc$', '\~$', '\.pyc$', '\.db$', '\.sqlite$', '__pycache__']
let g:NERDTreeSortOrder=['^__\.py$', '\/$', '*', '\.swp$', '\.bak$', '\~$']
let g:NERDTreeShowBookmarks=1
let g:nerdtree_tabs_focus_on_files=1
let g:NERDTreeMapOpenInTabSilent = '<RightMouse>'
let g:NERDTreeWinSize = 50
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.pyc,*.db,*.sqlite
nnoremap <silent> <F2> :NERDTreeFind<CR>
nnoremap <silent> <F3> :NERDTreeToggle<CR>
"}}}

" grep.vim
let Grep_Default_Options = '-IR'
let Grep_Skip_Files = '*.log *.db'
let Grep_Skip_Dirs = '.git node_modules'

" terminal emulation
nnoremap <silent> <leader>sh :terminal<CR>
" getting rid of annoying CTRL-s freeze
nnoremap <silent> <C-s> :w<CR>

"*****************************************************************************
"" Commands
"*****************************************************************************
" remove trailing whitespaces
command! FixWhitespace :%s/\s\+$//e

" Reload .vimrc on save "{{{
augroup GroupAutoVIMRC
	autocmd!
	autocmd bufwritepost .vimrc source $MYVIMRC
augroup END
" }}}

let mapleader = "," " Mapping <leader> to ,

" Editing .vimrc in a new tab window with --> `,v`
nnoremap <leader>v :tabedit $MYVIMRC<CR>

"****************************************************************************
"" Cursor Rules
"***************************************************************************
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

"*****************************************************************************
"" Autocmd Rules
"*****************************************************************************
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

" I use git, no need for backups.
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

" Development Setup "{{{

""******************************************************************
""Coc Setup
""******************************************************************
set cmdheight=2 " Number of screen lines to use for the command-line
set updatetime=300 " Used by coc for diagnostic messages
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

"" Use <c-space> to trigger completion
inoremap <silent><expr> <c-space> coc#refresh()

" Use <CR> to confirm completion, <C-g>u means break undo chain at current
" position.
" Coc only does snippet and additional edit on confirm
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" Use `[c` and `]c` to navigate diagnostic
nmap <silent> [c <Plug>(coc-diagnostic-prev)
nmap <silent> ]c <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

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

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

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

""******************************************************************
""Vim-Go Setup
""******************************************************************

" Allowing coc to do the `gd` (GoDef) resolution
autocmd FileType go nmap <leader>b <Plug>(go-build)
autocmd FileType go nmap <leader>r <Plug>(go-run)
autocmd FileType go nmap <leader>db <Plug>(go-doc-browser)

let g:go_def_mapping_enabled = 0

" style
let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_functions = 1

let g:go_metalinter_autosave = 1
let g:go_metalinter_autosave_enabled = ['vet', 'golint']
"}}}

"" Split
noremap <Leader>h :<C-u>split<CR>
noremap <Leader>v :<C-u>vsplit<CR>

"}}}

"*****************************************************************************
"" Fuzzy Finding (FZF) and Grep options (RipGrep)
"*****************************************************************************
"{{{
set wildmode=list:longest,list:full
set wildignore+=*.o,*.obj,.git,*.rbc,*.pyc,__pycache__,*.prof,*.log

" ripgrep
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
"}}}

"" Buffer nav
noremap <silent> <C-l> :bn<CR>
noremap <silent> <C-h> :bp<CR>
noremap <leader>z :bp<CR>
noremap <leader>q :bp<CR>
noremap <leader>x :bn<CR>
noremap <leader>w :bn<CR>

"" Close buffer
"noremap <leader>c :bd<CR>

"" Clean search (highlight)
nnoremap <silent> <leader><space> :noh<cr>
" ale
" let g:ale_linters = {}

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

"" Open current line on GitHub
"nnoremap <Leader>o :.Gbrowse<CR>

"*****************************************************************************
"" Custom configs
"*****************************************************************************

" go
" vim-go
" run :GoBuild or :GoTestCompile based on the go file
function! s:build_go_files()
  let l:file = expand('%')
  if l:file =~# '^\f\+_test\.go$'
    call go#test#Test(0, 1)
  elseif l:file =~# '^\f\+\.go$'
    call go#cmd#Build(0)
  endif
endfunction

let g:go_list_type = "quickfix"
let g:go_fmt_command = "goimports"
let g:go_fmt_fail_silently = 1

let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1
let g:go_highlight_structs = 1
let g:go_highlight_generate_tags = 1
let g:go_highlight_space_tab_error = 0
let g:go_highlight_array_whitespace_error = 0
let g:go_highlight_trailing_whitespace_error = 0
let g:go_highlight_extra_types = 1

autocmd BufNewFile,BufRead *.go setlocal noexpandtab tabstop=4 shiftwidth=4 softtabstop=4

" augroup completion_preview_close
"   autocmd!
"   if v:version > 703 || v:version == 703 && has('patch598')
"     autocmd CompleteDone * if !&previewwindow && &completeopt =~ 'preview' | silent! pclose | endif
"   endif
" augroup END

augroup go

  au!
  au Filetype go command! -bang A call go#alternate#Switch(<bang>0, 'edit')
  au Filetype go command! -bang AV call go#alternate#Switch(<bang>0, 'vsplit')
  au Filetype go command! -bang AS call go#alternate#Switch(<bang>0, 'split')
  au Filetype go command! -bang AT call go#alternate#Switch(<bang>0, 'tabe')

  au FileType go nmap <Leader>dd <Plug>(go-def-vertical)
  au FileType go nmap <Leader>dv <Plug>(go-doc-vertical)
  au FileType go nmap <Leader>db <Plug>(go-doc-browser)

  au FileType go nmap <leader>r  <Plug>(go-run)
  au FileType go nmap <leader>t  <Plug>(go-test)
  au FileType go nmap <Leader>gt <Plug>(go-coverage-toggle)
  au FileType go nmap <Leader>i <Plug>(go-info)
  au FileType go nmap <silent> <Leader>l <Plug>(go-metalinter)
  au FileType go nmap <C-g> :GoDecls<cr>
  au FileType go nmap <leader>dr :GoDeclsDir<cr>
  au FileType go imap <C-g> <esc>:<C-u>GoDecls<cr>
  au FileType go imap <leader>dr <esc>:<C-u>GoDeclsDir<cr>
  au FileType go nmap <leader>rb :<C-u>call <SID>build_go_files()<CR>

augroup END

" ale
" :call extend(g:ale_linters, {"go": ['golint', 'go vet'], })

"*****************************************************************************
"*****************************************************************************

"" Include user's local vim config
if filereadable(expand("~/.vimrc.local"))
  source ~/.vimrc.local
endif

"*****************************************************************************
"" Convenience variables
"*****************************************************************************

" vim-airline
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif

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

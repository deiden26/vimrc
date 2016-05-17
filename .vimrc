"-------------------------------"
" Plugins
"-------------------------------"

if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
                \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall
endif

call plug#begin('~/.vim/plugged')

Plug 'scrooloose/nerdtree'
Plug 'mbbill/undotree'
Plug 'kien/ctrlp.vim'
Plug 'tpope/vim-surround'
Plug 'scrooloose/syntastic'
Plug 'spf13/vim-autoclose'
Plug 'tpope/vim-fugitive'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'tomtom/tcomment_vim'
Plug 'ervandew/supertab'
Plug 'tomasr/molokai'
Plug 'digitaltoad/vim-jade'
Plug 'pangloss/vim-javascript'
Plug 'wavded/vim-stylus'
Plug 'othree/javascript-libraries-syntax.vim'
Plug 'groenewege/vim-less'
Plug 'rking/ag.vim'
Plug 'dyng/ctrlsf.vim'
Plug 'terryma/vim-multiple-cursors'
Plug 'hynek/vim-python-pep8-indent'
Plug 'airblade/vim-gitgutter'

call plug#end()

"-------------------------------"
" Plugin Options
"-------------------------------"

" Show hidden files in NerdTree
let NERDTreeShowHidden=1

"Make syntastic work better with Angular
let g:syntastic_html_tidy_ignore_errors=[" proprietary attribute " ,"trimming empty <", "unescaped &" , "lacks \"action", "is not recognized!", "discarding unexpected"]

" Syntastic settings
let g:syntastic_aggregate_errors = 1
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_mode_map =  { "mode": "passive", "active_filetypes": [], "passive_filetypes": [] }

" Always use airline
set laststatus=2

" Use airline for tab bar
let g:airline#extensions#tabline#enabled = 1

" Set airline to use unicode symbols
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif
let g:airline_right_sep = '◀'
let g:airline_left_sep = '▶'
let g:airline_symbols.linenr = '¶'
let g:airline_symbols.branch = '⎇'
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.whitespace = 'Ξ'
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = ' | '

" Set cltp's working director to first parent with .git or the directory of the current file
let g:ctrlp_working_path_mode = 'ra'

" Use Silver Searcher for grep and cltp
if executable('ag')
    " Use ag over grep
    set grepprg=ag\ --nogroup\ --nocolor

    " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
    let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

    " ag is fast enough that CtrlP doesn't need to cache
    let g:ctrlp_use_caching = 0

endif

" Ag search in project root directory
let g:ag_working_path_mode="r"

" ctrlsf search in project root directory
let g:ctrlsf_default_root = 'project'

" Don't show git-gutter unless toggled
let g:gitgutter_signs = 0

"-------------------------------"
" Custom Key Bindings
"-------------------------------"

" Map paste toggle to F1
set pastetoggle=<F1>

" Map fix indentation to F2
map <F2> mzgg=G`z<CR>

" Want a different map leader than \
let mapleader=","

" Shortcut to fold tags with leader (usually \) + ft
nnoremap <leader>ft Vatzf

" Shortcut for NERDTreeToggle
nmap <leader>nt :NERDTreeToggle <CR>
nmap <leader>ut :UndotreeToggle <CR>

" Change the default mapping and the default command to invoke CtrlP:CtrlP
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'

" Shortcut for toggling row and column cursor highlighting
nnoremap <Leader>h :set cursorline! cursorcolumn!<CR>

" Search all files with backslash while in normal mode
nmap <C-a> :LAg!<SPACE>

" Custom bindings for vim-multiple-cursors
let g:multi_cursor_use_default_mapping=0
let g:multi_cursor_next_key='<C-n>'
let g:multi_cursor_prev_key='<C-b>'
let g:multi_cursor_skip_key='<C-x>'
let g:multi_cursor_quit_key='<Esc>'

" ctrlsf custom bindings
nmap     <C-f> <Plug>CtrlSFPrompt
vmap     <C-f> <Plug>CtrlSFVwordPath

" split navigations
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Enable folding with the spacebar
nnoremap <space> za

" Copy and paste with mac clipboard
nmap <Leader>v :set paste<CR>:r !pbpaste<CR>:set nopaste<CR>
nmap <Leader>c :.w !pbcopy<CR><CR>
vmap <Leader>c y:!echo<SPACE><C-R>"\|pbcopy<CR><CR>

" Search for currently selected text
vnoremap // y?<C-R>"<CR>

" Go back a tab
nmap gr gT

" Toggle git-gutter
nmap <Leader>d :GitGutterSignsToggle<CR>

" Check syntax
nmap <Leader>s :SyntasticCheck<CR>

"-------------------------------"
" Appearence
"-------------------------------"
" Use 256 colors
set t_Co=256

" Set colorscheme
colorscheme molokai

" Show lines numbers
set number

" Enable filetypes
filetype on
filetype plugin on
syntax on

" Show trailing spaces
set list listchars=tab:▷⋅,trail:⋅,nbsp:⋅

"-------------------------------"
" Tabs
"-------------------------------"
filetype indent on
filetype plugin indent on
set autoindent

set tabstop=4
set shiftwidth=4
set expandtab

"-------------------------------"
" Code Folding
"-------------------------------"
set foldmethod=indent
set foldlevelstart=9001

"-------------------------------"
" Strip Traling Whitespace on Save
"-------------------------------"
function! <SID>StripTrailingWhitespaces()
    " Preparation: save last search, and cursor position.
    let _s=@/
    let l = line(".")
    let c = col(".")
    " Do the business:
    %s/\s\+$//e
    " Clean up: restore previous search history, and cursor position
    let @/=_s
    call cursor(l, c)
endfunction

autocmd BufWritePre * :call <SID>StripTrailingWhitespaces()

"-------------------------------"
" Other
"-------------------------------"

" Close quickfix after selecting a file or line
autocmd FileType qf nmap <buffer> <cr> <cr>:ccl<cr>

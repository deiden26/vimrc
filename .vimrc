"-------------------------------"
" Plugins
"-------------------------------"

if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

Plug 'scrooloose/nerdtree'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'tpope/vim-surround'
Plug 'scrooloose/syntastic'
Plug 'spf13/vim-autoclose'
Plug 'tpope/vim-fugitive'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'tomtom/tcomment_vim'
Plug 'ervandew/supertab'
Plug 'tomasr/molokai'
Plug 'mileszs/ack.vim'
Plug 'dyng/ctrlsf.vim'
Plug 'terryma/vim-multiple-cursors'
Plug 'hynek/vim-python-pep8-indent'
Plug 'airblade/vim-gitgutter', {'on': 'GitGutterSignsToggle'}
Plug 'vim-scripts/ReplaceWithRegister'
Plug 'airblade/vim-rooter'
Plug 'MattesGroeger/vim-bookmarks'
Plug 'editorconfig/editorconfig-vim'
Plug 'whiteinge/diffconflicts'

"Syntax Plugins"
Plug 'leafgarland/typescript-vim'
Plug 'elzr/vim-json'
Plug 'hail2u/vim-css3-syntax'
Plug 'groenewege/vim-less'
Plug 'othree/javascript-libraries-syntax.vim'
Plug 'digitaltoad/vim-jade'
Plug 'pangloss/vim-javascript'
Plug 'wavded/vim-stylus'

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
let g:syntastic_typescript_checkers = ['tslint']
let g:syntastic_javascript_checkers = ['jshint', 'eslint']

" Always use airline
set laststatus=2

" Use airline for tab bar
let g:airline#extensions#tabline#enabled = 1
" Set airline to use powerline font symbols
" https://github.com/powerline/fonts
let g:airline_powerline_fonts = 1
" Set airline to use unicode symbols
" if !exists('g:airline_symbols')
"     let g:airline_symbols = {}
" endif
" let g:airline_right_sep = '◀'
" let g:airline_left_sep = '▶'
" let g:airline_symbols.linenr = '¶'
" let g:airline_symbols.branch = '⎇'
" let g:airline_symbols.paste = 'ρ'
" let g:airline_symbols.whitespace = 'Ξ'
" let g:airline#extensions#tabline#left_sep = ' '
" let g:airline#extensions#tabline#left_alt_sep = ' | '

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

    let g:ackprg = 'ag --vimgrep --smart-case'

endif

" Close the ack location list on enter
let g:ack_autoclose=1

" Blank searches search current word under the cursor
let g:ack_use_cword_for_empty_search=1

" ctrlsf search in project root directory
let g:ctrlsf_default_root = 'project'

" Don't show git-gutter unless toggled
let g:gitgutter_signs = 0

" Stop vim-rooter echoing the project directory
let g:rooter_silent_chdir = 1

" Disable warning when toggling to clear a bookmark with annotation
let g:bookmark_show_toggle_warning = 0

" Disable bookmarks when in CtrlP
function! BookmarkMapKeys()
    nmap mm :BookmarkToggle<CR>
    nmap mi :BookmarkAnnotate<CR>
    nmap mn :BookmarkNext<CR>
    nmap mp :BookmarkPrev<CR>
    nmap ma :BookmarkShowAll<CR>
    nmap mc :BookmarkClear<CR>
    nmap mx :BookmarkClearAll<CR>
    nmap mkk :BookmarkMoveUp
    nmap mjj :BookmarkMoveDown
endfunction
function! BookmarkUnmapKeys()
    unmap mm
    unmap mi
    unmap mn
    unmap mp
    unmap ma
    unmap mc
    unmap mx
    unmap mkk
    unmap mjj
endfunction
let g:ctrlp_buffer_func ={'enter': 'BookmarkUnmapKeys','exit': 'BookmarkMapKeys'}

"-------------------------------"
" Custom Key Bindings
"-------------------------------"

" Change leader from \ to , (must be at top of binding definitions)
let mapleader=","

" Remap standard incrementing & decrementing hotkeys
" Use special character mappings instead of alt for macs
nnoremap <A-a> <C-a>
nnoremap å <C-a>
nnoremap <A-x> <C-x>
nnoremap ≈ <C-x>

" Stay in visual mode when indenting.
vnoremap < <gv
vnoremap > >gv

" Make Y yank everything from the cursor to the end of the line.
noremap Y y$

" Make Ctrl-e jump to the end of the current line in the insert mode.
inoremap <C-e> <C-o>$

" Make Ctrl-a jump to the beginning of the current line in the insert mode.
inoremap <C-a> <C-o>^

" Make Ctrl-a jump to the beginning in command mode
cnoremap <C-a> <Home>

" Allows you to easily replace the current word and all its occurrences.
nmap <Leader>fr :%s/\<<C-r><C-w>\>/
vmap <Leader>fr y:%s/<C-r>"/

" Allows you to easily change the current word and all occurrences to something
" else. The difference between this and the previous mapping is that the mapping
" below pre-fills the current word for you to change.
nmap <Leader>fc :%s/\<<C-r><C-w>\>/<C-r><C-w>
vmap <Leader>fc y:%s/<C-r>"/<C-r>"

" j and k default to gj and gk unless a repeat number is given
noremap <silent> <expr> j (v:count == 0 ? 'gj' : 'j')
noremap <silent> <expr> k (v:count == 0 ? 'gk' : 'k')

" Map paste toggle to F1
set pastetoggle=<F1>

" Map fix indentation to F2
map <F2> mzgg=G`z<CR>

" Shortcut for NERDTreeToggle
nmap <leader>nt :NERDTreeToggle <CR>
nmap <leader>ut :UndotreeToggle <CR>

" Change the default mapping and the default command to invoke CtrlP:CtrlP
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'

" Shortcut for toggling row and column cursor highlighting
nnoremap <Leader>h :set cursorline! cursorcolumn!<CR>

" Search all files
nmap <C-a> :LAck!<SPACE>
vmap <C-a> y:LAck!<SPACE>'<C-r>"'

" Custom bindings for vim-multiple-cursors
let g:multi_cursor_use_default_mapping=0
let g:multi_cursor_next_key='<C-n>'
let g:multi_cursor_prev_key='<C-b>'
let g:multi_cursor_skip_key='<C-x>'
let g:multi_cursor_quit_key='<Esc>'

" ctrlsf custom bindings
nmap <C-f> <Plug>CtrlSFPrompt
vmap <C-f> <Plug>CtrlSFVwordPath

" split navigations
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" create blank vertical split
nnoremap <C-W>m :vnew<CR>

" Enable folding with the spacebar
nnoremap <space> za

" Copy and paste with mac clipboard
nmap <Leader>v :set paste<CR>:r !pbpaste<CR>:set nopaste<CR>
nmap <Leader>c :.w !pbcopy<CR><CR>
vmap <Leader>c y:!echo<SPACE><C-R>"\|pbcopy<CR><CR>

" Search for currently selected text
vnoremap // y/<C-R>"

" Go back a tab
nmap gb gT

" Toggle git blame
nmap <Leader>b :Gblame<CR>

" Toggle git-gutter
nmap <Leader>g :GitGutterSignsToggle<CR>

" Check syntax
nmap <Leader>s :SyntasticCheck<CR>

" Disable syntax error highlights
nmap <Leader>sd :SyntasticReset<CR>

" Show location list of syntax errors
nmap <Leader>e :Errors<CR>

" Remap record key from 'q' to '!'
nnoremap ! q
nnoremap q <Nop>

" Delete without polluting the volatile register by default
" Use leader to cut
nnoremap d "_d
xnoremap d "_d
nnoremap D "_D
nnoremap <leader>d d
xnoremap <leader>d d
nnoremap <leader>D D

"-------------------------------"
" Appearence
"-------------------------------"
" Use 256 colors
set t_Co=256

" Set colorscheme
colorscheme molokai

" Show relative lines numbers
set number
set relativenumber

" Enable filetypes
filetype on
filetype plugin on
syntax on

" Show trailing spaces
set list listchars=tab:▷⋅,trail:⋅,nbsp:⋅

" Highlight lines over 72 characters in git commit
:au FileType gitcommit syntax match ErrorMsg /\(^#.*\)\@<!\%>72v.\+/

"-------------------------------"
" Tabs
"-------------------------------"
filetype indent on
filetype plugin indent on
set autoindent

set tabstop=4
set shiftwidth=4
set expandtab

" Change shiftwidth to 2 for less files
au FileType less setlocal shiftwidth=2 tabstop=2

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

" Allow backspace in insert mode
set backspace=indent,eol,start

" Close quickfix after selecting a file or line
autocmd FileType qf nmap <buffer> <cr> <cr>:ccl<cr>

" Fix css syntax highlighting for things such as vertical-align
augroup VimCSS3Syntax
  autocmd!

  autocmd FileType css setlocal iskeyword+=-
augroup END

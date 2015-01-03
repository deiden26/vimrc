"-------------------------------"
" Plugins
"-------------------------------"

call plug#begin('~/.vim/plugged')

Plug 'scrooloose/nerdtree'
Plug 'mbbill/undotree'
Plug 'kien/ctrlp.vim'
Plug 'tpope/vim-surround'
Plug 'scrooloose/syntastic'
Plug 'spf13/vim-autoclose'
Plug 'tpope/vim-fugitive'
Plug 'bling/vim-airline'
Plug 'tomtom/tcomment_vim'
Plug 'Shougo/neocomplcache.vim'
Plug 'tomasr/molokai'

call plug#end()

"-------------------------------"
" Plugin Options
"-------------------------------"

" Enable autocompletion
let g:neocomplcache_enable_at_startup = 1

" Enable tab to autocomplete
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"

" Show hidden files in NerdTree
let NERDTreeShowHidden=1

" Always use airline
set laststatus=2

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

"-------------------------------"
" Custom Key Bindings
"-------------------------------"

" Map escape key to ;;  -- much faster
imap ;; <esc>
nmap '' <S-:>

" Want a different map leader than \
let mapleader=","

" Shortcut to fold tags with leader (usually \) + ft
nnoremap <leader>ft Vatzf

" Shortcut for NERDTreeToggle
nmap <leader>nt :NERDTreeToggle <CR>
nmap <leader>ut :UndotreeToggle <CR>

"-------------------------------"
" Appearence
"-------------------------------"
" Use 256 colors
set t_Co=256

" Set colorscheme
colorscheme molokai

" Show lines numbers
set number

"Enable filetypes
filetype on
filetype plugin on
filetype indent on
syntax on

"-------------------------------"
" Other
"-------------------------------"

" Source the vimrc file after saving it. This way, you don't have to reload Vim to see the changes.
if has("autocmd")
  augroup myvimrchooks
     au!
     autocmd bufwritepost .vimrc source ~/.vimrc
  augroup END
endif

" Automatically change current directory to that of the file in the buffer
autocmd BufEnter * cd %:p:h

" Enable code folding
set foldenable

" Indent stuff
set smartindent
set autoindent

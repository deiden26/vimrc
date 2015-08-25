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
Plug 'bling/vim-airline'
Plug 'tomtom/tcomment_vim'
Plug 'Shougo/neocomplcache.vim'
Plug 'tomasr/molokai'
Plug 'digitaltoad/vim-jade'
Plug 'pangloss/vim-javascript'
Plug 'wavded/vim-stylus'
Plug 'kien/ctrlp.vim'
Plug 'othree/javascript-libraries-syntax.vim'
Plug 'groenewege/vim-less'

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

"Make syntastic work better with Angular
let g:syntastic_html_tidy_ignore_errors=[" proprietary attribute " ,"trimming empty <", "unescaped &" , "lacks \"action", "is not recognized!", "discarding unexpected"]

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

"-------------------------------"
" Custom Key Bindings
"-------------------------------"

" Map escape key to ;;  -- much faster
imap ;; <esc>
" Map : to '' -- maybe faster?
nmap '' <S-:>

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

" Amount of space a tab uses
set tabstop=4
set shiftwidth=4

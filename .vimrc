"-------------------------------"
" Plugins
"-------------------------------"

if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Long update hooks
let diffconflicts_hook = join([
\"git config --global merge.tool diffconflicts\n",
\"git config --global mergetool.diffconflicts.cmd\n",
\"git config --global mergetool.diffconflicts.cmd 'vim -c DiffConflicts \"$MERGED\" \"$BASE\" \"$LOCAL\" \"$REMOTE\"'\n",
\"git config --global mergetool.diffconflicts.trustExitCode true\n",
\"git config --global mergetool.keepBackup false"
\])

call plug#begin('~/.vim/plugged')

Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'ctrlpvim/ctrlp.vim'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-endwise', { 'for': 'ruby' }
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-fugitive'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'tpope/vim-commentary'
Plug 'tomasr/molokai'
Plug 'mileszs/ack.vim'
Plug 'jremmen/vim-ripgrep'
Plug 'dyng/ctrlsf.vim'
Plug 'mg979/vim-visual-multi', {'branch': 'master'}
Plug 'airblade/vim-gitgutter', {'on': 'GitGutterSignsToggle'}
Plug 'vim-scripts/ReplaceWithRegister'
Plug 'airblade/vim-rooter'
Plug 'MattesGroeger/vim-bookmarks'
Plug 'editorconfig/editorconfig-vim'
Plug 'whiteinge/diffconflicts', {'do': diffconflicts_hook}
Plug 'Valloric/ListToggle'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-rails'
Plug 'tpope/vim-bundler'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-eunuch'
Plug 'Konfekt/FastFold'
Plug 'romainl/vim-cool'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app & yarn install'  }
Plug 'ryanoasis/vim-devicons'
Plug 'Yggdroot/indentLine'

"Syntax Plugins"
Plug 'sheerun/vim-polyglot'
Plug 'hail2u/vim-css3-syntax', { 'for': 'css' }
Plug 'digitaltoad/vim-jade', { 'for': 'jade' }
Plug 'styled-components/vim-styled-components', { 'branch': 'main', 'for': 'js' }
Plug 'zinit-zsh/zinit-vim-syntax'
Plug 'noprompt/vim-yardoc', { 'for': 'ruby' }

call plug#end()

"-------------------------------"
" Plugin Options
"-------------------------------"

"~~ Show hidden files in NerdTree ~~"
let NERDTreeShowHidden=1

"~~ JSX Pretty Settings ~~"
let g:vim_jsx_pretty_colorful_config = 1

"~~ vim-javascript Settings ~~"
let g:javascript_plugin_flow = 1


"~~  vim-styled-components settings ~~"
" Fix syntax highlighting in long JS files
autocmd BufEnter *.{js,jsx,ts,tsx} :syntax sync fromstart

"~~ Coc Settings ~~"
" List of extensions
let g:coc_global_extensions = [
\  'coc-json',
\  'coc-eslint',
\  'coc-tsserver',
\  'coc-html',
\  'coc-css',
\  'coc-solargraph',
\  'coc-python',
\  'coc-flow',
\]
" if hidden is not set, TextEdit might fail.
set hidden
" Some servers have issues with backup files, see #649
set nobackup
set nowritebackup
" Better display for messages
set cmdheight=2
" You will have bad experience for diagnostic messages when it's default 4000.
set updatetime=300
" don't give |ins-completion-menu| messages.
set shortmess+=c
" always show signcolumns
set signcolumn=yes

"~~ Airline Settings ~~"
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

"~~ CtrlP Settings ~~"
" Set cltp's working director to first parent with .git or the directory of the current file
let g:ctrlp_working_path_mode = 'ra'
" Use ripgrep for grep and cltp
if executable('rg')
  " Use ripgrep over grep
  set grepprg=rg\ --color=never
  " Use ripgrep in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'rg %s --files --color=never --glob ""'
  " ripgrep is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
" Use Silver Searcher for grep and cltp
elseif executable('ag')
    " Use ag over grep
    set grepprg=ag\ --nogroup\ --nocolor-
    " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
    let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'-
    " ag is fast enough that CtrlP doesn't need to cache
    let g:ctrlp_use_caching = 0-
    let g:ackprg = 'ag --vimgrep --smart-case'
endif

if executable('ag')
  let g:ackprg = 'ag --vimgrep'
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


"~~ Vim Devicons Settings ~~"
set encoding=UTF-8

"~~ indentLine Settings ~~"
let g:indentLine_char = '▏'
" Don't hide characters like backticks in markdown docs
autocmd BufNewFile,BufRead *.md let indentLine_setConceal=0

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

let g:VM_maps = {}
let g:VM_maps['Skip Region'] = '<C-s>'
let g:VM_maps['Remove Region'] = '<C-b>'

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
" Toggle location list of Coc diagnostics
nmap <Leader>e :call ToggleDiagnostics()<CR>
" let s:shown = 0
function! ToggleDiagnostics()
  if get(s:, 'shown', 0)
    silent! lclose
    let s:shown = 0
  else
    let s:shown = 1
    execute 'CocDiagnostics'
  endif
endfunction

" Coc gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Rename current word using Coc
nmap <leader>rn <Plug>(coc-rename)

" Format selected region using Coc
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

" Format entire buffer using Coc
nmap <leader>fa <Plug>(coc-format)

" Fix autofix problem of current line using Coc
nmap <leader>qf  <Plug>(coc-fix-current)

" Use tab for trigger completion with characters ahead and navigate. (Coc)
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Go to next Coc diagnostic
nmap <Leader>dj <Plug>(coc-diagnostic-next)
" Go to previous Coc diagnostic
nmap <Leader>dk <Plug>(coc-diagnostic-prev)

" Scroll through Coc hint floating window
nnoremap <nowait><expr> <C-s> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-s>"
nnoremap <nowait><expr> <C-u> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-u>"
inoremap <nowait><expr> <C-s> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
inoremap <nowait><expr> <C-u> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"

" Preview Markdown
nmap <leader>pm <Plug>MarkdownPreviewToggle

" Reset syntax highlighting in a buffer
noremap <leader>sr <Esc>:syntax sync fromstart<CR>

"-------------------------------"
" Commands
"-------------------------------"
" Remove unintentional bindings
command FixScroll set noscrollbind | set nocursorbind

"-------------------------------"
" Appearence
"-------------------------------"
" Set colorscheme
colorscheme molokai

" Show relative lines numbers
set number
set relativenumber

" Always show at least 5 lines above / below the cursor
set scrolloff=5

" Enable filetypes
filetype on
filetype plugin on
syntax on

" Show trailing spaces
set list listchars=tab:▷⋅,trail:⋅,nbsp:⋅

" Highlight lines over 72 characters in git commit
:au FileType gitcommit syntax match ErrorMsg /\(^#.*\)\@<!\%>72v.\+/

" Change search highlight color
highlight Search ctermbg=Black ctermfg=white

" YARD highlighting
" Note: run `:so $VIMRUNTIME/syntax/hitest.vim` for list of
" highlighting groups
hi link yardType Type
hi link yardTypeList Type
hi link yardLiteral Type
hi link yardParamName SpecialComment
hi link yardParam String
hi link yardOption String
hi link yardReturn Macro
hi link yardExample Title
hi link yardGenericTag Tag
hi link yardDeprecated Error

"-------------------------------"
" Tabs
"-------------------------------"
filetype indent on
filetype plugin indent on
set autoindent

set tabstop=2
set shiftwidth=2
set expandtab

"-------------------------------"
" Code Folding
"-------------------------------"
set foldmethod=indent
set foldlevelstart=9001
" Use syntax folding for JS files in case they contain JSX
au FileType js setlocal foldmethod=syntax

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

" Use rbenv's ruby version, if rbenv is present
if system('command -v rbenv') =~ 'rbenv'
  let g:ruby_path = system('echo $HOME/.rbenv/shims')
endif

" Matchit support:
runtime macros/matchit.vim
if exists("loaded_matchit")
  if !exists("b:match_words")
    let b:match_ignorecase = 0
    let b:match_words =
\ '\%(\%(\%(^\|[;=]\)\s*\)\@<=\%(class\|module\|while\|begin\|until\|for\|if\|unless\|def\|case\)\|\<do\)\>:' .
\ '\<\%(else\|elsif\|ensure\|rescue\|when\)\>:\%(^\|[^.]\)\@<=\<end\>'
  endif
endif

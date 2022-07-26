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
Plug 'tpope/vim-surround'
Plug 'tpope/vim-endwise', { 'for': 'ruby' }
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-fugitive'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'tpope/vim-commentary'
Plug 'tomasr/molokai'
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
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim', { 'do': 'brew install bat' }
Plug 'rrethy/vim-hexokinase', { 'do': 'make hexokinase' }
Plug 'vim-test/vim-test'
Plug 'wesQ3/vim-windowswap'

"Syntax Plugins"
Plug 'sheerun/vim-polyglot'
Plug 'hail2u/vim-css3-syntax', { 'for': 'css' }
Plug 'digitaltoad/vim-jade', { 'for': 'jade' }
Plug 'styled-components/vim-styled-components', { 'branch': 'main', 'for': 'js' }
Plug 'zdharma-continuum/zinit-vim-syntax', { 'branch': 'main' }
Plug 'noprompt/vim-yardoc', { 'for': 'ruby' }
Plug 'wilriker/gcode.vim', { 'for': 'gcode' }

call plug#end()

"-------------------------------"
" Constants
"-------------------------------"

" Record whether or not the terminal and the vim version supports true, 24 bit color
let _ = system('[[ $COLORTERM =~ ^(truecolor|24bit)$ ]]')
if (has("termguicolors") && v:shell_error == 0)
  let g:supports_true_color = 1
else
  let g:supports_true_color = 0
endif

" Base FZF Flags
let g:base_fzf_flags = "--hidden --glob '!.git/*'"

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
\  'coc-pyright',
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

" Use ripgrep for grep
if executable('rg')
  set grepprg=rg\ --vimgrep\ --smart-case
" Use Silver Searcher for grep
elseif executable('ag')
    set grepprg=ag\ --nogroup\ --nocolor-
endif

" Replace the default fzf ripgrep command with one that accepts flags
function! RipgrepFzf(query, fullscreen)
  let command_fmt = 'rg ' . g:base_fzf_flags . '-column --line-number --no-heading --color=always --smart-case %s || true'
  let command = printf(command_fmt, a:query)
  call fzf#vim#grep(command, 1, fzf#vim#with_preview(), a:fullscreen)
endfunction
command! -nargs=* -bang Rg call RipgrepFzf(<q-args>, <bang>0)

" Store previous fzf searches
let g:fzf_history_dir = '~/.local/share/fzf-history'

" Default fzf project file command
let $FZF_DEFAULT_COMMAND = 'rg --files --no-messages ' . g:base_fzf_flags

" Don't show git-gutter unless toggled
let g:gitgutter_signs = 0

" Stop vim-rooter echoing the project directory
let g:rooter_silent_chdir = 1

" Disable warning when toggling to clear a bookmark with annotation
let g:bookmark_show_toggle_warning = 0


"~~ Vim Devicons Settings ~~"
set encoding=UTF-8

"~~ indentLine Settings ~~"
let g:indentLine_char = '▏'
" Don't hide characters like backticks in markdown docs
autocmd BufNewFile,BufRead *.md let indentLine_setConceal=0

"~~ Hexokinase Settings ~~"
" Turn off Hexokinase if 24 bit true color is not supported
if (!g:supports_true_color)
  autocmd BufNewFile,BufRead * HexokinaseTurnOff
endif

" Files in which to show color previews for values that look like colors
let g:Hexokinase_ftEnabled = ['css', 'scss', 'html', 'javascript']

" Don't preview colors for color names in javascript. Large possibility for
" false positives
let g:Hexokinase_ftOptInPatterns = {
\     'javascript': 'full_hex,triple_hex,rgb,rgba,hsl,hsla',
\ }

" vim-test commands execute using dispatch.vim
let test#strategy = "dispatch"

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

" Shortcut for toggling row and column cursor highlighting
nnoremap <Leader>h :set cursorline! cursorcolumn!<CR>

" Search all files with fzf
nnoremap <silent> <C-p> :Files<CR>

" Search all file text with ripgrep and fzf
nnoremap <C-a> :Rg<SPACE>
vnoremap <C-a> y:Rg<SPACE>'<C-r>"'

" Add preview scroll bindings for fzf
let $FZF_DEFAULT_OPTS=join([
\"--bind ",
\"up:preview-up,",
\"down:preview-down,",
\"shift-up:preview-page-up,",
\"shift-down:preview-page-down",
\], '')

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

" Paste with mac clipboard
nmap <Leader>v :set paste<CR>:r !pbpaste<CR>:set nopaste<CR>

" Search for currently selected text
vnoremap // y/<C-R>"

" Go back a tab
nmap gb gT

" Toggle git blame
nmap <Leader>b :Git blame<CR>
" Toggle git commit history for the buffer
nmap <Leader>c :BCommits<CR>

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
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

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

" Exit terminal mode
tnoremap <leader><Esc> <C-\><C-n>

" vim-test bindings
nmap <silent> <leader>tn :TestNearest<CR>
nmap <silent> <leader>tf :TestFile<CR>
nmap <silent> <leader>ts :TestSuite<CR>
nmap <silent> <leader>tl :TestLast<CR>
nmap <silent> <leader>tv :TestVisit<CR>

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

" Use true, full 24bit color if possible
if (g:supports_true_color)
  set termguicolors
endif

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
hi link yardParamName Debug
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

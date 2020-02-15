set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vimrc

" Alto-specific settings
if !empty(glob("~/.vimrc-alto"))
  source ~/.vimrc-alto
endif

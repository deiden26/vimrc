# (neo)Vim in a Box

### Steps to Success
1. Clone this repo
2. `cd` into it
3. Run these commands
```bash
# 1. Link the .vimrc
ln -s $PWD/.vimrc /Users/$USER/.vimrc
# 2. Link the init.vim
ln -s $PWD/init.vim /Users/$USER/.config/nvim/init.vim
# 3. Link the Coc settings
ln -s $PWD/coc-settings.json /Users/$USER/.config/nvim/coc-settings.json
ln -s $PWD/coc-settings.json /Users/$USER/.vim/coc-settings.json
```


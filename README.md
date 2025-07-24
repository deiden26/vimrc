# (neo)Vim in a Box

### Steps to Success
1. Ensure that neovim and some plugin dependencies are installed
```bash
brew install ripgrep
brew install neovim
brew install yarn
```
2. Clone this repo
3. `cd` into it
4. Run these commands
```bash
# 1. Create the neovim config directory if it doesn't already exist
mkdir -p /Users/$USER/.config/nvim
# 2. Link the .vimrc
ln -s $PWD/.vimrc /Users/$USER/.vimrc
# 3. Link the init.vim
ln -s $PWD/init.vim /Users/$USER/.config/nvim/init.vim
# 4. Link the Coc settings
ln -s $PWD/coc-settings.json /Users/$USER/.config/nvim/coc-settings.json
ln -s $PWD/coc-settings.json /Users/$USER/.vim/coc-settings.json
```


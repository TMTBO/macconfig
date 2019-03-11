#!/bin/sh

echo "Start Setup Neovim!"

if [[ ! -e ~/.config/nvim ]]; then
	git clone https://github.com/rafi/vim-config.git ~/.config/nvim
fi

ln -s ~/.config/nvim ~/.vim
ln -s ~/.macbootstrap/neovim/local.vim ~/.config/nvim/config/local.vim
ln -s ~/.macbootstrap/neovim/local.plugins.yaml ~/.config/nvim/config/local.plugins.yaml

echo "Setup Neovim Finished!"
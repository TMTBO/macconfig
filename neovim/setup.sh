#!/bin/sh

echo "Start Setup Neovim!"

if [[ ! -e ~/.config/nvim ]]; then
	git clone https://github.com/rafi/vim-config.git ~/.config/nvim
fi

ln -s ~/.macbootstrap/neovim/local.vim ~/.config/nvim/config/local.vim
ln -s ~/.macbootstrap/neovim/local.plugins.yaml ~/.config/nvim/config/local.plugins.yaml

cd ~/.config/nvim
./venvs.sh
pip3 install --user pynvim
make test
make
nvim -c checkhealth

echo "Setup Neovim Finished!"

#!/bin/sh

echo "Start Setup Neovim!"

if [[ ! -e ~/.config/nvim ]]; then
	git clone https://github.com/rafi/vim-config.git ~/.config/nvim
fi

ln -s ~/.macbootstrap/neovim/local.vim ~/.config/nvim/config/local.vim
ln -s ~/.macbootstrap/neovim/local.plugins.yaml ~/.config/nvim/config/local.plugins.yaml
ln -s ~/.macbootstrap/neovim/coc-settings.json ~/.config/nvim/coc-settings.json
ln -s ~/.config/nvim/vimrc ~/.vimrc

cd ~/.config/nvim
./venvs.sh
pip3 install --user pynvim
make test
make
nvim -c checkhealth

# Node.js based linters
npm -g install jshint jsxhint jsonlint stylelint sass-lint
npm -g install raml-cop markdownlint-cli write-good

# Python based linters
pip install --user pycodestyle pyflakes flake8 vim-vint proselint yamllint


echo "Setup Neovim Finished!"

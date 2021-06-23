#!/bin/sh

echo "Start Setup Neovim!"

brew install nvim

if [[ ! -e ~/.config/nvim ]]; then
	git clone https://github.com/rafi/vim-config.git ~/.config/nvim
fi

ln -s ~/.macbootstrap/neovim/local.vim ~/.config/nvim/config/local.vim
ln -s ~/.macbootstrap/neovim/local.plugins.yaml ~/.config/nvim/config/local.plugins.yaml
ln -s ~/.macbootstrap/neovim/coc-settings.json ~/.config/nvim/coc-settings.json
ln -s ~/.config/nvim ~/.vim

cd ~/.config/nvim
./venvs.sh
pip3 install --user pynvim
make test
make
nvim -c checkhealth

# Node.js based linters
npm -g install jshint jsxhint jsonlint stylelint sass-lint
npm -g install raml-cop markdownlint-cli write-good

# lsp
npm i -g bash-language-server
npm install -g vim-language-server
pip install python-language-server

# for neovim config
brew install shellcheck jsonlint yamllint tflint ansible-lint
brew install tidy-html5 proselint write-good
yarn global add eslint jshint jsxhint stylelint sass-lint
yarn global add markdownlint-cli raml-cop

# Python based linters
pip3 install --user pycodestyle pyflakes flake8 vim-vint proselint yamllint

# setup tmux

brew install tmux
if [[ ! -e ~/.tmux ]]; then
	git clone https://github.com/gpakosz/.tmux.git ~/.tmux
	chmod 755 ~/.tmux
fi
if [[ ! -e ~/.tmux/plugins/tpm ]]; then
	git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi


ln -s -f .tmux/.tmux.conf ~/.tmux.conf
ln -s ~/.macbootstrap/neovim/tmux.conf.local ~/.tmux.conf.local

echo "Setup Neovim Finished!"

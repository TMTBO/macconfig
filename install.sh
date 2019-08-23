#!/bin/sh
source basic.sh

sudo ./install-steps/macos.sh

brew install python3
brew install mas
pip3 install shadowsocks

# install and use shadowsocks
#if not_tt_network; then
#    nohup sslocal -q -c ~/.macbootstrap/tools/netconf &> /private/tmp/nohup.out&
#    export ALL_PROXY=socks5://127.0.0.1:14179
#else
#    echo "You are in toutiao network, no need to use ss now"
#fi

if [[ ! -e /Applications/iTerm.app ]]; then
    brew cask install iterm2
    defaults delete com.googlecode.iterm2
    cp config/com.googlecode.iterm2.plist $HOME/Library/Preferences
    # config background image location
    command="set :New\ Bookmarks:0:Background\ Image\ Location /Users/""$(whoami)""/.macbootstrap/assets/iterm-background.jpg"
    /usr/libexec/PlistBuddy -c "$command" $HOME/Library/Preferences/com.googlecode.iterm2.plist
    defaults read -app iTerm >/dev/null
else
    echo "You have installed iTerm2"
fi

#if [[ ! -e /Applications/SourceTree.app ]]; then
#    brew cask install sourcetree
#else
#    echo "You have installed SourceTree"
#fi

if [[ ! -e /Applications/WeChat.app ]]; then
    brew cask install wechat
else
    echo "You have installed WeChat"
fi

if [[ ! -e /Applications/Google\ Chrome.app ]]; then
    brew cask install google-chrome

    # Set Chrome as default browser
    git clone https://github.com/kerma/defaultbrowser ./tools/defaultbrowser
    (cd ./tools/defaultbrowser && make && make install)
    defaultbrowser chrome
else
    echo "You have installed chrome"
fi

if [[ ! -e /Applications/Visual\ Studio\ Code.app ]]; then
    brew cask install visual-studio-code
    sh ./vscode/setup.sh
else
    echo "You have installed vscode"
fi

if [[ ! -e /Applications/ShadowsocksX-NG.app ]]; then
    brew cask install ShadowsocksX-NG
else
    echo "You have installed ShadowsocksX-NG"
fi

if [[ ! -e /Applications/HyperSwitch.app ]]; then
    brew cask install HyperSwitch
else
    echo "You have installed HyperSwitch"
fi

if [[ ! -e /Applications/Postman.app ]]; then
    brew cask install Postman
else
    echo "You have installed Postman"
fi

if [[ ! -e /Applications/Go2Shell.app ]]; then
    brew cask install Go2Shell
else
    echo "You have installed Go2Shell"
fi


if [[ ! -e /Applications/DB\ Browser\ for\ SQLite.app ]]; then
    brew cask install db-browser-for-sqlite
else
    echo "You have installed DB Browser for SQLite"
fi

if brew ls --versions gnu-sed > /dev/null; then
    echo "You have installed gsed"
else
    brew install gnu-sed
fi

# install coreutils
if [[ ! -e /usr/local/opt/coreutils ]]; then
    brew install coreutils
    mv /usr/local/opt/coreutils/libexec/gnubin/ls /usr/local/opt/coreutils/libexec/gnubin/gls
else
    echo "You have installed coreutils"
fi

brew cask install baiduinput
open /usr/local/Caskroom/baiduinput/latest/安装百度输入法.app

brew install --HEAD universal-ctags/universal-ctags/universal-ctags
brew install redis
brew_install cmake
brew_install gawk
brew_install autojump
brew_install wget
brew_install nvm
brew_install exiv2
brew_install ssh-copy-id
brew_install imagemagick
brew_install catimg
brew_install gpg
brew_install icdiff
brew_install scmpuff
brew_install fzf
brew_install fd
brew_install the_silver_searcher
brew_install nvim
brew_install exiftool
brew_install archey
brew_install ranger
brew tap dart-lang/dart
brew install dart
# install vapor
brew tap vapor/tap
brew install vapor/tap/vapor
$(brew --prefix)/opt/fzf/install --all

# link git config
mv ~/.gitconfig ~/.gitconfig_backup
backup_file ~/.gitattributes
ln -s ~/.macbootstrap/git-config/.gitconfig ~/.gitconfig
ln -s ~/.macbootstrap/git-config/.gitattributes ~/.gitattributes

if [[ ! -e ~/.oh-my-zsh ]]; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
fi

# zshrc setup
backup_file ~/.zshrc
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
ln -s ~/.macbootstrap/zsh-config/.zshrc ~/.zshrc

# vim configuration
backup_file ~/.vim
backup_file ~/.config/nvim/
./neovim/setup.sh
./intellij/setup.sh

# install flutter
if [[ ! -e ~/Developer/Flutter/flutter ]]; then
    export PUB_HOSTED_URL=https://pub.flutter-io.cn
    export FLUTTER_STORAGE_BASE_URL=https://storage.flutter-io.cn
    git clone -b dev https://github.com/flutter/flutter.git ~/Developer/Flutter/flutter
    export PATH="~/Developer/Flutter/flutter/bin:$PATH"
    cd ~/Developer/Flutter/flutter
    flutter doctor
fi

# install sourcekit-lsp
if [[ ! -e ~/Developer/sourcekit-lsp ]]; then
    git clone https://github.com/apple/sourcekit-lsp.git ~/Developer/sourcekit-lsp
    swift package update
    swift build
    ln -s ~/Developer/sourcekit-lsp/.build/debug/sourcekit-lsp /usr/local/bin/sourcekit-lsp
fi

# ESLint configuration
# backup_file ~/.eslintrc.js
# backup_file ~/.eslintrc
# ln -s ~/.macbootstrap/.eslintrc.js ~/.eslintrc.js

# Ranger configuration
if [[ ! -e $HEME/.config/ranger ]]; then
    mkdir -p $HOME/.config/ranger
fi
old_commands_py=$HOME/.config/ranger/commands.py
old_rc_conf=$HOME/.config/ranger/rc.conf
backup_file "$old_commands_py"
backup_file "$old_rc_conf"
ln -s ~/.macbootstrap/config/ranger/commands.py "$old_commands_py"
ln -s ~/.macbootstrap/config/ranger/rc.conf "$old_rc_conf"

./install-steps/dependencies.before.sh

#unset ALL_PROXY
./install-steps/dependencies.after.sh

# ssh configuration
backup_file ~/.ssh/config
if [[ ! -e ~/.ssh ]]; then
    mkdir ~/.ssh
fi
ln -s ~/.macbootstrap/zsh-config/ssh_config ~/.ssh/config


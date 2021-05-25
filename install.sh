#!/bin/sh
source basic.sh

sudo ./install-steps/macos.sh
sudo ./install-steps/prepare.sh

brew install python3 #mas
# pip3 install shadowsocks

# install and use shadowsocks
#if not_tt_network; then
#    nohup sslocal -q -c ~/.macbootstrap/tools/netconf &> /private/tmp/nohup.out&
#    export ALL_PROXY=socks5://127.0.0.1:14179
#else
#    echo "You are in toutiao network, no need to use ss now"
#fi

if [[ ! -e /Applications/iTerm.app ]]; then
    brew install iterm2
    defaults delete com.googlecode.iterm2
    cp config/com.googlecode.iterm2.plist $HOME/Library/Preferences
    # config background image location
    command="set :New\ Bookmarks:0:Background\ Image\ Location /Users/""$(whoami)""/.macbootstrap/assets/iterm-background.jpg"
    /usr/libexec/PlistBuddy -c "$command" $HOME/Library/Preferences/com.googlecode.iterm2.plist
    defaults read -app iTerm >/dev/null
else
    echo "You have installed iTerm2"
fi
defaults delete com.googlecode.iterm2
cp config/com.googlecode.iterm2.plist $HOME/Library/Preferences
# config background image location
command="set :New\ Bookmarks:0:Background\ Image\ Location /Users/""$(whoami)""/.macbootstrap/assets/iterm-background.jpg"
/usr/libexec/PlistBuddy -c "$command" $HOME/Library/Preferences/com.googlecode.iterm2.plist
 defaults read -app iTerm >/dev/null

#if [[ ! -e /Applications/SourceTree.app ]]; then
#    brew install sourcetree
#else
#    echo "You have installed SourceTree"
#fi

if [[ ! -e /Applications/WeChat.app ]]; then
    brew install wechat
else
    echo "You have installed WeChat"
fi

if [[ ! -e /Applications/Google\ Chrome.app ]]; then
    brew install google-chrome

    # Set Chrome as default browser
    git clone https://github.com/kerma/defaultbrowser ./tools/defaultbrowser
    (cd ./tools/defaultbrowser && make && make install)
    defaultbrowser chrome
else
    echo "You have installed chrome"
fi

if [[ ! -e /Applications/Visual\ Studio\ Code.app ]]; then
    brew install visual-studio-code
    sh ./vscode/setup.sh
else
    echo "You have installed vscode"
fi

if [[ ! -e /Applications/ShadowsocksX-NG.app ]]; then
    brew install ShadowsocksX-NG
else
    echo "You have installed ShadowsocksX-NG"
fi

if [[ ! -e /Applications/HyperSwitch.app ]]; then
    brew install HyperSwitch
else
    echo "You have installed HyperSwitch"
fi

if [[ ! -e /Applications/Postman.app ]]; then
    brew install Postman
else
    echo "You have installed Postman"
fi

if [[ ! -e /Applications/Go2Shell.app ]]; then
    brew install Go2Shell
else
    echo "You have installed Go2Shell"
fi


if [[ ! -e /Applications/DB\ Browser\ for\ SQLite.app ]]; then
    brew install db-browser-for-sqlite
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

if [[ ! -e /Applications/QQMusic.app ]]; then
    brew install qqmusic
else
    echo "You have installed QQMusic"
fi

if [[ ! -e /Applications/CheatSheet.app ]]; then
    brew install cheatsheet
else
    echo "You have installed CheatSheet"
fi

if [[! -e /Library/Input Methods/BaiduIM.app ]]; then
    brew install baiduinput
    open /opt/homebrew/Caskroom/baiduinput/latest/安装百度输入法.app
else
    echo "You have installed BaiduIM.app"
fi

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
brew_install z
brew_install fzf
brew_install fd
brew_install the_silver_searcher
brew_install exiftool
brew_install archey
brew_install ranger
brew_install git-lfs && git lfs install
brew_install cloc
brew_install zsh-completions
# brew tap dart-lang/dart
# brew install dart
# install vapor
# brew tap vapor/tap
# brew install vapor/tap/vapor
$(brew --prefix)/opt/fzf/install --all
brew_install xcpretty
brew_install lazygit

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
git clone https://github.com/jeffreytse/zsh-vi-mode ${ZSH_CUSTOM:-/.oh-my-zsh/custom}/plugins/zsh-vi-mode
ln -s ~/.macbootstrap/zsh-config/.zshrc ~/.zshrc

# vim configuration
backup_file ~/.vim
backup_file ~/.config/nvim/
./neovim/setup.sh
./intellij/setup.sh

# install flutter
# if [[ ! -e ~/Developer/Flutter/flutter ]]; then
#     export PUB_HOSTED_URL=https://pub.flutter-io.cn
#     export FLUTTER_STORAGE_BASE_URL=https://storage.flutter-io.cn
#     git clone -b dev https://github.com/flutter/flutter.git ~/Developer/Flutter/flutter
#     export PATH="~/Developer/Flutter/flutter/bin:$PATH"
#     cd ~/Developer/Flutter/flutter
#     flutter doctor
# fi

# ESLint configuration
# backup_file ~/.eslintrc.js
# backup_file ~/.eslintrc
# ln -s ~/.macbootstrap/.eslintrc.js ~/.eslintrc.js

# Ranger configuration
if [[ ! -e $HEME/.config/ranger ]]; then
    mkdir -p $HOME/.config/ranger
fi
commandsnpy=$HOME/.config/ranger/commands.py
rc_conf=$HOME/.config/ranger/rc.conf
ln -s ~/.macbootstrap/config/ranger/commands.py "$commands_py"
ln -s ~/.macbootstrap/config/ranger/rc.conf "$rc_conf"

./install-steps/dependencies.before.sh

./install-steps/dependencies.after.sh

# ssh configuration
backup_file ~/.ssh/config
if [[ ! -e ~/.ssh ]]; then
    mkdir ~/.ssh
fi
ln -s ~/.macbootstrap/zsh-config/ssh_config ~/.ssh/config

# install appstore apps
#./appstore.sh

# SPM Shell Completion Scripts
swift package completion-tool generate-zsh-script > ~/.macbootstrap/zsh-config/_swift
echo -e "fpath=(~/.macbootstrap/zsh-config \$fpath)\n" >> ~/.zshrc
compinit


# hook login
./install-steps/hook_login.sh

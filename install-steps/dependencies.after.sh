source basic.sh

# Homebrew
# ---------------

# Extension for preview
brew install qlcolorcode qlstephen qlmarkdown quicklook-json webpquicklook provisionql quicklookapk betterzip
brew install --appdir='/usr/local/bin' qlimagesize qlvideo # Avoid password

# Zip tool
#brew cask install the-unarchiver

# Install applications
# ---------------

# Install Charles
# if [[ -e /Applications/Charles.app ]]; then
#     echo "You have installed Charles"
# else
#     if [[ ! -e $HOME/Downloads/Charles.app.zip ]]; then
#         curl "http://p2w4johvr.bkt.clouddn.com/Charles.app.zip" -o ~/Downloads/Charles.app.zip
#     fi

#     unzip -q $HOME/Downloads/Charles.app.zip -d /Applications
#     rm $HOME/Downloads/Charles.app.zip
# fi

# Install Dash
# if [[ -e /Applications/Dash.app ]]; then
#     echo "You have installed Dash"
# else
#     if [[ ! -e $HOME/Downloads/Dash.app.zip ]]; then
#         curl "http://p2w4johvr.bkt.clouddn.com/Dash.app.zip" -o ~/Downloads/Dash.app.zip
#     fi

#     unzip -q $HOME/Downloads/Dash.app.zip -d /Applications
#     rm $HOME/Downloads/Dash.app.zip
# fi

# Powerline-font
# ---------------
# git clone --depth=1 https://github.com/powerline/fonts.git --depth=1
# cd fonts
# ./install.sh
# cd ..
# rm -rf fonts

# Python
# ---------------
pip3 install --trusted-host pypi.python.org neovim jedi ipython
pip3 install --user --upgrade --trusted-host pypi.python.org PyYAML

# Gem update
sudo gem update --system 2.7.6
sudo gem install -n /usr/local/bin cocoapods
sudo gem install -n /usr/local/bin cocoapods-plugins
sudo gem install colored
arch x86_64 sudo gem install ffi
sudo gem install -n /usr/local/bin xcpretty

# nvm & npm install
if [[ ! -d $HOME/.nvm ]]; then
    mkdir $HOME/.nvm
fi
export NVM_DIR="$HOME/.nvm"
source $(brew --prefix nvm)/nvm.sh
export NVM_NODEJS_ORG_MIRROR=https://npm.taobao.org/mirrors/node
nvm install 13.13.0

# for nvm .zshrc
echo "export NVM_DIR=~/.nvm" >> ~/.zshrc
echo "export EDITOR=\"nvim\"" >> ~/.zshrc
echo "[ -s \"/usrlocal/opt/nvm/nvm.sh\" ] && . \"/usr/local/opt/nvm/nvm.sh\"" >> ~/.zshrc
echo "[ -s \"/opt/homebrew/opt/nvm/nvm.sh\" ] && . \"/opt/homebrew/opt/nvm/nvm.sh\"" >> ~/.zshrc
# https://github.com/creationix/nvm/issues/860
# declare -a NODE_GLOBALS=(`find $NVM_DIR/versions/node -maxdepth 3 -type l -wholename '*/bin/*' | xargs -n1 basename | sort | uniq`)
echo "" >> ~/.zshrc
echo "NODE_GLOBALS+=(\"node\")" >> ~/.zshrc
echo "NODE_GLOBALS+=(\"nvm\")" >> ~/.zshrc
echo "" >> ~/.zshrc
echo "load_nvm () {" >> ~/.zshrc
echo "  [ -s \"$NVM_SH\" ] && . \"$NVM_SH\"" >> ~/.zshrc
echo "}" >> ~/.zshrc
echo "" >> ~/.zshrc
echo "for cmd in \"${NODE_GLOBALS[@]}\""; do >> ~/.zshrc
echo "  eval \"${cmd}(){ unset -f ${NODE_GLOBALS}; load_nvm; ${cmd} \$@ }\"" >> ~/.zshrc
echo "done" >> ~/.zshrc


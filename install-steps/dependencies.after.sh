source basic.sh

# Homebrew
# ---------------

# Extension for preview
brew install qlcolorcode qlstephen qlmarkdown quicklook-json webpquicklook provisionql quicklookapk
brew install --appdir='/usr/local/bin' qlimagesize qlvideo # Avoid password

# Zip tool
#brew cask install the-unarchiver

# Install applications
# ---------------

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

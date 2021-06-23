#!bin/bash
if [[ -e ~/.macbootstrap ]]; then
  rm -rf ~/.macbootstrap
fi

if [[ ! -e /usr/local/bin/brew ] && [ ! -e /opt/homebrew/bin/brew ]]; then
    # chcange source && avoid prompt && quiet install
    #/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install | sed 's/https:\/\/github.com\/Homebrew\/brew/git:\/\/mirrors.ustc.edu.cn\/brew.git/g' | sed 's/https:\/\/github.com\/Homebrew\/homebrew-core/git:\/\/mirrors.ustc.edu.cn\/homebrew-core.git/g' | sed 's/\"fetch\"/\"fetch\", \"-q\"/g')" < /dev/null > /dev/null
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

    # Change source
    #cd "$(brew --repo)"
    #git remote set-url origin https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/brew.git

    #cd "$(brew --repo)/Library/Taps/homebrew/homebrew-core"
    #git remote set-url origin https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/homebrew-core.git

    export HOMEBREW_BOTTLE_DOMAIN=https://mirrors.tuna.tsinghua.edu.cn/homebrew-bottles
    export HOMEBREW_BREW_GIT_REMOTE="https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/brew.git"  # put your Git mirror of Homebrew/brew here
    export HOMEBREW_CORE_GIT_REMOTE="https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/homebrew-core.git"  # put your Git mirror of Homebrew/homebrew-core here
    #/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

    if [[ ! -e /usr/local/bin/brew ]]; then
        sudo ln -s /opt/homebrew/bin /usr/local/bin
        sudo ln -s /opt/homebrew/opt /usr/local/opt
        sudo ln -s /opt/homebrew/Cellar /usr/local/Cellar
        sudo ln -s /opt/homebrew/include /usr/local/include
        sudo ln -s /opt/homebrew/lib /usr/local/lib
    fi
else
    echo "You have installed brew"
fi

brew install git

git clone --depth=1 git@github.com:TMTBO/macconfig.git ~/.macbootstrap
cd ~/.macbootstrap
bash install.sh

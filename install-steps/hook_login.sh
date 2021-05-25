if [[ ! -d $HOME/Library/LaunchAgents ]]; then
    mkdir $HOME/Library/LaunchAgents
fi

sudo cp ~/.macbootstrap/config/com.thriller.onlogin.plist ~/Library/LaunchAgents/
sudo launchctl load ~/Library/LaunchAgents/com.thriller.onlogin.plist

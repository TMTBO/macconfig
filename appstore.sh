brew install mas

if [[ ! -e /Applications/Xcode.app ]]; then
    mas install 497799835
else
    echo "You have installed Xcode"
fi

if [[ ! -e /Applications/Take\ a\ Break.app ]]; then
    mas install 1457158844
else
    echo "You have installed Take a Break"
fi

if [[ ! -e /Applications/Xnip.app ]]; then
    mas install 1221250572
else
    echo "You have installed Xnip"
fi

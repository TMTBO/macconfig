# git
alias gbd='git branch -d'
alias gpo='git push origin'
alias gcn='git config user.name'
alias gcng='git config --global user.name'
alias gce='git config user.email'
alias gceg='git config --global user.email'
alias grsh='git remote show'
alias ggs='gg --stat'
alias ggp='gg -p'
alias gbv='gb -vv'
alias gbD='git branch -D'
alias gbm='git branch --merged'
alias gbnm='git branch --no-merged'
alias gvc='git verify-commit'
alias gct='git checkout --track'
alias gtrack='git branch --set-upstream-to=origin/`git symbolic-ref --short HEAD`'
alias gst='git stash -u'
#alias gga='gg --all'
alias gdtc='gdt head~..head'
alias gdts='gdt --staged'
alias set-upstream='git branch --set-upstream-to=origin/`git symbolic-ref --short HEAD`'
alias gref='git reflog'
alias grm='git reset'
alias grv='git remote -v'
alias gca='git commit --amend'
alias gcam='git commit --all -m'
alias gbr='git branch --remote'
alias gba='git branch -a'
alias gt='git tag'
alias gtd='git tag -d'
alias gcf='git checkout $(gb | fzf)'

# zsh
alias cpu='sysctl -n machdep.cpu.brand_string'
alias showFiles='defaults write com.apple.finder AppleShowAllFiles -bool true && killall Finder'
alias hideFiles='defaults write com.apple.finder AppleShowAllFiles -bool false && killall Finder'
alias ppjson='python $BS_ZSH_TOOLS/json_pretty.py'
alias pi='pod install'
alias pu='pod update'
alias cd='wd'
alias vim='nvim'
alias vimf='vim $(fzf)'
alias ns='npm start'
alias nb='npm run build'
alias r='source ranger'
alias -g H='| head -n'
alias -g T='| tail -n'
alias -g L="| less"
alias -g R='| row'
alias -g C='| column'
alias -g NE="2> /dev/null"
alias -g NUL="> /dev/null 2>&1"

alias pllint='pod lib lint --sources=http://gitlab.lizhi.fm/iOSPods/LizhiSpecs.git --use-libraries --allow-warnings'
alias pslint='pod spec lint --sources=http://gitlab.lizhi.fm/iOSPods/LizhiSpecs.git --use-libraries --allow-warnings'
alias ppackage='pod package *.podspec --library --force --spec-sources=http://gitlab.lizhi.fm/iOSPods/LizhiSpecs.git'
alias podrepopush='pod repo push LizhiSpecs --sources=http://gitlab.lizhi.fm/iOSPods/LizhiSpecs.git --use-libraries --allow-warnings'
alias pib='bundle exec pod install'
alias pub='bundle exec pod update'

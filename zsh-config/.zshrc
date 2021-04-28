export PATH=/usr/local/opt/coreutils/libexec/gnubin:$PATH:$M2_HOME/bin
plugins=(
extract
encode64
urltools
brew
zsh-syntax-highlighting
zsh-autosuggestions
wd
z
xcode
web-search
zsh-vi-mode
)

ZSH=$HOME/.oh-my-zsh

ZSH_THEME="robbyrussell"
PROMPT=$'%{$purple%}%n%{$reset_color%} in %{$limegreen%}%~%{$reset_color%}$(ruby_prompt_info " with%{$fg[red]%} " v g "%{$reset_color%}")$vcs_info_msg_0_%{$orange%}%{$reset_color%} at %{$hotpink%}%* %{$orange%}λ%{$reset_color%} '

source $ZSH/oh-my-zsh.sh
zstyle ':completion:*' completer _expand _complete _ignored _correct _approximate
zstyle ':completion:*' matcher-list 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} r:|[._-]=** r:|=**'
zstyle ':completion:*:*' ignored-patterns '*ORIG_HEAD'

# . /usr/local/lib/python3.8/site-packages/powerline/bindings/zsh/powerline.zsh

fpath=(/usr/local/share/zsh-completions $fpath)
compinit -u

HISTCONTROL=ignorespace
HISTFILE=~/.histfile
HISTSIZE=10000000
HISTFILESIZE=10000000
SAVEHIST=10000000
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=magenta'
ZSH_AUTOSUGGEST_STRATEGY="match_prev_cmd"

BS_ZSH_BASE="$HOME/.macbootstrap"
BS_ZSH_TOOLS=${BS_ZSH_BASE}/tools

ZVM_NORMAL_MODE_CURSOR=$ZVM_CURSOR_BLOCK
ZVM_INSERT_MODE_CURSOR=$ZVM_CURSOR_BEAM
ZVM_VISUAL_MODE_CURSOR=$ZVM_CURSOR_BLOCK
ZVM_VISUAL_LINE_MODE_CURSOR=$ZVM_CURSOR_BLOCK

# for homebrew
eval "$(/opt/homebrew/bin/brew shellenv)"

source $BS_ZSH_BASE/zsh-config/common.sh

[ -f /usr/local/etc/profile.d/autojump.sh ] && . /usr/local/etc/profile.d/autojump.sh
[ -f /opt/homebrew/etc/profile.d/autojump.sh ] && . /opt/homebrew/etc/profile.d/autojump.sh

if brew ls --versions scmpuff > /dev/null; then
    eval "$(scmpuff init -s --aliases=false)"
fi

eval "$(scmpuff init -s)"

fpath=(/usr/local/share/zsh-completions $fpath)

# GO
#export GOPATH=$HOME/go
#export GOBIN=$GOPATH/bin
#export PATH=$PATH:$GOBIN

# for nvm
export NVM_DIR=~/.nvm
export EDITOR="nvim"
# export NVM_SH="/usr/local/opt/nvm/nvm.sh"
[ -s "/usrlocal/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && . "/opt/homebrew/opt/nvm/nvm.sh"
# https://github.com/creationix/nvm/issues/860
# declare -a NODE_GLOBALS=(`find $NVM_DIR/versions/node -maxdepth 3 -type l -wholename '*/bin/*' | xargs -n1 basename | sort | uniq`)

NODE_GLOBALS+=("node")
NODE_GLOBALS+=("nvm")

load_nvm () {
  [ -s "$NVM_SH" ] && . "$NVM_SH"
}

for cmd in "${NODE_GLOBALS[@]}"; do
  eval "${cmd}(){ unset -f ${NODE_GLOBALS}; load_nvm; ${cmd} \$@ }"
done

# Bind key
bindkey 'C-;' autosuggest-execute

#archey -o
autoload -U bashcompinit
bashcompinit

# Homebrew
export PATH="/usr/local/bin:/usr/local/sbin:$PATH"
export PATH="/opt/homebrew/bin:/opt/homebrew/sbin:$PATH"
# Ruby
export PATH="/usr/local/opt/ruby/bin:/usr/local/lib/ruby/gems/2.6.0/bin:$PATH"
# Flutter
# export PATH="$PATH:$HOME/Developer/Flutter/flutter/bin"
# export ENABLE_FLUTTER_DESKTOP=true

# LLVM
export PATH="/opt/homebrew/opt/llvm/bin:$PATH"

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$HOME/.rvm/bin:$PATH"

# chromium depot_tools path
export PATH="$PATH:$HOME/Developer/depot_tools"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export LC_ALL=en_US.UTF-8
fpath=(~/.macbootstrap/zsh-config $fpath)
fpath=(/usr/local/share/zsh-completions $fpath)

export PATH="/usr/local/opt/bison/bin:$PATH"
export PATH="/usr/local/opt/openssl@1.1/bin:$PATH"
export LDFLAGS="-L/usr/local/opt/openssl@1.1/lib"
export CPPFLAGS="-I/usr/local/opt/openssl@1.1/include"
export PKG_CONFIG_PATH="/usr/local/opt/openssl@1.1/lib/pkgconfig"
fpath=(~/.macbootstrap/zsh-config $fpath)

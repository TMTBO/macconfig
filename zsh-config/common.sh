source $BS_ZSH_BASE/zsh-config/dirmark.sh

source $BS_ZSH_BASE/zsh-config/chinese_characters_adapter.sh
source $BS_ZSH_BASE/zsh-config/find.sh
source $BS_ZSH_BASE/zsh-config/git.sh
source $BS_ZSH_BASE/zsh-config/grep.sh
source $BS_ZSH_BASE/zsh-config/misc.sh
source $BS_ZSH_BASE/zsh-config/alias.sh
source $BS_ZSH_BASE/zsh-config/fzf.sh
for f in $BS_ZSH_BASE/zsh-config/functions/*.sh; do source $f; done

# Script only for mac
source $BS_ZSH_BASE/zsh-config/platform.mac.sh
#source $BS_ZSH_BASE/zsh-config/personalized.sh
source $BS_ZSH_BASE/zsh-config/colors.sh
source $BS_ZSH_BASE/zsh-config/maven.sh

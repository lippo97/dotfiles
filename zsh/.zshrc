export ZSH="/home/filo/.oh-my-zsh"
export ZSH_MIGRATING="$HOME/.zsh"

ZSH_THEME="gitster"
plugins=(git common-aliases npm node gradle docker)
source $ZSH/oh-my-zsh.sh

source $ZSH_MIGRATING/modules/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source $ZSH_MIGRATING/modules/sudo/sudo.plugin.zsh
source $ZSH_MIGRATING/path_loader.zsh
source $ZSH_MIGRATING/aliases


setopt nomultios

source $HOME/.environment
export VISUAL="nvim"
export EDITOR="$VISUAL"

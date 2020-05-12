export ZSH="/home/filo/.oh-my-zsh"
export ZSH_MIGRATING="$HOME/.zsh"
ZSH_THEME="gitster"
plugins=(git common-aliases npm node gradle )
source $ZSH/oh-my-zsh.sh

source /usr/share/fzf/key-bindings.zsh
source /usr/share/fzf/completion.zsh
source $ZSH_MIGRATING/modules/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source $ZSH_MIGRATING/modules/sudo/sudo.plugin.zsh

setopt nomultios

# Use ripgrep as default
export FZF_DEFAULT_COMMAND='fd --type f'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

source $HOME/.environment
export VISUAL=emacsclient
export EDITOR="$VISUAL"

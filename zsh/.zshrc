export ZSH="/home/filo/.oh-my-zsh"
source $ZSH/oh-my-zsh.sh
ZSH_THEME="gitster"

source /usr/share/fzf/key-bindings.zsh
source /usr/share/fzf/completion.zsh

# Use ripgrep as default 
export FZF_DEFAULT_COMMAND='fd --type f'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

source $HOME/.environment

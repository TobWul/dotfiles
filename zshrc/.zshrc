
# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH
export PATH="$PATH:`yarn global bin`"

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="kolo"

plugins=(git)

source $ZSH/oh-my-zsh.sh
alias vim="nvim"

eval "$(starship init zsh)"

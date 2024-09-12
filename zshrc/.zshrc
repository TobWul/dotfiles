# Oh My ZSH & P10K
export ZSH="$HOME/.oh-my-zsh"
export ZSH_THEME="kolo"
export ZSH_DOTENV_FILE=.env.local
export PATH=$(brew --prefix)/opt/python@3.10/libexec/bin:$PATH
export LC_ALL="en_US.UTF-8"

[[ ! -f $ZSH/oh-my-zsh.sh ]] || source $ZSH/oh-my-zsh.sh
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# User configuration
export EDITOR="nvim"

alias vim="nvim"
alias szsh="source ~/.zshrc"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

eval "$(starship init zsh)"

# Set up fzf key bindings and fuzzy completion
source <(fzf --zsh)

eval "$(zoxide init --cmd cd zsh)"

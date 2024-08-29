# Oh My ZSH & P10K
export ZSH="$HOME/.oh-my-zsh"
export ZSH_THEME="kolo"
export ZSH_DOTENV_FILE=.env.local
export PATH=$(brew --prefix)/opt/python@3.10/libexec/bin:$PATH
plugins=(yarn volta dotenv zsh-autosuggestions) # sublime yarn npm git zsh-syntax-highlighting
export LC_ALL="en_US.UTF-8"

[[ ! -f $ZSH/oh-my-zsh.sh ]] || source $ZSH/oh-my-zsh.sh
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# User configuration
export EDITOR="vim"
export APOLLO_TELEMETRY_DISABLED=1

alias ezsh="code ~/.zshrc"
alias szsh="source ~/.zshrc"
alias eomz="code ~/.oh-my-zsh"
alias disable-security="sudo spctl --master-disable && spctl --status"
alias enable-security="sudo spctl --master-enable && spctl --status"


CURRENT_DIR=$(pwd)
cd /Users/dkTobWul/Git/developer-portal/backstage
set -o allexport && source .env && set +o allexport
cd $CURRENT_DIR


export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

eval "$(starship init zsh)"

# Set up fzf key bindings and fuzzy completion
source <(fzf --zsh)

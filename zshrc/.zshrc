# Oh My ZSH & P10K
export ZSH="$HOME/.oh-my-zsh"
export ZSH_THEME="kolo"
export ZSH_DOTENV_FILE=.env.local
export PATH=$(brew --prefix)/opt/python@3.10/libexec/bin:$PATH
export PATH="/opt/homebrew/Caskroom/miniconda/base/bin:$PATH"
export LC_ALL="en_US.UTF-8"

[[ ! -f $ZSH/oh-my-zsh.sh ]] || source $ZSH/oh-my-zsh.sh
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# User configuration
export EDITOR="nvim"

alias vim="nvim"
alias python="python3"
alias pip="pip3"
alias szsh="source ~/.zshrc"
alias cloud="/Users/tobias/Library/Mobile Documents/com~apple~CloudDocs"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

eval "$(starship init zsh)"

# Set up fzf key bindings and fuzzy completion
source <(fzf --zsh)

eval "$(zoxide init --cmd cd zsh)"

# fnm
FNM_PATH="/Users/tobiaswulvik/Library/Application Support/fnm"
if [ -d "$FNM_PATH" ]; then
  export PATH="/Users/tobiaswulvik/Library/Application Support/fnm:$PATH"
  eval "`fnm env`"
fi

eval "$(fnm env --use-on-cd --shell zsh)"

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/Users/tobiaswulvik/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Users/tobiaswulvik/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/Users/tobiaswulvik/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/Users/tobiaswulvik/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<


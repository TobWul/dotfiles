# -----------------------------------------------------------------------------
# Core (Oh My Zsh) - load early for plugins, but keep light
# -----------------------------------------------------------------------------
export ZSH="$HOME/.oh-my-zsh"
[[ -f $ZSH/oh-my-zsh.sh ]] && source $ZSH/oh-my-zsh.sh

# -----------------------------------------------------------------------------
# Environment Variables / Paths (NO subshells in startup path building)
# -----------------------------------------------------------------------------
export ZSH_THEME="kolo"
export ZSH_DOTENV_FILE=.env.local
export EDITOR="nvim"
export LC_ALL="en_US.UTF-8"
export XDG_CONFIG_HOME="$HOME/.config"
export NVM_DIR="$HOME/.nvm"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
# bun completions
[ -s "$BUN_INSTALL/_bun" ] && source "$BUN_INSTALL/_bun"

# Static paths (adjust if different on Intel)
HOMEBREW_PREFIX="/opt/homebrew"
[ -d "$HOMEBREW_PREFIX" ] && PATH="$HOMEBREW_PREFIX/opt/python@3.10/libexec/bin:$PATH"
[ -d "/opt/homebrew/Caskroom/miniconda/base/bin" ] && PATH="/opt/homebrew/Caskroom/miniconda/base/bin:$PATH"
[ -d "$HOME/dotfiles/tmux/.local/scripts" ] && PATH="$HOME/dotfiles/tmux/.local/scripts:$PATH"
# Poetry and pipx shims
[ -d "$HOME/.local/bin" ] && PATH="$HOME/.local/bin:$PATH"
[ -d "$HOME/Library/Python/3.13/bin" ] && PATH="$HOME/Library/Python/3.13/bin:$PATH"
export PATH

# Poetry completions
fpath+=~/.zfunc
autoload -Uz compinit && compinit

# Netlin
export USERPROFILE="~/data"

export EDITOR="nvim"
# -----------------------------------------------------------------------------
# Aliases
# -----------------------------------------------------------------------------
alias vim="nvim"
alias lg="lazygit"
alias ta="tmux attach"
alias tk="tmux kill-session -t"
alias tl="tmux list-sessions"
alias ai="opencode"
alias ralph-once="opencode run --command ralph-once --agent ralph"
alias python="python3"
alias pip="pip3"
alias szsh="source ~/.zshrc"
alias cloud="/Users/tobias/Library/Mobile Documents/com~apple~CloudDocs"

# -----------------------------------------------------------------------------
# Key Bindings
# -----------------------------------------------------------------------------
bindkey -s ^f "tmux-sessionizer\n"

# Set up fzf key bindings and fuzzy completion
source <(fzf --zsh)

# -----------------------------------------------------------------------------
# Tools (lightweight first)
# -----------------------------------------------------------------------------
eval "$(zoxide init --cmd cd zsh)"
# Prompt (single framework only)
eval "$(starship init zsh)"

# -----------------------------------------------------------------------------
# Lazy Load: NVM (and node/npm/npx/pnpm/yarn wrappers)
# -----------------------------------------------------------------------------
_nvm_lazy_load() {
  unset -f nvm node npm npx pnpm yarn bun _nvm_lazy_load
  [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
}
nvm() { _nvm_lazy_load; nvm "$@"; }
node() { _nvm_lazy_load; node "$@"; }
npm() { _nvm_lazy_load; npm "$@"; }
npx() { _nvm_lazy_load; npx "$@"; }
pnpm() { _nvm_lazy_load; pnpm "$@"; }
yarn() { _nvm_lazy_load; yarn "$@"; }
bun() { _nvm_lazy_load; bun "$@"; }

# -----------------------------------------------------------------------------
# Lazy Load: Conda (only when 'conda' first used)
# -----------------------------------------------------------------------------
_conda_lazy_load() {
  unset -f conda _conda_lazy_load
  if [ -f "$HOMEBREW_PREFIX/Caskroom/miniconda/base/etc/profile.d/conda.sh" ]; then
    . "$HOMEBREW_PREFIX/Caskroom/miniconda/base/etc/profile.d/conda.sh"
  elif [ -f "$HOME/miniconda3/etc/profile.d/conda.sh" ]; then
    . "$HOME/miniconda3/etc/profile.d/conda.sh"
  fi
}
conda() { _conda_lazy_load; conda "$@"; }

# opencode
export PATH=/Users/tobiaswulvik/.opencode/bin:$PATH

# -----------------------------------------------------------------------------
# Zinit Plugin Manager
# -----------------------------------------------------------------------------
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"

source "${ZINIT_HOME}/zinit.zsh"

# -----------------------------------------------------------------------------
# Theme
# -----------------------------------------------------------------------------

# Load pure theme
zinit ice pick"async.zsh" src"pure.zsh" # with zsh-async library that's bundled with it.
zinit light sindresorhus/pure

zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab

# Load completions
autoload -Uz compinit && compinit

# -----------------------------------------------------------------------------
# History
# -----------------------------------------------------------------------------

# History
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# -----------------------------------------------------------------------------
# Completion styling
# -----------------------------------------------------------------------------
alias ls='ls --color'
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'

# -----------------------------------------------------------------------------
# Alias
# -----------------------------------------------------------------------------
alias v="nvim"
alias vim="nvim"
alias lg="lazygit"
alias ta="tmux attach"
alias tk="tmux kill-session -t"
alias tl="tmux list-sessions"
alias ai="claude"
alias python="python3"
alias pip="pip3"
alias szsh="source ~/.zshrc"
alias cloud="/Users/tobias/Library/Mobile Documents/com~apple~CloudDocs"
alias nvm="fnm"
alias pr="gh dash"

# -----------------------------------------------------------------------------
# Key Bindings
# -----------------------------------------------------------------------------


# -----------------------------------------------------------------------------
# Environment Variables / Paths (NO subshells in startup path building)
# -----------------------------------------------------------------------------
export EDITOR="nvim"
export LC_ALL="en_US.UTF-8"
export XDG_CONFIG_HOME="$HOME/.config"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
# bun completions
[ -s "$BUN_INSTALL/_bun" ] && source "$BUN_INSTALL/_bun"

# Static paths (adjust if different on Intel)
HOMEBREW_PREFIX="/opt/homebrew"
[ -d "$HOME/dotfiles/tmux/.local/scripts" ] && PATH="$HOME/dotfiles/tmux/.local/scripts:$PATH"

[ -d "$HOME/.local/bin" ] && PATH="$HOME/.local/bin:$PATH"

export PATH

# Netlin
export USERPROFILE="~/data"

export EDITOR="nvim"

# -----------------------------------------------------------------------------
# Tools (lightweight first)
# -----------------------------------------------------------------------------

# Zoxide
eval "$(zoxide init --cmd cd zsh)"

# Tmux
bindkey -s ^f "tmux-sessionizer\n"

# FZF
source <(fzf --zsh)

# opencode
export PATH=/Users/tobiaswulvik/.opencode/bin:$PATH

# Fnm
eval "$(fnm env --use-on-cd --shell zsh --log-level quiet)"

if command -v wt >/dev/null 2>&1; then eval "$(command wt config shell init zsh)"; fi

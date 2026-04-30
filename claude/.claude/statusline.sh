#!/bin/sh
input=$(cat)

# PS1-derived portion: robbyrussell style — ➜  <path>
dir=$(echo "$input" | jq -r '.workspace.current_dir // .cwd')
home="$HOME"
case "$dir" in
  "$home"/*) display_dir="~/${dir#$home/}" ;;
  "$home")   display_dir="~" ;;
  *)         display_dir="$dir" ;;
esac

# Git branch
if git -C "$dir" rev-parse --is-inside-work-tree >/dev/null 2>&1; then
  branch=$(git -C "$dir" symbolic-ref --short HEAD 2>/dev/null || git -C "$dir" rev-parse --short HEAD 2>/dev/null)
  git_part=$(printf ' \033[0;31m(%s)\033[0m' "$branch")
else
  git_part=$(printf ' \033[0;90m(no git)\033[0m')
fi

# Model name
model=$(echo "$input" | jq -r '.model.display_name // empty')
if [ -n "$model" ]; then
  model_part=$(printf ' \033[0;90m[%s]\033[0m' "$model")
else
  model_part=""
fi

# Context window usage — tokens from current_usage, percentage from used_percentage
used=$(echo "$input" | jq -r '.context_window.used_percentage // empty')
tokens=$(echo "$input" | jq -r '
  .context_window.current_usage //empty |
  ((.input_tokens // 0) + (.cache_creation_input_tokens // 0) + (.cache_read_input_tokens // 0))
')

if [ -n "$used" ] && [ -n "$tokens" ] && [ "$tokens" != "null" ]; then
  used_int=$(printf '%.0f' "$used")
  # Format tokens as e.g. 24.1k or 1.2M
  if [ "$tokens" -ge 1000000 ]; then
    tok_fmt=$(awk "BEGIN { printf \"%.1fM\", $tokens/1000000 }")
  elif [ "$tokens" -ge 1000 ]; then
    tok_fmt=$(awk "BEGIN { printf \"%.1fk\", $tokens/1000 }")
  else
    tok_fmt="${tokens}"
  fi
  if [ "$used_int" -ge 60 ]; then
    ctx_part=$(printf ' \033[0;31m%s (%d%%)\033[0m' "$tok_fmt" "$used_int")
  elif [ "$used_int" -ge 20 ]; then
    ctx_part=$(printf ' \033[0;33m%s (%d%%)\033[0m' "$tok_fmt" "$used_int")
  else
    ctx_part=$(printf ' %s (%d%%)' "$tok_fmt" "$used_int")
  fi
else
  ctx_part=""
fi

printf '\033[0;34m%s\033[0m%s%s%s' "$display_dir" "$git_part" "$model_part" "$ctx_part"

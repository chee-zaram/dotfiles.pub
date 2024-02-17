# Setup fzf
# ---------
if [[ ! "$PATH" == */home/cheezaram/.fzf/bin* ]]; then
  PATH="${PATH:+${PATH}:}/home/cheezaram/.fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/home/cheezaram/.fzf/shell/completion.zsh" 2> /dev/null

# Key bindings
# ------------
# source "/home/cheezaram/.fzf/shell/key-bindings.zsh"

# # Preview file content using bat (https://github.com/sharkdp/fd)
export FZF_CTRL_T_OPTS="
  --preview 'bat -n --color=always {}'
  --bind 'ctrl-/:change-preview-window(down|hidden)'"

export FZF_DEFAULT_COMMAND='fd --type file --follow --hidden --exclude .git --color=always'
export FZF_DEFAULT_OPTS="--ansi"

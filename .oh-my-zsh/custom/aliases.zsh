alias c='clear'

# Zsh and Oh My Zsh configuration files
alias zshconfig='$EDITOR ~/.zshrc'
alias zshaliases='$EDITOR ~/.oh-my-zsh/custom/aliases.zsh'

# i3 configuration file
alias i3config='$EDITOR ~/.config/i3/config'

# neovim configuration file
alias nvimconfig='$EDITOR ~/.config/nvim/init.lua'
alias cdnvim='z ~/.config/nvim/'

# emacs shortcut
alias em='/usr/bin/emacs -nw'

# nvim shortcut
alias nv='nvim'
alias vim='nvim'

# Git commit with cz
alias gcmt='g cz'

# Ranger shortcut
alias rr="ranger"

# Using 'eza' instead of 'ls'
alias ls='eza --icons --group-directories-first -sold'
alias l="eza --long --icons --group-directories-first -sold"
alias la="eza -a --icons --group-directories-first -sold"
alias ll="eza --long -a --icons --group-directories-first -sold"
alias lt="eza -aT --icons --group-directories-first -sold"
alias l.='eza -a | egrep "^\."'
alias tree='eza --tree --long'

# Changing directory and listing content
cl() { z "$@" && l; }
1l() { cd -1 && l; }
2l() { cd -2 && l; }
3l() { cd -3 && l; }

# Fuzzy find a file in the current directory and open with editor
nvf() { fzf -e | xargs -r -I % $EDITOR % }

# Use rg to find files where a search-string occurs, and interactively select
# which file to open in the editor using fzf.
rgword() {
    [[ $# -ne 1 ]] && echo "usage: $0 search-string" && return 1
    rg -. -li "$1" . | cut -d":" -f1 | cut -d"/" -f2- | fzf --multi --preview "bat --style=plain --color=always --line-range :100 {}" -e | xargs -r -o nvim
}

# Make sure there is a .config/systemd/user/spotifyd.service
# And it is enabled.
spotify() { systemctl --user restart spotifyd && spt }

# Source zsh
alias sozsh='exec zsh'

alias kns='kubens'
alias kc='kubectx'

# Colorize grep output
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'

# Confirm before overwritting
alias mv='mv -i'
alias rm='rm -i'

# ps
alias psa='ps auxf'
alias psgrep='ps aux | grep -v grep | grep -i -e VSZ -e'
alias psmem='ps auxf | sort -nr -k 4'
alias pscpu='ps auxf | sort -nr -k 3'

# Get error messages fro journalctl
alias jctl='journalctl -p 3 -xb'

# gpg encryption
# verify signature for isos
alias gpg-check="gpg2 --keyserver-options auto-key-retrieve --verify"
# receive the key of a developer
alias gpg-retrieve="gpg2 --keyserver-options auto-key-retrieve --receive-keys"

# youtube-dl
alias yta-aac="youtube-dl --extract-audio --audio-format aac "
alias yta-best="youtube-dl --extract-audio --audio-format best "
alias yta-flac="youtube-dl --extract-audio --audio-format flac "
alias yta-m4a="youtube-dl --extract-audio --audio-format m4a "
alias yta-mp3="youtube-dl --extract-audio --audio-format mp3 "
alias yta-opus="youtube-dl --extract-audio --audio-format opus "
alias yta-vorbis="youtube-dl --extract-audio --audio-format vorbis "
alias yta-wav="youtube-dl --extract-audio --audio-format wav "
alias ytv-best="youtube-dl -f bestvideo+bestaudio "

# switch between shells
alias tobash="sudo chsh $USER -s $(which bash) && echo 'Now log out.'"
alias tozsh="sudo chsh $USER -s $(which zsh) && echo 'Now log out.'"
alias tofish="sudo chsh $USER -s $(which fish) && echo 'Now log out.'"

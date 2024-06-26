alias c='clear'

# Zsh and Oh My Zsh configuration files
alias zshconfig='$EDITOR ~/.zshrc'
alias zshaliases='$EDITOR ~/.oh-my-zsh/custom/aliases.zsh'

# i3 configuration file
alias i3config='$EDITOR ~/.config/i3/config'

# neovim configuration file
alias nvimconfig='$EDITOR ~/.config/nvim/init.lua'
alias cdnvim='cd ~/.config/nvim/'

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

# Source zsh
alias sozsh='exec zsh'

alias kns='kubens'
alias kc='kubectx'

# Colorize grep output
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'

# Confirm before overwriting
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

alias luamake=/home/cheezaram/lua-language-server/3rd/luamake/luamake

# Open image with given filename using loupe image viewer.
alias open='loupe'

# View pdf or other documents.
alias view='evince'

alias aws="AWS_ACCESS_KEY_ID='$(pass show Credentials/AWS/Personal/key_id)' AWS_SECRET_ACCESS_KEY='$(pass show Credentials/AWS/Personal/key_secret)' aws"

# NVIM APP_NAME
alias nvim-kickstart="NVIM_APPNAME=kickstart nvim"
alias nvim-chad="NVIM_APPNAME=nvchad nvim"
alias nvim-lazy="NVIM_APPNAME=lazyvim nvim"

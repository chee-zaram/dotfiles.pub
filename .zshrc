# Added by alacrity for completions
fpath+=${ZDOTDIR:-~}/.zsh_functions

# Auto-added by p10k.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
    source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

### SET environment variables ###
[[ -d "$HOME/bin" ]] && PATH="$HOME/bin:$PATH"
[[ -d "/usr/local/bin" ]] && PATH="/usr/local/bin:$PATH"
[[ -d "$HOME/.bin" ]] && PATH="$HOME/.bin:$PATH"
[[ -d "$HOME/.local/bin" ]] && PATH="$HOME/.local/bin:$PATH"
[[ -d "$HOME/.emacs.d/bin" ]] && PATH="$HOME/.emacs.d/bin:$PATH"

# Go setup
[[ -d "/usr/local/go/bin" ]] && export PATH=$PATH:/usr/local/go/bin
[[ -d "$HOME/.go" ]] && export GOPATH=$HOME/.go
[[ -d "$GOPATH/bin" ]] && export PATH=$PATH:$GOPATH/bin && export GOBIN="$(go env GOPATH)/bin"
# 
# OR
#
# When installing go using pacman
# if command -v go >/dev/null 2>&1; then
#     export GOBIN="$(go env GOPATH)/bin"
#     export PATH="$PATH:$(go env GOBIN):$(go env GOPATH)/bin"
# fi

# Namespace cloud setup
[[ -d "$HOME/.ns" ]] && export NS_ROOT="$HOME/.ns" && export PATH="$NS_ROOT/bin:$PATH"

# Lua LSP setup
alias luamake=/home/cheezaram/lua-language-server/3rd/luamake/luamake
if [[ -d "$HOME/.config/lsp/lua-language-server/bin" ]]; then
    export PATH="${HOME}/.config/lsp/lua-language-server/bin:${PATH}"
fi

# MAN setup
[[ -d "/usr/local/man" ]] && MANPATH="/usr/local/man:$MANPATH"
export MANPAGER="sh -c 'col -bx | bat -l man -p'"

## ZSH related ##
# Path to your oh-my-zsh installation.
[[ -d "$HOME/.oh-my-zsh" ]] && ZSH="$HOME/.oh-my-zsh"

export ZSH_THEME="powerlevel10k/powerlevel10k"

# To enable vi mode, uncomment the following line, this isn't necessery if
# vi-mode is added in `plugins`
# bindkey -v

CASE_SENSITIVE="false"
HYPHEN_INSENSITIVE="true"
DISABLE_LS_COLORS="false"
COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"

zstyle ':omz:update' mode auto
zstyle ':omz:update' frequency 3

# For autocompletion
autoload -Uz compinit; compinit; _comp_options+=(globdots)

# For removing underline on filenames
(( ${+ZSH_HIGHLIGHT_STYLES} )) || typeset -A ZSH_HIGHLIGHT_STYLES
ZSH_HIGHLIGHT_STYLES[path]=none
ZSH_HIGHLIGHT_STYLES[path_prefix]=none

plugins=(
    git
    zsh-autosuggestions
    vi-mode
    # z
    colored-man-pages
    tmux
    urltools
    web-search
    zsh-navigation-tools
    zsh-interactive-cd
    kube-ps1
    fzf-zsh-plugin
)

### Uncomment only if zsh-vi-mode plugin is set and vi-mode is not set ###
# Display different prompt style for different modes                     #
# VI_MODE_RESET_PROMPT_ON_MODE_CHANGE=true                               #
# MODE_INDICATOR="%F{red}<<<%f" # normal mode                            #
# INSERT_MODE_INDICATOR="%F{yellow}>>>%f" # insert mode                  #

# To map 'esc' to 'jk' uncomment the next line
bindkey -M viins 'jk' vi-cmd-mode

# zoxide
if command -v zoxide >/dev/null 2>&1; then
    eval "$(zoxide init --cmd cd zsh)"

    [[ -f "$HOME/.z" ]] && zoxide import --from=z --merge "$HOME/.z"
fi

export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
    export EDITOR='vim'
else
    export EDITOR='nvim'
fi

function unpack () {
    [[ ! -f "$1" ]] && echo "'$1' is not a valid file" && return 1

    case "$1" in
        *.tar.bz2)        tar xjf "$1"                            ;;
        *.tar.gz)         tar xzf "$1"                            ;;
        *.bz2)            bunzip2 "$1"                            ;;
        *.rar)            unrar x "$1"                            ;;
        *.gz)             gunzip "$1"                             ;;
        *.tar)            tar xf "$1"                             ;;
        *.tbz2)           tar xjf "$1"                            ;;
        *.tgz)            tar xzf "$1"                            ;;
        *.zip)            unzip "$1"                              ;;
        *.Z)              uncompress "$1"                         ;;
        *)                echo "Usage:  unpack archive.extension" ;;
    esac
}

function pack () {
    if [[ $# -lt 2 ]]; then
        echo "usage:  pack archive.extension [dir|file]+"
        return 1
    fi

    [[ -f "$1" ]] && echo "error: destination $1 already exists." && return 1

    local lower
    lower=${(L)1}
    case "$lower" in
        *.tar.bz2)	tar cvjf "$@"                           ;;
        *.tar.gz)	tar cvzf "$@"                           ;;
        *.tar.xz)	tar cvJf "$@"                           ;;
        *.tar.lzma)	tar --lzma -cvf "$@"                    ;;
        *.bz2)		7za a -tbzip2 "$@"                      ;;
        *.gz)		7za a -tgzip "$@"                       ;;
        *.tar)		tar cvf "$@"                            ;;
        *.tbz2)		tar cvjf "$@"                           ;;
        *.tgz)		tar cvzf "$@"                           ;;
        *.zip)		zip -r "$@"                             ;;
        *.7z)		7za a -t7z -mmt "$@"                    ;;
        *) echo "'$1' unsupported archive format / extension."  ;;
    esac
}

function dict () {
    curl dict://dict.org/d:"${1}" | bat
}

# Enable tap-to-click on TouchPad:
function click () {
    usage="Usage: click {on|off}"

    [[ "$#" -eq 0 ]] && echo "$usage" && return 1

    # 0 for off, 1 for on
    case "$1" in
        "on")
            xinput set-prop "SynPS/2 Synaptics TouchPad" "libinput Tapping Enabled" 1 ;;
        "off")
            xinput set-prop "SynPS/2 Synaptics TouchPad" "libinput Tapping Enabled" 0 ;;
        *)
            echo "'$1' is an invalid argument. $usage" && return 1                    ;;
    esac
}

# Copy an entire file to the clipboard
function toclip () {
    [[ "$#" -eq 0 ]] && echo "usage: toclip {file}" && return 1

    [[ ! -f "$1" ]] && echo "Error: $1 must be a file" && return 1

    if ! command -v xclip >/dev/null 2>&1; then
        echo "Error: xclip utility not installed" && return 1
    fi

    cat "$1" | xclip -selection clipboard
}

# docker_rm_stopped removes all stopped containers.
function docker_rm_stopped() {
    docker rm $(docker ps -a -q)
}

# For starting the ssh agent on shell startup
eval "$(ssh-agent)" &>/dev/null

# Cargo setup
[[ -f "$HOME/.cargo/env " ]] && source "$HOME"/.cargo/env

# If not running interactively do not do anything
[[ $- != *i* ]] && return

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh

# Source the fzf file if it exists
[[ -f ~/.fzf.zsh ]] && source ~/.fzf.zsh

# Source oh-my-zsh if it exists
[[ -f "$ZSH/oh-my-zsh.sh" ]] && source "$ZSH"/oh-my-zsh.sh


# start homebrew if installed.
[[ -f "/home/linuxbrew/.linuxbrew/bin/brew" ]] && eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

# Add oh-my-zsh plugin kube_ps1 to display kubernetes info in prompt
PROMPT='$(kube_ps1)'$PROMPT # or RPROMPT='$(kube_ps1)'

[ -f ~/.kubectl_aliases ] && source ~/.kubectl_aliases

local IBM_CLOUD_ZSH_RC_AC="/usr/local/ibmcloud/autocomplete/zsh_autocomplete"
[[ -f "$IBM_CLOUD_ZSH_RC_AC" ]] && source "$IBM_CLOUD_ZSH_RC_AC"

export AWS_REGION="eu-west-1"

# Enable autocompletion for kubectl
source <(kubectl completion zsh)
# or the one below if the file is present.
# [[ -f "$HOME/.kubectl_completion.sh" ]] && source "$HOME/.kubectl_completion.sh"


export MODULAR_HOME="/home/cheezaram/.modular"
[[ -d "$MODULAR_HOME" ]] && export PATH="$MODULAR_HOME/pkg/packages.modular.com_mojo/bin:$PATH"

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/cheezaram/.anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/cheezaram/.anaconda3/etc/profile.d/conda.sh" ]; then
        . "/home/cheezaram/.anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/cheezaram/.anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<
fpath=(/home/cheezaram/.oh-my-zsh/custom/completions /home/cheezaram/.oh-my-zsh/plugins/kube-ps1 /home/cheezaram/.oh-my-zsh/plugins/zsh-interactive-cd /home/cheezaram/.oh-my-zsh/plugins/zsh-navigation-tools /home/cheezaram/.oh-my-zsh/plugins/web-search /home/cheezaram/.oh-my-zsh/plugins/urltools /home/cheezaram/.oh-my-zsh/plugins/tmux /home/cheezaram/.oh-my-zsh/plugins/colored-man-pages /home/cheezaram/.oh-my-zsh/plugins/z /home/cheezaram/.oh-my-zsh/plugins/vi-mode /home/cheezaram/.oh-my-zsh/custom/plugins/zsh-autosuggestions /home/cheezaram/.oh-my-zsh/plugins/git /home/cheezaram/.oh-my-zsh/functions /home/cheezaram/.oh-my-zsh/completions /home/cheezaram/.oh-my-zsh/cache/completions /usr/local/share/zsh/site-functions /usr/share/zsh/vendor-functions /usr/share/zsh/vendor-completions /usr/share/zsh/functions/Calendar /usr/share/zsh/functions/Chpwd /usr/share/zsh/functions/Completion /usr/share/zsh/functions/Completion/AIX /usr/share/zsh/functions/Completion/BSD /usr/share/zsh/functions/Completion/Base /usr/share/zsh/functions/Completion/Cygwin /usr/share/zsh/functions/Completion/Darwin /usr/share/zsh/functions/Completion/Debian /usr/share/zsh/functions/Completion/Linux /usr/share/zsh/functions/Completion/Mandriva /usr/share/zsh/functions/Completion/Redhat /usr/share/zsh/functions/Completion/Solaris /usr/share/zsh/functions/Completion/Unix /usr/share/zsh/functions/Completion/X /usr/share/zsh/functions/Completion/Zsh /usr/share/zsh/functions/Completion/openSUSE /usr/share/zsh/functions/Exceptions /usr/share/zsh/functions/MIME /usr/share/zsh/functions/Math /usr/share/zsh/functions/Misc /usr/share/zsh/functions/Newuser /usr/share/zsh/functions/Prompts /usr/share/zsh/functions/TCP /usr/share/zsh/functions/VCS_Info /usr/share/zsh/functions/VCS_Info/Backends /usr/share/zsh/functions/Zftp /usr/share/zsh/functions/Zle /home/cheezaram/.zsh_functions)

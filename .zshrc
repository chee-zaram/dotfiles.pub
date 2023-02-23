# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
    source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
PATH="$HOME/bin:/usr/local/bin:$PATH"

# Path to your oh-my-zsh installation.
ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
export ZSH_THEME="powerlevel10k/powerlevel10k"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "af-magic" "smt" )
# some more: "robbyrussell" "agnoster" )

# To enable vi mode, uncomment the following line, this isn't necessery if
# vi-mode is added in `plugins`
# bindkey -v

CASE_SENSITIVE="false"

HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

DISABLE_LS_COLORS="false"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
    git
    python
    zsh-autosuggestions
    vi-mode
    z
    colored-man-pages
    github
    nvm
    tmux
    urltools
    transfer
    web-search
    yarn
    zsh-navigation-tools
    zsh-interactive-cd
)

### uncomment only if zsh-vi-mode is commented and vi-mode is uncommented ###
# Display different prompt style for different modes                        #
# VI_MODE_RESET_PROMPT_ON_MODE_CHANGE=true                                  #
# MODE_INDICATOR="%F{red}<<<%f" # normal mode                               #
# INSERT_MODE_INDICATOR="%F{yellow}>>>%f" # insert mode                     #

# To map 'esc' is 'jk' uncomment the next line
bindkey -M viins 'jk' vi-cmd-mode

# Add path for custom man pages
MANPATH="/usr/local/man:$MANPATH"

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
    export EDITOR='nvim'
else
    export EDITOR='nvim'
fi

# for autocompletion
autoload -Uz compinit; compinit; _comp_options+=(globdots)

# For removing underline on filenames
(( ${+ZSH_HIGHLIGHT_STYLES} )) || typeset -A ZSH_HIGHLIGHT_STYLES
ZSH_HIGHLIGHT_STYLES[path]=none
ZSH_HIGHLIGHT_STYLES[path_prefix]=none


# Compile .c files with Holberton school's flags
function hcc () {
    if [[ ! -e "$1" ]]; then
        echo "$1 does not exist. Please enter a valid file name"
        return 1
    fi

    if [[ -f "$1" ]]; then
        gcc -Wall -Werror -Wextra -pedantic -std=gnu89 -g "$@" -o $( echo "$1" | cut -d "." -f 1 )
    else
        echo "Usage: hcc filename.c [filename.c[...]]"
    fi
}

# Unpacking archives. Thanks to mamba?
function unpack () {
    if [[ -f "$1" ]] ; then
        case "$1" in
            *.tar.bz2)        tar xjf "$1"        ;;
            *.tar.gz)         tar xzf "$1"        ;;
            *.bz2)            bunzip2 "$1"        ;;
            *.rar)            unrar x "$1"        ;;
            *.gz)             gunzip "$1"         ;;
            *.tar)            tar xf "$1"         ;;
            *.tbz2)           tar xjf "$1"        ;;
            *.tgz)            tar xzf "$1"        ;;
            *.zip)            unzip "$1"          ;;
            *.Z)              uncompress "$1"     ;;
            *)                echo "Usage:  unpack archive.extension" ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}

# Archiving. Thanks to mamba?
function pack () {
    if [[ $# -lt 2 ]]; then
        echo "usage:  pack archive.extension [dir|file]+"
        return 1
    fi

    [[ -f "$1" ]] && echo "error: destination $1 already exists." && return 1

    local lower
    lower=${(L)1}
    case "$lower" in
        *.tar.bz2)	tar cvjf "$@"			;;
        *.tar.gz)	tar cvzf "$@"			;;
        *.tar.xz)	tar cvJf "$@"			;;
        *.tar.lzma)	tar --lzma -cvf "$@"	;;
        *.bz2)		7za a -tbzip2 "$@"		;;
        *.gz)		7za a -tgzip "$@"		;;
        *.tar)		tar cvf "$@"			;;
        *.tbz2)		tar cvjf "$@"			;;
        *.tgz)		tar cvzf "$@"			;;
        *.zip)		zip -r "$@"				;;
        *.7z)		7za a -t7z -mmt "$@"	;;
        *) echo "'$1' unsupported archive format / extension." ;;
    esac
}

function dict () {
    curl dict://dict.org/d:"${1}" | batcat
}

# Enable tap-to-click on TouchPad: 0 for off, 1 for on
# I need this because I use i3wm
function click () {
    usage="Usage: click {on|off}"

    if [[ "$#" -eq 0 ]]; then
        echo "$usage"
        return 1
    fi

    case "$1" in
        "on")
            xinput set-prop "SynPS/2 Synaptics TouchPad" "libinput Tapping Enabled" 1
            ;;
        "off")
            xinput set-prop "SynPS/2 Synaptics TouchPad" "libinput Tapping Enabled" 0
            ;;
        *)
            echo "'$1' is an invalid argument. $usage"
            ;;
    esac
}

# Copy an entire file to the clipboard. Name inspired by phatboi
function toclip () {
    if [[ "$#" -eq 0 ]]; then
        echo "usage: toclip {file}"
        return 1
    fi

    if [[ ! -f "$1" ]]; then
        echo "Error: $1 must be a file"
        return 1
    fi

    if ! command -v xclip >/dev/null 2>&1; then
        echo "Error: xclip utility not installed"
        return 1
    fi

    cat "$1" | xclip -selection clipboard
}

# for starting up the ssh on shell startup
eval "$(ssh-agent)" &>/dev/null

source "$HOME"/.cargo/env

alias luamake=/home/cheezaram/lua-language-server/3rd/luamake/luamake
export PATH="${HOME}/.config/lsp/lua-language-server/bin:${PATH}"
export OPENAI_API_KEY="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"

# open man pages with bat
export MANPAGER="sh -c 'col -bx | batcat -l man -p'"

# if not running interactively do not do anything
[[ $- != *i* ]] && return

if [[ -d "$HOME/.bin" ]] ; then
    PATH="$HOME/.bin:$PATH"
fi

if [[ -d "$HOME/.local/bin" ]] ; then
    PATH="$HOME/.local/bin:$PATH"
fi

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# source our fzf file if it exists
[[ -f ~/.fzf.zsh ]] && source ~/.fzf.zsh

source "$ZSH"/oh-my-zsh.sh

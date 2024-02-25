# Changing directory and listing content
function cl() { z "$@" && l; }
function 1l() { cd -1 && l; }
function 2l() { cd -2 && l; }
function 3l() { cd -3 && l; }

# Fuzzy find a file in the current directory and open with editor
function nvf() { fzf -e | xargs -r -I % $EDITOR % }

# Use rg to find files where a search-string occurs, and interactively select
# which file to open in the editor using fzf.
function rgword() {
    [[ $# -ne 1 ]] && echo "usage: $0 search-string" && return 1
    rg -. -li "$1" . | cut -d":" -f1 | cut -d"/" -f2- | fzf --multi --preview "bat --style=plain --color=always --line-range :100 {}" -e | xargs -r -o nvim
}

# Make sure there is a .config/systemd/user/spotifyd.service
# And it is enabled.
function spotify() { systemctl --user restart spotifyd && spt }

# Run sudo pacman -Syu
function pacup() {
    echo "This command will require you to enter your password...\n"

	if command -v pacman >/dev/null 2>&1; then
		sudo pacman -Syu
	else
		echo "pacman not installed" && return 1
	fi
}

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
    curl -sS dict://dict.org/d:"${1}" | bat
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

# lg let's lazygit change the user into the directory they were in before
# quiting lazygit.
function lg()
{
    export LAZYGIT_NEW_DIR_FILE=~/.lazygit/newdir

    lazygit "$@"

    if [ -f $LAZYGIT_NEW_DIR_FILE ]; then
            cd "$(cat $LAZYGIT_NEW_DIR_FILE)"
            rm -f $LAZYGIT_NEW_DIR_FILE > /dev/null
    fi
}

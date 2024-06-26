############################## Function Paths. ##############################
fpath+=(${ZDOTDIR:-~}/.zsh_functions)

################################### p10k. ###################################
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi


##################################### ENV #####################################
if [[ -d "$HOME/bin" && ! "$PATH" == *"$HOME/bin"* ]]; then
  PATH="${PATH:+${PATH}:}$HOME/bin"
fi

if [[ -d "/usr/local/bin" && ! "$PATH" == */usr/local/bin* ]]; then
  PATH="${PATH:+${PATH}:}/usr/local/bin"
fi

if [[ -d "$HOME/.bin" && ! "$PATH" == *"$HOME/.bin"* ]]; then
  PATH="${PATH:+${PATH}:}$HOME/.bin"
fi

if [[ -d "$HOME/.local/bin" && ! "$PATH" == *"$HOME/.local/bin"* ]]; then
  PATH="${PATH:+${PATH}:}$HOME/.local/bin"
fi

if [[ -d "$HOME/.emacs.d/bin" && ! "$PATH" == *"$HOME/.emacs.d/bin"* ]]; then
  PATH="${PATH:+${PATH}:}$HOME/.emacs.d/bin"
fi

#################################### Go. ####################################
# if [[ -d "/usr/local/go/bin" && ! "$PATH" == */usr/local/go/bin* ]]; then
#     export PATH="${PATH:+${PATH}:}/usr/local/go/bin"
# fi

if command -v go >/dev/null 2>&1; then
  if [[ -d "$HOME/.go" ]]; then
    export GOPATH="$HOME/.go"
    mkdir -p "$GOPATH/bin"

    if [[ ! "$PATH" == *"$GOPATH/bin"* ]]; then
      export GOBIN="$GOPATH/bin"
      export PATH="${PATH:+${PATH}:}$GOBIN"
    fi
  else
    export GOBIN="$(go env GOPATH)/bin"
    export PATH="$PATH:$(go env GOBIN)"
  fi

  if [[ -d "/usr/lib/go" && ! "$PATH" == *"/usr/lib/go"* ]]; then
    export PATH="$PATH:/usr/lib/go"
  fi
fi


############################### Namespace Cloud. ##############################
if [[ -d "$HOME/.ns" ]]; then
  export NS_ROOT="$HOME/.ns"
  mkdir -p "$NS_ROOT/bin"

  [[ ! "$PATH" == *"$NS_ROOT/bin"* ]] && export PATH="${PATH:+${PATH}:}$NS_ROOT/bin"
fi


################################# LuaLSP setup ################################
if [[ -d "$HOME/.config/lsp/lua-language-server/bin" ]]; then
  if [[ ! "$PATH" == *"$HOME/.config/lsp/lua-language-server/bin"* ]]; then
    export PATH="${PATH:+${PATH}:}$HOME/.config/lsp/lua-language-server/bin"
  fi
fi


################################## MAN setup ##################################
if [[ -d "/usr/local/man" && ! "$MANPATH" == */usr/local/man* ]]; then
  MANPATH="${MANPATH:+${MANPATH}:}/usr/local/man"
fi

export MANPAGER="sh -c 'col -bx | bat -l man -p'"


################################# ZSH related #################################
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

# This opens up fzf tab completion bar in a tmux popup pane. Must be in tmux
# environment and have fzf-tab plugin installed.
# zstyle ':fzf-tab:*' fzf-command ftb-tmux-popup

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
  colored-man-pages
  urltools
  web-search
  zsh-navigation-tools
  zsh-interactive-cd
  kube-ps1
  fzf-zsh-plugin fzf-tab
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

  test -f "$HOME/.z" && zoxide import --from=z --merge "$HOME/.z"
fi

export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi

# For starting the ssh agent on shell startup
eval "$(ssh-agent)" &>/dev/null

# If not running interactively do not do anything
[[ $- != *i* ]] && return


################################ Cargo setup #################################
test -f "$HOME/.cargo/env" && source "$HOME/.cargo/env"


####### To customize prompt, run `p10k configure` or edit ~/.p10k.zsh. ########
test -f ~/.p10k.zsh && source ~/.p10k.zsh


####################### Source the fzf file if it exists ######################
test -f ~/.fzf.zsh && source ~/.fzf.zsh


####################### Source oh-my-zsh if it exists. #######################
test -f "$ZSH/oh-my-zsh.sh" && source "$ZSH/oh-my-zsh.sh"


#################### Start homebrew if installed on linux. ####################
test -f "/home/linuxbrew/.linuxbrew/bin/brew" && eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"


################################# Kubernetes ##################################
#
##### Add oh-my-zsh plugin kube_ps1 to display kubernetes info in prompt #####
PROMPT='$(kube_ps1)'$PROMPT # or RPROMPT='$(kube_ps1)'

# Source kubectl aliases.
test -f ~/.kubectl_aliases && source ~/.kubectl_aliases

# Enable autocompletion for kubectl
if command -v kubectl >/dev/null 2>&1; then
  source <(kubectl completion zsh)
fi
# or the one below if the file is present.
# [[ -f "$HOME/.kubectl_completion.sh" ]] && source "$HOME/.kubectl_completion.sh"


################################# IBM Cloud. #################################
local IBM_CLOUD_ZSH_RC_AC="/usr/local/ibmcloud/autocomplete/zsh_autocomplete"
test -f "$IBM_CLOUD_ZSH_RC_AC" && source "$IBM_CLOUD_ZSH_RC_AC"


#################################### AWS ######################################
export AWS_REGION="eu-west-1"
local AWS_ZSH_COMPLETER="$HOME/.aws_zsh_completer.sh"
test -f "$AWS_ZSH_COMPLETER" && source "$AWS_ZSH_COMPLETER"


################################### MODUlAR ###################################
export MODULAR_HOME="/home/cheezaram/.modular"
if [[ -d "$MODULAR_HOME" && ! "$PATH" == *"$MODULAR_HOME/pkg/packages.modular.com_mojo/bin"* ]]; then
  export PATH="${PATH:+${PATH}:}$MODULAR_HOME/pkg/packages.modular.com_mojo/bin"
fi


#################################### GPG ####################################
GPG_TTY=$(tty)


#################################### Conda ####################################
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

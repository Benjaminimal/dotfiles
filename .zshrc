# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="ys"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

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
    aws
    colored-man-pages
    fzf
    dotenv
    git
    git-flow
    docker
    docker-compose
    vagrant
    pip
)

source $ZSH/oh-my-zsh.sh

# User configuration

SECRETS_RC=~/.secretsrc
if [ -f $SECRETS_RC ]; then
    source $SECRETS_RC;
fi

export PATH=$PATH:/sbin
export PATH=$PATH:/usr/sbin
export PATH=$PATH:$HOME/.local/bin

# No more BEEEP!
if [ -n "$DISPLAY" ]; then
	xset b off
fi

# I like neovim
export EDITOR="nvim"
alias v="nvim"
alias vi="nvim"
alias vim="nvim"
alias vimdiff="nvim -d"

vs() {
    # https://piet.me/branch-based-sessions-in-vim/
    # Create .sessions directory if it doesn't exist
    if [[ ! -d './.sessions' ]]; then
        mkdir './.sessions'
    fi

    # Create a session file name based on the current branch
    local session_name=".sessions/$(git rev-parse --abbrev-ref HEAD | sed 's/\//-/')_session.vim"
    if [ -e $session_name ]; then
        # If the session file exists open it
        vim -S $session_name
    else
        # Otherwise create it
        vim -c "Obsession $session_name" .
    fi
}


# Virtualenv Wrapper Settings
VENV_WRAPPER=$HOME/.local/bin/virtualenvwrapper.sh
if [[ -e $VENV_WRAPPER ]]; then
	export VIRTUALENVWRAPPER_PYTHON=$(which python3)
    export VIRTUALENVWRAPPER_VIRTUALENV=$HOME/.local/bin/virtualenv
    export WORKON_HOME=$HOME/.virtualenvs
    export PROJECT_HOME=$HOME/Projects
    source $VENV_WRAPPER
fi

# Disable zsh time in favor of builtin command
disable -r time
alias time='time -p'

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

export AWS_VAULT_BACKEND="file"

# Needed for signed git commits
# https://docs.github.com/en/authentication/managing-commit-signature-verification/telling-git-about-your-signing-key
export GPG_TTY=$(tty)

# Fzf
export FZF_COMPLETION_OPTS='--hidden'

# Functions

# Pretty print json
pjson() {
    echo "${1}" | python -m json.tool
}

cjson() {
    curl "${@}" | python -m json.tool
}

remember() { [[ $# -eq 2 ]] || exit; echo "alias ${1}='${2}'" >> ~/.zshrc; source ~/.zshrc }

# Audio Ping
mping(){ ping $@|awk -F'[=\ ]' '/time=/{t=$(NF-1);f=2000-14*log(t^18);c="play -q -n synth 1 pl "f"&";print $0;system(c)}';}

# Generate password
function mkpass {
    openssl rand 512 | base64 -w 0 | tr -cd '[:alnum:]._-' | head -c $1
}


# Aliases
# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.

alias calc="python3 -i -c 'import math as m; import random as r'"

alias python="python3"

# url(de|en)code
alias urldecode='python3 -c "import sys, urllib.parse as ul; print(ul.unquote_plus(sys.argv[1]))"'
alias urlencode='python3 -c "import sys, urllib.parse as ul; print (ul.quote_plus(sys.argv[1]))"'


autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /usr/bin/terraform terraform

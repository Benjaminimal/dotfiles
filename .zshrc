# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="ys"

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
    vi-mode
    fzf
    dotenv
    git
    docker
    docker-compose
    pip
    direnv
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

# Enable vim mode in zsh
export KEYTIMEOUT=1
export VI_MODE_RESET_PROMPT_ON_MODE_CHANGE=true
export VI_MODE_SET_CURSOR=true

# I like neovim
PATH=$HOME/.local/share/bob/nvim-bin:$PATH
export EDITOR="nvim"
alias v="nvim"
alias vi="nvim"
alias vim="nvim"
alias vimdiff="nvim -d"


# Disable zsh time in favor of builtin command
disable -r time
alias time='time -p'

# fd has a werid name in debian
alias fd='fdfind'

export AWS_VAULT_BACKEND="file"

# Needed for signed git commits
# https://docs.github.com/en/authentication/managing-commit-signature-verification/telling-git-about-your-signing-key
export GPG_TTY=$(tty)

# Fzf
export FZF_COMPLETION_OPTS='--hidden'

# uv
eval "$(uv generate-shell-completion zsh)"
eval "$(uvx --generate-shell-completion zsh)"
if command -v zoxide > /dev/null; then
  eval "$(zoxide init zsh)"
fi

# required for node version manager
# https://github.com/nvm-sh/nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# give node enough memory to build the frontend
export NODE_OPTIONS="--max-old-space-size=9216"

# Terraform completion
autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /usr/bin/terraform terraform

# zettelkatsten home directory
export ZK_NOTEBOOK_DIR="$HOME/notes"

# Functions

# Access Redis via RedisInsight
# https://formunauts.atlassian.net/wiki/spaces/INFRA/pages/2630352897/Inspect+Redis+with+RedisInsight

ec2-bind-redis-staging() {
    REDIS_ENDPOINT='formunauts-staging-redis-cluster-001.7xzxct.0001.euc1.cache.amazonaws.com'
    source awsume formunauts-staging-admin && aws ssm start-session \
        --target ${1} \
        --document-name AWS-StartPortForwardingSessionToRemoteHost \
        --parameters host="${REDIS_ENDPOINT}",portNumber="6379",localPortNumber="6379"
}

ec2-bind-redis-prod() {
    REDIS_ENDPOINT='formunauts-prod-redis-cluster-002.xigt7b.0001.euc1.cache.amazonaws.com'
    source awsume formunauts-prod-admin && aws ssm start-session \
        --target ${1} \
        --document-name AWS-StartPortForwardingSessionToRemoteHost \
        --parameters host="${REDIS_ENDPOINT}",portNumber="6379",localPortNumber="6379"
}

# Access OpenSearch via OpenSearch Dashboards

ec2-bind-open-search-staging() {
    OS_ENDPOINT='vpc-formunauts-staging-os-cz5shxp4si4uke4q2zb52sm2wq.eu-central-1.es.amazonaws.com'
    source awsume formunauts-staging-admin && aws ssm start-session \
        --target ${1} \
        --document-name AWS-StartPortForwardingSessionToRemoteHost \
        --parameters host="${OS_ENDPOINT}",portNumber="9200",localPortNumber="6379"
}


# Quickly add an alias to .zshrc
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

alias calc="ipython3"

# url(de|en)code
alias urldecode='python3 -c "import sys, urllib.parse as ul; print(ul.unquote_plus(sys.argv[1]))"'
alias urlencode='python3 -c "import sys, urllib.parse as ul; print (ul.quote_plus(sys.argv[1]))"'

# TODO: can probably be removed
# no need to source this everytime
# alias awsume='. awsume'

# don't open ghostscrip on typos
alias gs='echo "ghostscript is disabled (you probably mistyped)"'

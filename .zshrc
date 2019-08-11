# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/home/elio/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME

# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME=powerlevel10k/powerlevel10k

POWERLEVEL9K_MODE='awesome-fontconfig'
POWERLEVEL9K_PROMPT_ON_NEWLINE=true
POWERLEVEL9K_MULTILINE_FIRST_PROMPT_PREFIX=""
POWERLEVEL9K_MULTILINE_LAST_PROMPT_PREFIX="\uE0B0 "
POWERLEVEL9K_PROMPT_ON_NEWLINE=true
POWERLEVEL9K_LEFT_SEGMENT_SEPARATOR=$'\uE0BC'
#POWERLEVEL9K_RIGHT_SEGMENT_SEPARATOR="\uE0B9"
POWERLEVEL9K_WHITESPACE_BETWEEN_LEFT_SEGMENT=""
POWERLEVEL9K_LEFT_SUBSEGMENT_SEPARATOR=$'\uE0BB'
#POWERLEVEL9K_RIGHT_SUBSEGMENT_SEPARATOR=$'\uE0B9'

POWERLEVEL9K_DIR_HOME_BACKGROUND='023'
POWERLEVEL9K_DIR_HOME_FOREGROUND="249"

POWERLEVEL9K_TIME_BACKGROUND='023'
POWERLEVEL9K_TIME_FOREGROUND="249"

POWERLEVEL9K_VI_MODE_NORMAL_BACKGROUND='023'
POWERLEVEL9K_VI_MODE_NORMAL_FOREGROUND="158"
POWERLEVEL9K_VI_MODE_INSERT_BACKGROUND='023'
POWERLEVEL9K_VI_MODE_INSERT_FOREGROUND="249"
POWERLEVEL9K_VI_MODE_INSERT_VISUAL_IDENTIFIER="249"
POWERLEVEL9K_VI_MODE_VISUAL_BACKGROUND='023'
POWERLEVEL9K_VI_MODE_VISUAL_FOREGROUND="013"

# Battery colors
POWERLEVEL9K_BATTERY_CHARGING='107'
POWERLEVEL9K_BATTERY_CHARGED='blue'
POWERLEVEL9K_BATTERY_LOW_THRESHOLD='50'
POWERLEVEL9K_BATTERY_LOW_COLOR='red'
POWERLEVEL9K_BATTERY_CHARGED_BACKGROUND='blue'
POWERLEVEL9K_BATTERY_CHARGED_FOREGROUND='white'
POWERLEVEL9K_BATTERY_CHARGING_BACKGROUND='107'
POWERLEVEL9K_BATTERY_CHARGING_FOREGROUND='white'
POWERLEVEL9K_BATTERY_LOW_BACKGROUND='red'
POWERLEVEL9K_BATTERY_LOW_FOREGROUND='white'
POWERLEVEL9K_BATTERY_DISCONNECTED_FOREGROUND='blue'
POWERLEVEL9K_BATTERY_DISCONNECTED_BACKGROUND='237'

POWERLEVEL9K_STATUS_OK_BACKGROUND='237'
POWERLEVEL9K_STATUS_OK_FOREGROUND='springgreen2'
POWERLEVEL9K_STATUS_ERROR_BACKGROUND='237'
POWERLEVEL9K_STATUS_ERROR_FOREGROUND='red'
POWERLEVEL9K_STATUS_CROSS=true
POWERLEVEL9K_STATUS_VERBOSE=true

POWERLEVEL9K_LOAD_CRITICAL_BACKGROUND="black"
POWERLEVEL9K_LOAD_CRITICAL_FOREGROUND="white"
POWERLEVEL9K_LOAD_WARNING_BACKGROUND="black"
POWERLEVEL9K_LOAD_WARNING_FOREGROUND="white"
POWERLEVEL9K_LOAD_NORMAL_BACKGROUND="black"
POWERLEVEL9K_LOAD_NORMAL_FOREGROUND="white"
# Colorize only the visual identifier
POWERLEVEL9K_LOAD_CRITICAL_VISUAL_IDENTIFIER_COLOR="red"
POWERLEVEL9K_LOAD_WARNING_VISUAL_IDENTIFIER_COLOR="yellow"
POWERLEVEL9K_LOAD_NORMAL_VISUAL_IDENTIFIER_COLOR="green"

POWERLEVEL9K_SHORTEN_STRATEGY="truncate_middle"
POWERLEVEL9K_SHORTEN_DIR_LENGTH=2
POWERLEVEL9K_IGNORE_TERM_COLORS=true

POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(time context vi_mode dir vcs)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status battery load)

# Setting up dircolors according to https://github.com/Anthony25/gnome-terminal-colors-solarized
eval `dircolors ~/dev/gnome-terminal-colors-solarized/dircolors`

# Uncomment the following line if pasting URLs and other text is messed up.
DISABLE_MAGIC_FUNCTIONS=true

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

export FZF_BASE="$HOME/.fzf"

# oh-my-zsh plugins
plugins=(zsh-syntax-highlighting git fzf)
source $ZSH/oh-my-zsh.sh

# reinforce the default shell when tmux'ing
export SHELL='/bin/zsh'

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# User configuration

####################
# VIM Mode settings
####################

## VIM everywhere!!!
bindkey -v

# for some reason VI mode interferes with FZF commands
bindkey "^R" fzf-history-widget
bindkey "^T" fzf-file-widget
bindkey "^I" fzf-completion
bindkey "^[c" fzf-cd-widget

## Better searching in command mode
bindkey -M vicmd '?' history-incremental-search-backward
bindkey -M vicmd '/' history-incremental-search-forward

# Beginning search with arrow key
bindkey "^[OA" up-line-or-beginning-search
bindkey "^[OB" down-line-or-beginning-search
bindkey -M vicmd "k" up-line-or-beginning-search
bindkey -M vicmd "j" down-line-or-beginning-search

# vim-like editor opening
bindkey -M vicmd "^V" edit-command-line

# avoid retyping bindkey everytime
precmd() { RPROMPT="" }

# make vi mode transition faster
export KEYTIMEOUT=1


# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Vim is my editor. Period.
export EDITOR='vim'
export MYVIMRC=~/.vimrc

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
DEFAULT_USER=$USER
prompt_context(){}

# allowing git on go get
export GIT_TERMINAL_PROMPT=1

# Some useful alias
alias vi='/usr/bin/vim'
# Alias for dotfile tracking
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
alias config='/usr/bin/git --git-dir=/home/elio/.cfg/ --work-tree=/home/elio'
# fixing the backspace problem
stty erase '^?'

# Use ripgrep by default with FZF
export FZF_DEFAULT_COMMAND='rg --files --ignore .git -g "" --hidden'

# Find in file using rg and fzf
fif() {
  rg --files-with-matches --no-messages $1 | fzf --preview "highlight -O ansi -l {} 2> /dev/null | rg --colors 'match:bg:yellow' --ignore-case --pretty --context 10 $1 || rg --ignore-case --pretty --context 10 $1 {}"
}

# this sets the locale of LC_ALL locally for alacritty to behave on Weyland
export LC_ALL=en_US.UTF-8

export GOPATH=/home/elio/go
export GOBIN=$GOPATH/bin
export PATH=$GOBIN:$PATH

# Prevent <C-s> to freeze VIM
alias vim="stty stop '' -ixoff ; vim"
alias tmux="TERM=screen-256color tmux -2"

source ~/.radiorc
export TOKEN=822396c9-3133-4f35-987a-51f2eda97843


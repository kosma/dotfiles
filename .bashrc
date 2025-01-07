# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

################################################################################
# Undo global configuration
################################################################################

complete -r
unset command_not_found_handle

################################################################################
# Configure shell
################################################################################

# autoupdate COLUMNS/LINES
shopt -s checkwinsize

# ignore spaces, duplicates and fgs
export HISTCONTROL=ignoreboth
export HISTIGNORE='fg*'
export HISTSIZE=10000
export HISTFILESIZE=10000

# ignore common junk
export FIGNORE='.o:~'

if [[ "$OSTYPE" == darwin* ]]; then
    alias df='df -h'
    export LS_OPTIONS='-FG'
else
    alias df='df -h -xtmpfs -xdevtmpfs -xdebugfs -xsquashfs'
    export LS_OPTIONS='-F -T 0 --color=auto'
    if [ "$TERM" != "dumb" ]; then
        eval "`dircolors -b`"
    fi
fi
alias ls='ls $LS_OPTIONS'

# lesspipe
[ -x /usr/bin/lesspipe ] && eval "$(lesspipe)"

# generate default ~/.host_colors if nonexistent
if [[ ! -e ~/.host_colors ]]; then
    echo "B_USER=1"  >> ~/.host_colors
    echo "C_USER=37" >> ~/.host_colors
    echo "B_ROOT=1"  >> ~/.host_colors
    echo "C_ROOT=37" >> ~/.host_colors
    echo "B_HOST=1"  >> ~/.host_colors
    echo "C_HOST=37" >> ~/.host_colors
fi
source ~/.host_colors
# set prompt (with colors!)
PS1='\[\e[0;$((UID?B_USER:B_ROOT));$((UID?C_USER:C_ROOT))m\]${USER:-\u}\[\e[0;$B_HOST;${C_HOST}m\]@\h:\w\[\e[0;1;$(($??31:32))m\]\$\[\e[0m\] '
# set screen title
shopt -s compat42 2>/dev/null # don't expand the tilde. fucking bash authors
PROMPT_COMMAND='[[ "$TERM" == screen ]] && echo -ne "\\x1bk${SSH_CONNECTION:+$(hostname -s):}${PWD##*/}\\x1b\\"'

# Help Mercurial find itself in this dark, cruel BSD world.
export HOSTNAME

# Bind Ctrl-S to i-search.
stty -ixon

# Cache Buildroot downloads.
export BR2_DL_DIR=~/buildroot-downloads

# Screen on WSL2
export SCREENDIR=$HOME/.screen

# Use native symlinks on Windows
export MSYS="winsymlinks:nativestrict"

################################################################################
# Aliases
################################################################################

alias s='screen'
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
test -e /usr/share/mc/bin/mc.sh && source /usr/share/mc/bin/mc.sh

if type -p fortune >/dev/null; then
	echo
	[[ -e ~/.last-fortune ]] && mv -f ~/.last-fortune ~/.prev-fortune
	fortune -a | tee ~/.last-fortune
	echo
fi

[[ -r ~/.bashrc.local ]] && source ~/.bashrc.local

################################################################################
: this line must come last
################################################################################

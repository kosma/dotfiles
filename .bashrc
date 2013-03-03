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
export HISTIGNORE='fg'

# generate 
if [ "$TERM" != "dumb" ]; then
    eval "`dircolors -b`"
fi

# 
export LS_OPTIONS='-F -T 0 --color=auto'
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
PS1='\[\e[0;$((UID?B_USER:B_ROOT));$((UID?C_USER:C_ROOT))m\]\u\[\e[0;$B_HOST;${C_HOST}m\]@\h:\w\[\e[0;1;$(($??31:32))m\]\$\[\e[0m\] '
# set screen title
PROMPT_COMMAND='[[ "$TERM" == screen ]] && echo -n -e "\033k$PWD\033\0134"'

################################################################################
# Aliases
################################################################################

alias a='sudo aptitude'
alias as='aptitude search'
alias ash='aptitude show'
alias ai='sudo aptitude install'
alias df='df -h -xtmpfs -xdevtmpfs -xdebugfs'
alias s='screen'
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
test -e /usr/share/mc/bin/mc.sh && source /usr/share/mc/bin/mc.sh
alias g='geeqie'
alias S='sudo -i'
alias i='ipython'

if type -p fortune >/dev/null; then
	echo
	[[ -e ~/.last-fortune ]] && mv -f ~/.last-fortune ~/.prev-fortune
	fortune -a | tee ~/.last-fortune
	echo
fi

################################################################################
: this line must come last
################################################################################

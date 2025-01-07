# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi

# set PATH so it includes sbin if it doesn't already
if [ "$PATH" != *sbin* ]; then
    PATH="/usr/local/sbin:/usr/sbin:/sbin:$PATH"
fi

# set PATH so it includes user's private bin if it exists
mkdir -p ~/.local/bin
PATH="$HOME/.local/bin:$PATH"

# make sure the GnuPG folder exists in any case
mkdir -m 700 -p ~/.gnupg

# Special handling under Git Bash
if [[ "$EXEPATH" == 'C:\Program Files\Git' ]]; then
	# Git Bash starts in / by default; navigate to $HOME instead
	if [[ "$PWD" == "/" ]]; then
		cd
	fi

	# Start gpg-agent and set the variable for automatic Yubikey handling
	gpg-connect-agent -q /bye
	export SSH_AUTH_SOCK="`gpgconf --list-dirs agent-ssh-socket`"
fi

# Special handling under WSL2
if [[ "$WSL_DISTRO_NAME" == "Ubuntu" ]]; then
	# Start gpg-agent bridge
	source dwa-socaty-szczepione-dupami.sh
fi

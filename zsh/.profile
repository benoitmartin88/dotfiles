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

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ]; then
	PATH="$HOME/bin:$PATH"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ]; then
	PATH="$HOME/.local/bin:$PATH"
fi

# Guix
if [ -f "$HOME/.guix-profile" ]; then
	export GUIX_PROFILE="$HOME/.guix-profile"
	source "$GUIX_PROFILE/etc/profile"
fi

if [ -n "$GUIX_ENVIRONMENT" ]; then
    # handle multiline prompt when there are lots of packages
    NB_PKGS=$(guix package -p $GUIX_ENVIRONMENT -I | wc -l)
    NB_PKG_PER_LINE=5
    PKGS=($(guix package -p $GUIX_ENVIRONMENT -I | cut -f1 | tr -d '\t ' | tr '\n' ' '))

    PROMPT="${PKGS[@]:0:$NB_PKG_PER_LINE}"
    index=$NB_PKG_PER_LINE
    while [[ $index -lt ${#PKGS[@]} ]]; do
        PROMPT="$PROMPT\n${PKGS[@]:$index:$NB_PKG_PER_LINE}"
        index=$((index + NB_PKG_PER_LINE))
    done

#    export PS1="[`guix package -p $GUIX_ENVIRONMENT -I | cut -f1 | head -n 5 | tr -d '\t ' | tr '\n' ' ' | sed -e 's/ *$//'`]> "
    export PS1="[$(echo $PROMPT)]> "
fi

export EDITOR=vim

# Added by Toolbox App
export PATH="$PATH:/local/home/bm277180/.local/share/JetBrains/Toolbox/scripts"
export PATH="$PATH:/opt/wine-stable/bin/"

export TERM=xterm

alias nvim="guix shell neovim python node rust rust-cargo nss-certs ripgrep gcc-toolchain clang -- nvim"
alias podman="guix shell podman -- podman"
alias powersave="sudo cpupower frequency-set --governor powersave"
alias docker="podman"
alias stow="guix shell stow -- stow"
alias vlc="guix shell vlc -- vlc"
alias fb="guix shell go -- go install github.com/danielmiessler/fabric@latest && GOPATH=$HOME/go PATH=$GOPATH/bin:$GOROOT/bin:$PATH fabric"


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

# Spack
if [ -d "$HOME/opt/spack/bin" ]; then
    . $HOME/opt/spack/share/spack/setup-env.sh
fi

if [ -n "$GUIX_ENVIRONMENT" ]; then
    export PS1="[`guix package -p $GUIX_ENVIRONMENT -I | cut -f1 | head -n 5 | tr -d '\t ' | tr '\n' ' ' | sed -e 's/ *$//'`]> "
fi

export EDITOR=vim
export TERM=xterm
export BORG_PASSCOMMAND='pass show backup/borg'

export PATH="$HOME/bin:$PATH"
# Added by Toolbox App
export PATH="$HOME/.local/share/JetBrains/Toolbox/scripts:$PATH"
# opencode
export PATH="$HOME/.opencode/bin:$PATH"

alias nvim="guix shell neovim luarocks fzf python node rust nss-certs ripgrep gcc-toolchain clang curl openmpi-c++ cmake cmakelang -- nvim"
alias podman="guix shell podman -- podman"
#alias powersave="sudo cpupower frequency-set --governor powersave"
alias docker="podman"
alias fabric="podman run --rm -it -v $HOME/.config/fabric:/root/.config/fabric ghcr.io/ksylvan/fabric:latest"
alias fb="fabric"
alias jupyter="guix shell python-notebook graphviz python-dask python-distributed python-graphviz python-ipywidgets python-bokeh python-ray -- jupyter"
alias notebook="jupyter notebook"
alias oc="opencode"
alias ollama-start="podman run --rm -d -v ollama:/root/.ollama -p 11434:11434 --name ollama --gpus all ollama/ollama"
alias ollama="podman exec -it ollama ollama"


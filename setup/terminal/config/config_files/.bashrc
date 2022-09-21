#!/bin/bash


# Display ######################################################################
export TERM='xterm-256color'
export BASH_SILENCE_DEPRECATION_WARNING=1

# Python #######################################################################
[ -f ~/.pystartup.py ] && export PYTHONSTARTUP=~/.pystartup.py

# Test if virtualenvwrapper.sh path is a non-zero-length string
[ ! -z $(which virtualenvwrapper.sh) ] && source $(which virtualenvwrapper.sh)

# Vim ##########################################################################
# Ctrl-Q defaults to Bash's "stty start" signal; this interferes with Vim mappings
# (Terminal intercepts signal)
stty start undef

# Powerline Configuration ######################################################
# Repo: https://github.com/b-ryan/powerline-shell

function _update_ps1() {
	if [[ ! -z $(which powerline-shell) ]]; then
		PS1=$(powerline-shell $?)
	fi
}

if [[ $TERM != linux && ! $PROMPT_COMMAND =~ _update_ps1 ]]; then
    PROMPT_COMMAND="_update_ps1; $PROMPT_COMMAND"
fi

# FZF Confguration #############################################################
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# Helper Functions #############################################################
dev-template() {
	# Sets up two windows:
	# .. 1: 3 panes with a primary pain and 2 secondary panes underneath
	# .. 2: 4 panes with a "tiled" layout
	SESSION_NAME=TEMPLATE
	tmux new -d -s ${SESSION_NAME} -n wrkspace -x - -y -
	tmux splitw -v -p 15
	tmux send 'echo "${SESSION_NAME} Window 1 - Pane 0"' C-m
	tmux splitw -h
	tmux send 'echo "${SESSION_NAME} Window 1 - Pane 1"' C-m
	tmux neww -t ${SESSION_NAME}:2 -n bg_procs
	tmux send -t ${SESSION_NAME}:2 'echo "${SESSION_NAME} Window 2 - Pane 0"' C-m
	tmux splitw -v
	tmux send 'echo "${SESSION_NAME} Window 2 - Pane 1"' C-m
	tmux splitw -v
	tmux send 'echo "${SESSION_NAME} Window 2 - Pane 2"' C-m
	tmux splitw -v
	tmux send 'echo "${SESSION_NAME} Window 2 - Pane 3"' C-m
	tmux select-layout tiled
	tmux selectp -t ${SESSION_NAME}:1.1
	tmux send -t ${SESSION_NAME}:1.0 'echo "${SESSION_NAME} Window 1 - Pane 1"' C-m
	tmux resizep -Z -t ${SESSION_NAME}:1.0  # Allows us to quick-switch to the bash shell
	tmux -2 attach -t ${SESSION_NAME}:1.0
	unset SESSION_NAME
}

dev-vertical-half() {
	tmux new -d ${2:+-s} ${2:-} -n wrkspace -x - -y -
	if [[ ! -z ${1:+x} ]]; then
		tmux send "clear; $1" C-m
	fi
	tmux splitw -h
	# tmux resizep -Z -t ${2:-}${2:+:}1.0
	tmux -2 attach -t ${2:-}${2:+:}1.0
}

alias dev-v=dev-vertical-half

connect-to-existing-session() {
	if tmux has-session -t $1; then
		tmux attach-session -t $1
		return 0
	else
		return 1
	fi
}

dev-dot() {
	SESSION_NAME=dot
	if ! connect-to-existing-session ${SESSION_NAME}; then
		cd ~/dotfiles
		dev-vertical-half '' ${SESSION_NAME}
	fi
	unset SESSION_NAME
}

dev-penny() {
	SESSION_NAME=pennyworth
	if ! connect-to-existing-session ${SESSION_NAME}; then
		cd ~/Development/pennyworth
		tmux new-session -d -s ${SESSION_NAME} -n wrkspace -x - -y -
		tmux splitw -h
		tmux new-window -t ${SESSION_NAME}:2 -n bg_procs
		tmux -2 attach -t ${SESSION_NAME}:1
	fi
	unset SESSION_NAME
}

# Open an instance of Chrome that opens up a remote debug port
chrome-debug() {
	SESSION_NAME=chrome-debug
	if ! connect-to-existing-session ${SESSION_NAME}; then
		tmux new-session -d -s ${SESSION_NAME} -n wrkspace -x - -y -
		tmux send-keys -t ${SESSION_NAME}:1.0 \
			'/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome --remote-debugging-port=9229' C-m
	fi
	unset SESSION_NAME
}

map-network() {
	ifconfig | grep broadcast | arp -a
}

gm-wip() {
	git add -A && git commit -m "[WIP] ${1:-Reset Branch when resuming work}" -n
}

branch-backup() {
	CURR_BRANCH=$(git rev-parse --abbrev-ref HEAD)
	git branch -D ${CURR_BRANCH}-BACKUP
	git checkout -b ${CURR_BRANCH}-BACKUP
	git checkout -
	unset CURR_BRANCH
}

# Config Variables #############################################################
# Private config variables sourced externally
[ -f ~/.configvar.sh ] && . ~/.configvar.sh

# Install snow theme
[ -n "$PS1" ] && [ -f ~/.vim/plugged/snow/shell/snow_dark.sh ] && sh ~/.vim/plugged/snow/shell/snow_dark.sh

# dircolors doesn't exist on OSX's distribution of bash
# eval `dircolors ~/.vim/plugged/snow/shell/dircolors`

# Navigation Aliases ###########################################################
alias ls="ls -Al"						# List all files (incl. hidden)

# Do not include an alias for '.' (shortcut for source)
# Go up a directory
alias ..='cd ..'
# Go up 2 directories
alias ...='cd ../..'
# Go up 3 directories
alias ....='cd ../../..'
# Go back a directory
alias bk='cd -'

# Git Aliases ##################################################################
alias gls="git log --oneline --graph"
alias gtree="git log --graph --all"
alias ga="git add -A"
alias gap="git add -Ap"
alias gm="git commit -m"
alias gb="git branch"
alias gd="git diff"
alias gdc="git diff --cached"
alias gco="git checkout"
alias gc="git clone"
alias gr="git remote -v"
alias gp="git push"
alias gpu="git pull"
alias gs="git status"
alias gst="git stash"
alias gmbase="git merge-base"
alias grbase="git rebase -i --committer-date-is-author-date --keep-empty --autosquash"
alias gstd="git stash drop"
alias gstls="git stash list"
alias gstap="git stash apply"

# General Aliases ##############################################################
alias .b=". ~/.bash_profile"
alias cl="clear"
alias ls="ls -AGFl"

# Private Aliases ##############################################################
[ -f ~/.privaliases.sh ] && source ~/.privaliases.sh #}}}

# Fun stuff ####################################################################
flip() {
  echo;
  echo -en "( º_º）  ┬─┬   \r"; sleep .5;
  echo -en " ( º_º） ┬─┬   \r"; sleep .5;
  echo -en "  ( ºДº）┬─┬   \r"; sleep .5;
  echo -en "  (╯'Д'）╯︵⊏   \r"; sleep .3;
  echo -en "  (╯'□'）╯︵ ⊏  \r"; sleep .3;
  echo     "  (╯°□°）╯︵ ┻━┻"; sleep .3;
}

# PyEnv Setup ##################################################################
# (The below instructions are intended for common
# shell setups. See the README for more guidance
# if they don't apply and/or don't work for you.)

# Add pyenv executable to PATH and
# enable shims by adding the following
# to ~/.profile:

# export PYENV_ROOT="$HOME/.pyenv"
# export PATH="$PYENV_ROOT/bin:$PATH"
# eval "$(pyenv init --path)"

# If your ~/.profile sources ~/.bashrc,
# the lines need to be inserted before the part
# that does that. See the README for another option.

# If you have ~/.bash_profile, make sure that it
# also executes the above lines -- e.g. by
# copying them there or by sourcing ~/.profile

# Load pyenv into the shell by adding
# the following to ~/.bashrc:

# eval "$(pyenv init -)"

# Make sure to restart your entire logon session
# for changes to profile files to take effect.
# Edit Commands ################################################################
# set -o vi
# set editing-mode vi
# set keymap vi-command

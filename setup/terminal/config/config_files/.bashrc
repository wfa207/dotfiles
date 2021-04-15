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
dev_template() {
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

dev_vertical_half() {
	tmux new -d ${2:+-s} ${2:-} -n wrkspace -x - -y -
	if [[ ! -z ${1:+x} ]]; then
		tmux send "clear; $1" C-m
	fi
	tmux splitw -h
	# tmux resizep -Z -t ${2:-}${2:+:}1.0
	tmux -2 attach -t ${2:-}${2:+:}1.0
}

alias dev="dev_vertical_half"

dev_dot() {
	cd ~/dotfiles
	dev_vertical_half '' dot
}

alias dev-dot="dev_dot"

dev_penny() {
	SESSION_NAME=pennyworth
	cd ~/Development/pennyworth
	tmux new-session -d -s ${SESSION_NAME} -n wrkspace -x - -y -
	tmux splitw -h
	tmux new-window -t ${SESSION_NAME}:2 -n bg_procs
	tmux -2 attach -t ${SESSION_NAME}:1
}

alias dev-penny="dev_penny"

# Open an instance of Chrome that opens up a remote debug port
chrome_debug() {
	SESSION_NAME=chrome_debug
	tmux new-session -d -s ${SESSION_NAME} -n wrkspace -x - -y -
	tmux send-keys -t ${SESSION_NAME}:1.0 '/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome --remote-debugging-port=9229' C-m
}
alias chrome-debug=chrome_debug

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
alias gls="clear; git log"
alias gtree="clear; git log --graph --all"
alias ga="clear; git add -A"
alias gap="clear; git add -Ap"
alias gm="clear; git commit -m"
alias gb="clear; git branch"
alias gd="clear; git diff"
alias gdc="clear; git diff --cached"
alias gco="clear; git checkout"
alias gc="clear; git clone"
alias gr="clear; git remote -v"
alias gp="clear; git push"
alias gpu="clear; git pull"
alias gs="clear; git status"
alias gst="clear; git stash"
alias gmbase="clear; git merge-base"
alias grbase="clear; git rebase -i"
alias gstd="clear; git stash drop"
alias gstls="clear; git stash list"
alias gstap="clear; git stash apply"

# General Aliases ##############################################################
alias .b=". ~/.bashrc"
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

# Edit Commands ################################################################
set -o vi
set editing-mode vi
set keymap vi-command
#!/bin/bash
# Constants / Helper Functions ===================================================={{{

# Preserve the directory, agnostic of where script is run from
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"

# Save PARENT_DIR for clean-up later on
PARENT_DIR="$(dirname ${DIR})"

# Print options
PRINT_COLOR="\e[1;36;49m"
DEFAULT_COLOR="\e[0m"

INDENT="    "

# Setup pretty_print function
. ${DIR}/helper_scripts/pretty_print.sh

# }}}
# =================================================================================
# Library Installation ============================================================{{{

# Install brew first
if [ -z $(which brew) ]; then
	pretty_print "Installing Brew\n"
	/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
	pretty_print "Finished installing Brew\n"
fi

pretty_print "Updating Brew and bundling packages\n"
brew update
brew bundle
pretty_print "Finished updating Brew and bundling packages\n"

# Tmux ============================

# Install Tmux
if [ -z $(which tmux) ]; then 
	pretty_print "Installing Tmux\n"
	brew install tmux
	pretty_print "Finished installing Tmux\n"
fi

# Install Tmux Plugin Manager
if [ ! -e ~/.tmux/plugins/tpm ]; then
	pretty_print "Installing Tmux Plugin Manager\n"
	git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
	pretty_print "Installing Tmux Plugin Manager\n"
fi

# Install powerline fonts
pretty_print "Installing powerline fonts\n"
git clone https://github.com/powerline/fonts.git --depth=1
cd fonts
./install.sh

cd ..
rm -rf fonts # Clean-up
pretty_print "Finished installing powerline fonts\n"

# Vim =============================

# Install Homebrew's version of Vim
if [ $(which vim) != "/usr/local/bin/vim" ]; then
	pretty_print "Installing latest version of Vim\n"
	brew install vim
	pretty_print "Finished installing latest version of Vim\n"
fi


# Install Vim plug-in manager
if [ ! -e ~/.vim/autoload/plug.vim ]; then
	pretty_print "Installing Vim-Plug\n"
	curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	pretty_print "Finished installing Vim-Plug\n"
fi

if [ -z $(which bat) ]; then
	pretty_print "Installing Bat for Syntax-Highlighting in FZF preview\n"
	brew install bat
	pretty_print "Finished installing Bat\n"
fi

# Python Development =============

pretty_print "Installing Python CLI libraries\n"
if [ -z $(which pip) ]; then
	pretty_print "${INDENT}Installing PIP - Python's package manager\n"
	brew install pip
	pretty_print "${INDENT}Finished installing PIP\n"
fi

if [ -z $(which pyenv) ]; then
	pretty_print "${INDENT}Installing PyEnv - Python's version manager\n"
	brew install pyenv
	pretty_print "${INDENT}Finished installing PyEnv\n"
fi

if [ -z $(which pipenv) ]; then
	pretty_print "${INDENT}Installing PipEnv - A utility that manages Python virtual environments in conjunction with versions\n"
	pip install -U pip pipenv
	pretty_print "${INDENT}Finished installing PipEnv\n"
fi
pretty_print "Finished installing Python CLI libraries\n"

# Install powerline-shell
# Note: This doesn't *really fit here* but requires pip (installed in the previous step)
if [ -z $(which powerline-shell) ]; then
	pretty_print "${INDENT}Installing powerline-shell\n"
	pip install powerline-shell
	pretty_print ${INDENT}"Finished installing powerline-shell\n"
fi


# Javascript Development ==========

pretty_print "Installing Javascript CLI libraries\n"
if [ -z $(which node) ]; then
	pretty_print "${INDENT}Installing Node\n"
	brew install node
	pretty_print "${INDENT}Finished installing Node\n"
fi

if [ -z $(which npm) ]; then
	pretty_print "${INDENT}Installing NPM - Javascript's Package Manager\n"
	brew install npm
	pretty_print "${INDENT}Finished installing NPM\n"
fi

NVM_DIR=${NVM_DIR:=$HOME/.nvm}
if [ ! -s "$NVM_DIR/nvm.sh" ]; then
	pretty_print "${INDENT}Installing NVM - Javascript's Version Manager\n"
	[ -e /usr/local/Cellar/nvm ] && brew uninstall nvm
	[ ! -e $NVM_DIR ] && mkdir -p $NVM_DIR
	curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.34.0/install.sh | bash
	pretty_print "${INDENT}Finished installing NVM\n"
fi

if [ -z $(which yarn) ]; then
	pretty_print "${INDENT}Installing yarn - Javascript's Dependency Manager\n"
	brew install yarn --ignore-dependencies
	pretty_print "${INDENT}Installing yarn\n"
fi
pretty_print "Finished installing Javascript CLI libraries\n"


pretty_print "Installing language servers for code introspection"
pretty_print "At the moment, the following languages are supported
    * Python
    * Javascript\n"
# Install python language server for Python introspection
pip install jedi python-language-server

# Install typescript for JS introspection
npm install -g typescript

pretty_print "Finished installing language servers\n"

# }}}
# =================================================================================
# Create Sym Links ================================================================{{{

# Create sym links for needed files
. ${DIR}/setup_scripts/write_sym_links.sh

# Install vim plug-ins
pretty_print "Installing Vim plug-ins\n"
vim +PlugInstall +PlugUpdate +qall
pretty_print "Finished installing Vim plug-ins\n"

# Compile YouCompleteMe libraries for Vim
pretty_print "Installing YouCompleteMe Libraries for Vim\n"
cd ~/.vim/plugged/YouCompleteMe
./install.py
pretty_print "Finished installing YouCompleteMe Libraries for Vim\n"

# }}}
# =================================================================================
# Clean-up ========================================================================{{{

pretty_print "~~~~~Finished Installation!~~~~~\n"
# Create sym links for needed files
unset DIR PARENT_DIR PRINT_COLOR DEFAULT_COLOR pretty_print
. ~/.bashrc
cd

# }}}
# =================================================================================

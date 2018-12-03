#!/bin/bash
# Constants / Helper Functions ===================================================={{{

# Preserve the directory, agnostic of where script is run from
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"

# Save PARENT_DIR for clean-up later on
PARENT_DIR="$(dirname ${DIR})"

# Print options
PRINT_COLOR="\e[1;36;49m"
DEFAULT_COLOR="\e[0m"

# Setup pretty_print function
. ${DIR}/helper_scripts/pretty_print.sh

# }}}
# =================================================================================
# Library Installation ============================================================{{{

# Install brew first
[ -z $(which brew) ] &&
	/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

brew update
brew bundle

# Install Tmux Plugin Manager
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# Install powerline-shell
pretty_print "Installing powerline-shell\n"
git clone https://github.com/b-ryan/powerline-shell
cd powerline-shell
PATH=/usr/local/opt/python/libexec/bin:/usr/local/bin:/usr/bin python setup.py install

# Clean-up
cd ..
rm -rf powerline-shell
pretty_print "Finished installing powerline-shell"

# Install powerline fonts
pretty_print "Installing powerline fonts\n"
git clone https://github.com/powerline/fonts.git --depth=1
cd fonts
./install.sh

# Clean-up
cd ..
rm -rf fonts
pretty_print "Finished installing powerline fonts"

# Install Vim plug-in manager
pretty_print "Installing Vim-Plug, to get plug-ins in Vim\n"
curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
pretty_print "Finished installing Vim-Plug"

pretty_print "Installing language servers for code introspection"
pretty_print "At the moment, the following languages are supported
    * Python
    * Javascript\n"
# Install python language server for Python introspection
pip install jedi python-language-server

# Install typescript for JS introspection
npm install -g typescript

pretty_print "Finished installing language servers\n"

# Compile YouCompleteMe libraries for Vim
cd ~/.vim/plugged/YouCompleteMe
./install.py

# }}}
# =================================================================================
# Create Sym Links ================================================================{{{

# Create sym links for needed files
. ${DIR}/setup_scripts/make_sym_links.sh

# Install vim plug-ins
pretty_print "Installing Vim plug-ins\n"
vim +PlugInstall +qall
pretty_print "Finished installing Vim plug-ins\n"

# }}}
# =================================================================================
# Clean-up ========================================================================{{{

# Create sym links for needed files
unset DIR PARENT_DIR PRINT_COLOR DEFAULT_COLOR pretty_print
cd

# }}}
# =================================================================================

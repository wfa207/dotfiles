# Startup Vars #################################################################
[ -s "$HOME/.startup.sh" ] && . "$HOME/.startup.sh"

# Setup ########################################################################
# Load bashrc if one exists
[ -f ~/.bashrc ] && . ~/.bashrc

# Load bash completion
[ -f `brew --prefix`/etc/bash_completion ] && . `brew --prefix`/etc/bash_completion

# Python #######################################################################
# Initialize pyenv when a new shell spawns
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi

# Modify path for Python's poetry dependency management system
export PATH="$HOME/.poetry/bin:$PATH"

# Node / React #################################################################
export NVM_DIR=${NVM_DIR:=$HOME/.nvm}

# This loads nvm
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
# This loads nvm bash_completion
[ -s "$NVM_DIR/bash_completion" ] && . "$NVM_DIR/bash_completion"
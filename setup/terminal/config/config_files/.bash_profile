# Startup Vars #################################################################
[ -s "$HOME/.startup.sh" ] && . "$HOME/.startup.sh"

# Setup ########################################################################
# Load bashrc if one exists
# [ -f ~/.bashrc ] && . ~/.bashrc

# Load bash completion
[ -f `brew --prefix`/etc/bash_completion ] && . `brew --prefix`/etc/bash_completion

# Python #######################################################################
# Modify path for Python's poetry dependency management system
export PATH="$HOME/.poetry/bin:$PATH"

# Add pyenv executable to PATH and
# enable shims
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"

if command -v pyenv 1>/dev/null 2>&1; then
  # Initialize pyenv when a new shell spawns
  eval "$(pyenv init --path)"
fi

# Postgres #####################################################################
export PATH="/usr/local/opt/libpq/bin:$PATH"

# Node / React #################################################################
export NVM_DIR=${NVM_DIR:=$HOME/.nvm}

# This loads nvm
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
# This loads nvm bash_completion
[ -s "$NVM_DIR/bash_completion" ] && . "$NVM_DIR/bash_completion"

test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"

# BEGIN ANSIBLE MANAGED BLOCK
if [ -r ~/.bashrc ]; then
   source ~/.bashrc
fi
# END ANSIBLE MANAGED BLOCK

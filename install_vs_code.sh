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
# VS Code Installation ==========================================================={{{

if [ ! -e "/Applications/Visual Studio Code.app" ]; then
	pretty_print "${INDENT}No Visual Studio Code App detected; Installing\n"
	curl -L https://update.code.visualstudio.com/latest/darwin/stable -o ~/Downloads/VSCode-temp.zip
	unzip ~/Downloads/VSCode-temp.zip -d /Applications
	rm ~/Downloads/VSCode-temp.zip
	pretty_print "Finished installing Visual Studio Code\n"
fi

pretty_print "Finished installing Visual Studio Code"

pretty_print "${INDENT}Loading Visual Studio Code settings.json"

if [ ! -L "$HOME/Library/Application Support/Code/User/settings.json" ]; then
	ln -Fhs "${DIR}/vs_code/settings.json" ~/Library/Application\ Support/Code/User/settings.json
fi

pretty_print "Finished loading Visual Studio Code settings.json"

pretty_print "${INDENT}Loading Visual Studio Code keybindings.json"

if [ ! -L "$HOME/Library/Application Support/Code/User/keybindings.json" ]; then
	ln -Fhs "${DIR}/vs_code/keybindings.json" ~/Library/Application\ Support/Code/User/keybindings.json
fi

pretty_print "Finished loading Visual Studio Code keybindings.json"

pretty_print "${INDENT}Installing VS Code Dependencies & Extensions"

for ext_name in $(cat "${DIR}/vs_code/extensions.txt");
do 
	code --install-extension $ext_name
done

defaults write com.microsoft.VSCode ApplePressAndHoldEnabled -bool false         # For VS Code
defaults write com.microsoft.VSCodeInsiders ApplePressAndHoldEnabled -bool false # For VS Code Insider
defaults delete -g ApplePressAndHoldEnabled                                      # If necessary, reset global default

pretty_print "Finished installing VS Code Dependencies & Extensions"

# }}}
# =================================================================================
# Clean-up ========================================================================{{{

pretty_print "~~~~~Finished Installation!~~~~~\n"
# Create sym links for needed files
unset DIR INDENT PARENT_DIR PRINT_COLOR DEFAULT_COLOR pretty_print ext_name
. ~/.bashrc

# }}}
# =================================================================================

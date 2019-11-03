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
	curl -L --create-dirs -o ~/Downloads/VSCode-temp.zip https://update.code.visualstudio.com/latest/darwin/stable
	unzip ~/Downloads/VSCode-temp.zip -d /Applications
	rm ~/Downloads/VSCode-temp.zip
	pretty_print "Finished installing Visual Studio Code\n"
else 
	pretty_print "Visual Studio Code is already installed; skipping"
fi

if [ ! -e "$HOME/.vscode/css/synthwave84.css" ]; then
	pretty_print "${INDENT}No Theme CSS detected; Installing\n"
	curl -L -o ~/.vscode/css/synthwave84.css --create-dirs https://raw.githubusercontent.com/robb0wen/synthwave-vscode/master/synthwave84.css
	pretty_print "Finished installing CSS theme\n"
fi

pretty_print "Finished installing Visual Studio Code"

for src_object_path in "${DIR}/vs_code"/*; do

	# Get name of object
	object_name=$(basename "${src_object_path}")

	pretty_print "${INDENT}Loading Visual Studio Code ${object_name}"

	if [ ! -L "$HOME/Library/Application Support/Code/User/${object_name}" ]; then
		ln -Fhs $src_object_path ~/Library/Application\ Support/Code/User/${object_name}
		pretty_print "Finished loading Visual Studio Code ${object_name}"
	else 
		pretty_print "Visual Studio Code ${object_name} already exists; skipping"
	fi

done

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
unset DIR INDENT PARENT_DIR PRINT_COLOR DEFAULT_COLOR pretty_print ext_name src_object_path object_name
. ~/.bashrc

# }}}
# =================================================================================

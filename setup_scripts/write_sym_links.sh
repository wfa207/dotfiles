#!/bin/bash

# Preserve the directory, agnostic of where script is run from
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"

# Get our project directory (assumes one level up)
PROJ_DIR=$( dirname $DIR )

# Source pretty_print helper
. ${PROJ_DIR}/helper_scripts/pretty_print.sh

pretty_print "Writing sym links"

# Dot Files ============================================================

# (Assumes our files are located in the ./src dir)
SRC_FILE_DIR="${PROJ_DIR}/src"

# Write powerline-shell config sym link
# Separate from others; does *not* go directly in home (~) directory
mkdir -p ~/.config/powerline-shell
ln -Fhs "${SRC_FILE_DIR}/powerline-config.json" ~/.config/powerline-shell/config.json
pretty_print "Wrote powerline-config sym link"

# Write dotfile sym links that belong in home (~) directory
for abs_file_path in "${SRC_FILE_DIR}"/*; do

	# Get base file name (without path)
	base_name=$(basename "${abs_file_path}")

	# Don't write the powerline-config file to our home directory
	# Handled separately above
	if [[ ! $base_name == *"powerline-config"* ]]; then
		ln -Fhs ${abs_file_path} ~/.${base_name}
		pretty_print "Wrote ${base_name} sym link"
	fi
done

pretty_print "Wrote powerline-config sym link"

# UltiSnips ============================================================

SNIPPET_FILE_DIR="${PROJ_DIR}/snippets"

mkdir -p ~/.vim/my_snippets
pretty_print "Created snippets directory in vim directory"

for abs_file_path in "${SNIPPET_FILE_DIR}"/*; do

	# Get base file name (without path)
	base_name=$(basename "${abs_file_path}")

	ln -Fhs ${abs_file_path} ~/.vim/my_snippets/${base_name}
	pretty_print "Wrote ${base_name} sym link"

# Epilogue =============================================================

pretty_print "All sym links written.\n"

# Clean up namespace
unset file_name base_name DIR PROJ_DIR SRC_FILE_DIR SNIPPET_FILE_DIR pretty_print

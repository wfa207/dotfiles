pretty_print() {
	[ -z ${PRINT_COLOR} ] && export PRINT_COLOR="\e[1;36;49m"
	[ -z ${DEFAULT_COLOR} ] && export DEFAULT_COLOR="\e[0m"

	printf "\n${PRINT_COLOR}${1}${DEFAULT_COLOR}\n"
}

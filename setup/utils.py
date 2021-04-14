from setup.constants import TermColors


def clean_cli_input(raw_input):
    return raw_input.lower()


def print_formatted(msg=None, color=TermColors.DEFAULT):
    if msg is None:
        print()

    else:
        print(f"{color}{msg}{TermColors.END}")

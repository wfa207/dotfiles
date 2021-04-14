from setup.constants import TermColors
from setup.editors.vim import Vim
from setup.editors.vs_code import VSCode
from setup.utils import clean_cli_input, print_formatted


class EditorSetup:
    EDITOR_MAP = {
        "vim": Vim,
        "visual studio code": VSCode,
    }

    @classmethod
    def run(cls):
        print_formatted("Setting up your editor\n", TermColors.HEADER_1)

        while True:
            choice_indent = 2 * " "
            editor_choices = "\n".join(
                [
                    f"{choice_indent}* {editor_name.title()}"
                    for editor_name in cls.EDITOR_MAP.keys()
                ]
            )
            editor_choice_input_raw = input(
                f"{TermColors.INPUT}Please select an editor:\n{editor_choices}\n\n> {TermColors.END}"
            )

            # Insert blank line after input is entered
            print_formatted()

            editor_choice_input = clean_cli_input(editor_choice_input_raw)
            editor_choice = cls.EDITOR_MAP.get(editor_choice_input)

            if editor_choice is not None:
                editor_choice.setup()
                break

            else:
                print_formatted(
                    f"'{editor_choice_input_raw}' is not a valid choice\n",
                    TermColors.WARNING,
                )
                continue

        print_formatted("Successfully setup your editor\n", TermColors.HEADER_1)

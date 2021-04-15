from setup.editors.vim import Vim
from setup.editors.vs_code import VSCode
from setup.utils import Shell


class EditorSetup:
    EDITOR_MAP = {
        "vim": Vim,
        "visual studio code": VSCode,
    }

    @classmethod
    def run(cls):
        Shell.print_formatted("Setting up your editor\n", Shell.Colors.HEADER_1)

        while True:
            choice_indent = 2 * " "
            editor_choices = "\n".join(
                [
                    f"{choice_indent}* {editor_name.title()}"
                    for editor_name in cls.EDITOR_MAP.keys()
                ]
            )
            editor_choice_input_raw = input(
                f"{Shell.Colors.INPUT}Please select an editor:\n{editor_choices}\n\n> {Shell.Colors.END}"
            )

            # Insert blank line after input is entered
            Shell.print_formatted()

            editor_choice_input = Shell.clean_input(editor_choice_input_raw)
            editor_choice = cls.EDITOR_MAP.get(editor_choice_input)

            if editor_choice is not None:
                editor_choice.setup()
                break

            else:
                Shell.print_formatted(
                    f"'{editor_choice_input_raw}' is not a valid choice\n",
                    Shell.Colors.WARNING,
                )
                continue

        Shell.print_formatted("Successfully setup your editor\n", Shell.Colors.HEADER_1)

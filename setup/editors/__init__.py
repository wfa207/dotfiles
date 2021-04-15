from setup.editors.vim import Vim
from setup.editors.vs_code import VSCode
from setup.utils import Shell


class EditorSetup:
    class Editors:
        VS_CODE = "1"
        VIM = "2"

    class Editor:
        def __init__(self, display_name, setup_class):
            self.display_name = display_name
            self.setup_class = setup_class

    EDITOR_MAP = {
        Editors.VS_CODE: Editor("VS Code (default)", VSCode),
        Editors.VIM: Editor("Vim", Vim),
    }

    DEFAULT_EDITOR = Editors.VS_CODE

    @classmethod
    def run(cls):
        Shell.print_formatted("Setting up your editor\n", Shell.Colors.HEADER_1)

        choice_indent = 2 * " "
        editor_choices = "\n".join(
            [
                f"{choice_indent} * Input '{editor_num}' for {editor_obj.display_name}"
                for editor_num, editor_obj in cls.EDITOR_MAP.items()
            ]
        )
        editor_choice_input = Shell.await_input(
            f"Please select an editor:\n{editor_choices}\n\n> ",
            color=Shell.Colors.INPUT,
        )

        if editor_choice_input in cls.EDITOR_MAP.keys():
            editor_obj = cls.EDITOR_MAP[editor_choice_input]
            editor_obj.setup_class.setup()

        else:
            Shell.print_formatted(
                f"'{editor_choice_input}' is not a valid choice\n",
                Shell.Colors.WARNING,
            )

            editor_obj = cls.EDITOR_MAP[cls.DEFAULT_EDITOR]
            confirmed = Shell.confirm_choice(
                f"Do you want to install the default editor, {editor_obj.display_name}? [y/n]"
                "\n> ",
                affirmative_choice="y",
                color=Shell.Colors.INPUT,
            )

            if confirmed:
                editor_obj.setup_class.setup()

            else:
                Shell.print_formatted(
                    "Aborted setting up editor\n", color=Shell.Colors.FAILURE
                )
                return

        Shell.print_formatted("Successfully setup your editor\n", Shell.Colors.HEADER_1)

from setup.editors import EditorSetup
from setup.terminal import TerminalSetup
from setup.utils import Shell


class Setup:
    @classmethod
    def run(cls):
        Shell.print_formatted("Running setup script", Shell.Colors.HEADER_1)

        TerminalSetup.run()
        EditorSetup.run()
        # LanguageSetup.run()  # TODO: Uncomment when actually needed

        Shell.print_formatted("Successfully ran setup script", Shell.Colors.HEADER_1)

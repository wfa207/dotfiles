from setup.constants import TermColors
from setup.editors import EditorSetup
from setup.terminal import TerminalSetup
from setup.utils import print_formatted


class Setup:
    @classmethod
    def run(cls):
        print_formatted("Running setup script", TermColors.HEADER_1)

        TerminalSetup.run()
        EditorSetup.run()
        # LanguageSetup.run()  # TODO: Uncomment when actually needed

        print_formatted("Successfully ran setup script", TermColors.HEADER_1)

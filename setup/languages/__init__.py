from setup.languages.javascript import Javascript
from setup.languages.python import Python
from setup.utils import Shell


class LanguageSetup:
    @classmethod
    def run(cls):
        Shell.print_formatted("Setting up Language Support\n", Shell.Colors.HEADER_1)

        Python.setup()
        Javascript.setup()

        Shell.print_formatted("Setup Language Support\n", Shell.Colors.HEADER_1)

from setup.constants import TermColors
from setup.languages.javascript import Javascript
from setup.languages.python import Python
from setup.utils import print_formatted


class LanguageSetup:
    @classmethod
    def run(cls):
        print_formatted("Setting up Language Support\n", TermColors.HEADER_1)

        Python.setup()
        Javascript.setup()

        print_formatted("Setup Language Support\n", TermColors.HEADER_1)

from setup.constants import TermColors
from setup.terminal.config import Config as TerminalConfig
from setup.terminal.iterm import iTerm
from setup.terminal.powerline import Powerline
from setup.terminal.tmux import Tmux
from setup.utils import print_formatted


class TerminalSetup:
    @classmethod
    def run(cls):
        print_formatted("Setting up your terminal\n", TermColors.HEADER_1)

        TerminalConfig.setup()
        Powerline.setup()
        Tmux.setup()
        iTerm.setup()

        print_formatted("Successfully setup your terminal\n", TermColors.HEADER_1)

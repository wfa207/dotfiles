from setup.terminal.config import Config as TerminalConfig
from setup.terminal.iterm import iTerm
from setup.terminal.powerline import Powerline
from setup.terminal.tmux import Tmux
from setup.utils import Shell


class TerminalSetup:
    @classmethod
    def run(cls):
        Shell.print_formatted("Setting up your terminal\n", Shell.Colors.HEADER_1)

        TerminalConfig.setup()
        Powerline.setup()
        Tmux.setup()
        iTerm.setup()

        Shell.print_formatted(
            "Successfully setup your terminal\n", Shell.Colors.HEADER_1
        )

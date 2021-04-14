import os
import subprocess

from setup.constants import TermColors
from setup.utils import print_formatted


class iTerm:
    @classmethod
    def setup(cls):
        cls._verify_installation()
        cls._load_preferences()

    @classmethod
    def _verify_installation(cls):
        already_exists = os.path.exists(f"/Applications/iTerm.app")

        if not already_exists:
            print_formatted(
                "iTerm could not be found on your machine."
                "\nPlease refer to iTerm's website https://www.iterm2.com or contact"
                "your system administrator to determine how to install",
                TermColors.WARNING,
            )
            raise FileNotFoundError(
                "iTerm.app could not be found in the root 'Applications' folder"
            )

    @classmethod
    def _load_preferences(cls):
        print_formatted("Loading iTerm preferences\n", TermColors.HEADER_1)

        curr_file_dir = os.path.dirname(os.path.abspath(__file__))
        subprocess.call(
            [
                "defaults",
                "write",
                "com.googlecode.iterm2",
                "PrefsCustomFolder",
                f"{curr_file_dir}/config_files",
            ]
        )

        print_formatted("Loaded iTerm preferences\n", TermColors.HEADER_1)

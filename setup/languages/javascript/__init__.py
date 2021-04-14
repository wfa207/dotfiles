import os
import subprocess

from setup.constants import HOME_DIR, TermColors
from setup.utils import print_formatted


class Javascript:
    @classmethod
    def setup(cls):
        cls._install_dependencies()
        cls._install_version_managers()
        cls._install_utilities()

    @classmethod
    def _install_dependencies(cls):
        print_formatted("Installing Javascript dependencies\n", TermColors.HEADER_1)

        DEPENDENT_EXECUTABLES = [
            "node",
            "yarn",  # args: ["ignore-dependencies"]
        ]

        for executable_name in DEPENDENT_EXECUTABLES:
            # TODO: Should encapsulate installation method in case Brew unavailable
            subprocess.call(["brew", "install", executable_name])

        print_formatted("\nInstalled Javascript dependencies\n", TermColors.HEADER_1)

    @classmethod
    def _install_version_managers(cls):
        NVM_DIR = f"{HOME_DIR}/.nvm"
        print_formatted("Installing Javascript version managers\n", TermColors.HEADER_1)

        if not os.path.exists(NVM_DIR):
            if os.path.exists(f"/usr/local/Cellar/nvm"):
                subprocess.call(["brew", "uninstall", "nvm"])

        os.makedirs(NVM_DIR, exist_ok=True)
        subprocess.call(
            [
                "curl",
                "-o-",
                "https://raw.githubusercontent.com/creationix/nvm/v0.34.0/install.sh",
                "|",
                "bash",
            ]
        )

        print_formatted(
            "\nInstalled Javascript version managers\n", TermColors.HEADER_1
        )

    @classmethod
    def _install_utilities(cls):
        UTILITY_LIBRARIES = [
            "typescript",
        ]

        print_formatted("Installing Javascript utilities\n", TermColors.HEADER_1)

        subprocess.call(["npm", "install", "-g", *UTILITY_LIBRARIES]),

        print_formatted("\nInstalled Javascript utilities\n", TermColors.HEADER_1)

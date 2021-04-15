import os
import subprocess

from setup.constants import HOME_DIR
from setup.utils import Shell


class Javascript:
    @classmethod
    def setup(cls):
        cls._install_dependencies()
        cls._install_version_managers()
        cls._install_utilities()

    @classmethod
    def _install_dependencies(cls):
        Shell.print_formatted(
            "Installing Javascript dependencies\n", Shell.Colors.HEADER_1
        )

        DEPENDENT_EXECUTABLES = [
            "node",
            "yarn",  # args: ["ignore-dependencies"]
        ]

        for executable_name in DEPENDENT_EXECUTABLES:
            # TODO: Should encapsulate installation method in case Brew unavailable
            Shell.execute("brew", "install", executable_name)

        Shell.print_formatted(
            "\nInstalled Javascript dependencies\n", Shell.Colors.HEADER_1
        )

    @classmethod
    def _install_version_managers(cls):
        NVM_DIR = f"{HOME_DIR}/.nvm"
        Shell.print_formatted(
            "Installing Javascript version managers\n", Shell.Colors.HEADER_1
        )

        if not os.path.exists(NVM_DIR):
            if os.path.exists(f"/usr/local/Cellar/nvm"):
                Shell.execute("brew", "uninstall", "nvm")

        os.makedirs(NVM_DIR, exist_ok=True)
        Shell.execute(
            "curl",
            "-o-",
            "https://raw.githubusercontent.com/creationix/nvm/v0.34.0/install.sh",
            "|",
            "bash",
        )

        Shell.print_formatted(
            "\nInstalled Javascript version managers\n", Shell.Colors.HEADER_1
        )

    @classmethod
    def _install_utilities(cls):
        UTILITY_LIBRARIES = [
            "typescript",
        ]

        Shell.print_formatted(
            "Installing Javascript utilities\n", Shell.Colors.HEADER_1
        )

        Shell.execute("npm", "install", "-g", *UTILITY_LIBRARIES),

        Shell.print_formatted(
            "\nInstalled Javascript utilities\n", Shell.Colors.HEADER_1
        )

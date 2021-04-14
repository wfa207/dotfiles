import errno
import os
import shutil
import subprocess

from setup.constants import HOME_DIR, TermColors
from setup.utils import print_formatted


class Python:
    @classmethod
    def setup(cls):
        cls._install_dependencies()
        cls._install_package_managers()
        cls._install_language_versions()
        cls._install_utilities()
        cls._install_utility_scripts()

    @classmethod
    def _install_dependencies(cls):
        print_formatted("Installing Python dependencies\n", TermColors.HEADER_1)

        DEPENDENT_EXECUTABLES = [
            "pyenv",
            "python",
            "pip",
        ]

        for executable_name in DEPENDENT_EXECUTABLES:
            # TODO: Should encapsulate installation method in case Brew unavailable
            subprocess.call(["brew", "install", executable_name])

        print_formatted("\nInstalled Python dependencies\n", TermColors.HEADER_1)

    @classmethod
    def _install_package_managers(cls):
        print_formatted("Installing Python package managers\n", TermColors.HEADER_1)

        if not bool(shutil.which("pipenv")):
            subprocess.call(
                [
                    "pip",
                    "install",
                    "-U",
                    "pip",
                    "pipenv",
                ],
            )

        if not bool(shutil.which("poetry")):
            subprocess.call(
                [
                    "curl",
                    "-sSL",
                    "https://raw.githubusercontent.com/sdispater/poetry/master/get-poetry.py",
                    "|",
                    "python",
                ]
            )

        print_formatted("\nInstalled Python package managers\n", TermColors.HEADER_1)

    @classmethod
    def _install_language_versions(cls):
        LANGUAGE_VERSIONS = [
            "2.7.15",
            "3.6.6",
            "3.7.0",
            "3.7.1",
        ]

        print_formatted(
            "Installing commonly used Python versions\n", TermColors.HEADER_1
        )

        for language_version in LANGUAGE_VERSIONS:
            subprocess.call(["pyenv", "install", "--skip-existing", language_version])

        print_formatted(
            "\nInstalled commonly used Python versions\n", TermColors.HEADER_1
        )

    @classmethod
    def _install_utilities(cls):
        UTILITY_LIBRARIES = [
            "jedi",
            "python-language-server",
        ]

        print_formatted("Installing Python utilities\n", TermColors.HEADER_1)

        subprocess.call(["pip", "install", *UTILITY_LIBRARIES]),

        print_formatted("\nInstalled Python utilities\n", TermColors.HEADER_1)

    @classmethod
    def _install_utility_scripts(cls):
        print_formatted("\nInstalling Python utility scripts\n", TermColors.HEADER_1)

        curr_file_dir = os.path.dirname(os.path.abspath(__file__))
        utility_scripts_dir = f"{curr_file_dir}/config_files"
        for utility_script in os.listdir(utility_scripts_dir):
            utility_script_path_src = f"{utility_scripts_dir}/{utility_script}"
            utility_script_path_tgt = f"{HOME_DIR}/{utility_script}"

            try:
                os.symlink(utility_script_path_src, utility_script_path_tgt)

            except OSError as exc:
                print_formatted(
                    f"Warning: Detected existing configuration at {utility_script_path_tgt}\n",
                    TermColors.WARNING,
                )

                if exc.errno == errno.EEXIST:
                    os.unlink(utility_script_path_tgt)
                    os.symlink(utility_script_path_src, utility_script_path_tgt)

        print_formatted("\nInstalled Python utility scripts\n", TermColors.HEADER_1)

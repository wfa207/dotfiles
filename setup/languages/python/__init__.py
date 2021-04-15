import errno
import os
import shutil
import subprocess

from setup.utils import Shell


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
        Shell.print_formatted("Installing Python dependencies\n", Shell.Colors.HEADER_1)

        DEPENDENT_EXECUTABLES = [
            "pyenv",
            "python",
            "pip",
        ]

        for executable_name in DEPENDENT_EXECUTABLES:
            # TODO: Should encapsulate installation method in case Brew unavailable
            Shell.execute("brew", "install", executable_name)

        Shell.print_formatted(
            "\nInstalled Python dependencies\n", Shell.Colors.HEADER_1
        )

    @classmethod
    def _install_package_managers(cls):
        Shell.print_formatted(
            "Installing Python package managers\n", Shell.Colors.HEADER_1
        )

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
            Shell.execute(
                "curl",
                "-sSL",
                "https://raw.githubusercontent.com/sdispater/poetry/master/get-poetry.py",
                "|",
                "python",
            )

        Shell.print_formatted(
            "\nInstalled Python package managers\n", Shell.Colors.HEADER_1
        )

    @classmethod
    def _install_language_versions(cls):
        LANGUAGE_VERSIONS = [
            "2.7.15",
            "3.6.6",
            "3.7.0",
            "3.7.1",
        ]

        Shell.print_formatted(
            "Installing commonly used Python versions\n", Shell.Colors.HEADER_1
        )

        for language_version in LANGUAGE_VERSIONS:
            Shell.execute("pyenv", "install", "--skip-existing", language_version)

        Shell.print_formatted(
            "\nInstalled commonly used Python versions\n", Shell.Colors.HEADER_1
        )

    @classmethod
    def _install_utilities(cls):
        UTILITY_LIBRARIES = [
            "jedi",
            "python-language-server",
        ]

        Shell.print_formatted("Installing Python utilities\n", Shell.Colors.HEADER_1)

        Shell.execute("pip", "install", *UTILITY_LIBRARIES),

        Shell.print_formatted("\nInstalled Python utilities\n", Shell.Colors.HEADER_1)

    @classmethod
    def _install_utility_scripts(cls):
        Shell.print_formatted(
            "\nInstalling Python utility scripts\n", Shell.Colors.HEADER_1
        )

        utility_scripts_dir = Shell.get_abs_path("config_files")
        for utility_script in Shell.iter_file_names(utility_scripts_dir):
            utility_script_path_src = f"{utility_scripts_dir}/{utility_script}"
            utility_script_path_tgt = f"{Shell.HOME_DIR}/{utility_script}"

            try:
                Shell.link(utility_script_path_src, utility_script_path_tgt)

            except OSError as exc:
                Shell.print_formatted(
                    f"Warning: Detected existing configuration at {utility_script_path_tgt}\n",
                    Shell.Colors.WARNING,
                )

                if exc.errno == errno.EEXIST:
                    os.unlink(utility_script_path_tgt)
                    Shell.link(utility_script_path_src, utility_script_path_tgt)

        Shell.print_formatted(
            "\nInstalled Python utility scripts\n", Shell.Colors.HEADER_1
        )

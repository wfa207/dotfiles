import os
import subprocess

from setup.constants import HOME_DIR, TermColors
from setup.utils import print_formatted


class Tmux:
    @classmethod
    def setup(cls):
        cls._install_command()
        cls._install_plugin_manager()

        cls._configure()

    @classmethod
    def _install_command(cls):
        print_formatted("Installing Tmux command\n", TermColors.HEADER_1)

        # TODO: Should encapsulate installation method in case Brew unavailable
        subprocess.call(["brew", "install", "tmux"])

        print_formatted("\nFinished installing Tmux command\n", TermColors.HEADER_1)

    @classmethod
    def _install_plugin_manager(cls):
        already_exists = os.path.exists(f"{HOME_DIR}/.tmux/plugins/tpm")
        if already_exists:
            print_formatted(
                "Tmux plugin manager already installed\n", TermColors.WARNING
            )
            return

        print_formatted("Installing Tmux plugin manager\n", TermColors.HEADER_1)

        subprocess.call(
            [
                "git",
                "clone",
                "https://github.com/tmux-plugins/tpm",
                f"{HOME_DIR}/.tmux/plugins/tpm",
            ]
        )

        print_formatted(
            "\nFinished installing Tmux plugin manager\n", TermColors.HEADER_1
        )

    @classmethod
    def _configure(cls):
        print_formatted("Configuring Tmux\n", TermColors.HEADER_1)

        curr_file_dir = os.path.dirname(os.path.abspath(__file__))
        config_files_dir = f"{curr_file_dir}/config_files"
        for config_file in os.listdir(config_files_dir):
            config_file_path_src = f"{config_files_dir}/{config_file}"
            config_file_path_tgt = f"{HOME_DIR}/{config_file}"

            already_exists = os.path.exists(config_file_path_tgt)
            if not already_exists:
                os.symlink(config_file_path_src, config_file_path_tgt)

            else:
                print_formatted(
                    f"Warning: Detected existing configuration at {config_file_path_tgt}\n",
                    TermColors.WARNING,
                )

        print_formatted("Configured Tmux\n", TermColors.HEADER_1)

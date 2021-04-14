import glob
import os
import shutil
import subprocess

from setup.constants import HOME_DIR, TermColors
from setup.utils import print_formatted


class Powerline:
    @classmethod
    def setup(cls):
        cls._setup_fonts()
        cls._setup_shell()

        cls._configure()

    @classmethod
    def _setup_fonts(cls):
        print_formatted("Installing powerline fonts\n", TermColors.HEADER_1)

        subprocess.call(
            ["git", "clone", "https://github.com/powerline/fonts.git", "--depth=1"]
        )
        subprocess.call(["sh", "./fonts/install.sh"])
        shutil.rmtree("./fonts")

        print_formatted("\nFinished installing powerline fonts\n", TermColors.HEADER_1)

    @classmethod
    def _setup_shell(cls):
        print_formatted("Installing powerline-shell\n", TermColors.HEADER_1)

        subprocess.call(["git", "clone", "https://github.com/b-ryan/powerline-shell"])
        subprocess.call(["python", "./powerline-shell/setup.py", "install"])

        # Remove artifacts
        dirs = glob.glob("powerline[_-]shell*")
        for dir_name in dirs:
            shutil.rmtree(dir_name)

        print_formatted("\nFinished installing powerline-shell\n", TermColors.HEADER_1)

    @classmethod
    def _configure(cls):
        print_formatted("Configuring powerline-shell\n", TermColors.HEADER_1)

        os.makedirs(f"{HOME_DIR}/.config/powerline-shell", exist_ok=True)

        curr_file_dir = os.path.dirname(os.path.abspath(__file__))
        config_file_path_src = f"{curr_file_dir}/config_files/config.json"
        config_file_path_tgt = f"{HOME_DIR}/.config/powerline-shell/config.json"

        already_exists = os.path.exists(config_file_path_tgt)
        if not already_exists:
            os.symlink(config_file_path_src, config_file_path_tgt)

        else:
            print_formatted(
                f"Warning: Detected existing configuration at {config_file_path_tgt}\n",
                TermColors.WARNING,
            )

        print_formatted("Configured powerline-shell\n", TermColors.HEADER_1)

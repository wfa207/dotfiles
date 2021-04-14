import errno
import os
import shutil
import subprocess

from setup.constants import HOME_DIR, TermColors
from setup.utils import print_formatted


class Vim:
    @classmethod
    def setup(cls):
        cls._install_command()
        cls._install_dependencies()

        cls._configure()

        cls._install_plugin_manager()
        cls._install_plugins()

        cls._load_snippets()

    @classmethod
    def _install_command(cls):
        print_formatted("Installing Vim command\n", TermColors.HEADER_1)

        # TODO: Should encapsulate installation method in case Brew unavailable
        subprocess.call(["brew", "install", "vim"])

        print_formatted("\nInstalled Vim command\n", TermColors.HEADER_1)

    @classmethod
    def _install_dependencies(cls):
        print_formatted("Installing Vim dependencies\n", TermColors.HEADER_1)

        DEPENDENT_EXECUTABLES = [
            "the_silver_searcher",
            "cmake",
            "ctags",
            "bat",
        ]

        for executable_name in DEPENDENT_EXECUTABLES:
            # TODO: Should encapsulate installation method in case Brew unavailable
            subprocess.call(["brew", "install", executable_name])

        print_formatted("\nInstalled Vim dependencies\n", TermColors.HEADER_1)

    @classmethod
    def _configure(cls):
        print_formatted("Configuring Vim\n", TermColors.HEADER_1)

        curr_file_dir = os.path.dirname(os.path.abspath(__file__))
        config_files_dir = f"{curr_file_dir}/config_files"
        for config_file in os.listdir(config_files_dir):
            config_file_path_src = f"{config_files_dir}/{config_file}"
            config_file_path_tgt = f"{HOME_DIR}/{config_file}"

            try:
                os.symlink(config_file_path_src, config_file_path_tgt)

            except OSError as exc:
                print_formatted(
                    f"Warning: Detected existing configuration at {config_file_path_tgt}\n",
                    TermColors.WARNING,
                )

                if exc.errno == errno.EEXIST:
                    os.unlink(config_file_path_tgt)
                    os.symlink(config_file_path_src, config_file_path_tgt)

        print_formatted("Configured Vim\n", TermColors.HEADER_1)

    @classmethod
    def _install_plugin_manager(cls):
        print_formatted("Installing Vim-Plug\n", TermColors.HEADER_1)

        already_exists = os.path.exists(f"{HOME_DIR}/.vim/autoload/plug.vim")
        if not already_exists:
            subprocess.call(
                [
                    "curl",
                    "-fLo",
                    f"{HOME_DIR}/.vim/autoload/plug.vim",
                    "--create-dirs",
                    "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim",
                ]
            )

        print_formatted("\nInstalled Vim-Plug\n", TermColors.HEADER_1)

    @classmethod
    def _install_plugins(cls):
        print_formatted("Installing Vim Plugins\n", TermColors.HEADER_1)

        subprocess.call(["vim", "+PlugInstall", "+PlugUpdate", "+qall"])
        subprocess.call(["python", f"{HOME_DIR}/.vim/plugged/YouCompleteMe/install.py"])

        print_formatted("\nInstalled Vim Plugins\n", TermColors.HEADER_1)

    @classmethod
    def _load_snippets(cls):
        print_formatted("Loading Vim snippets\n", TermColors.HEADER_1)

        curr_file_dir = os.path.dirname(os.path.abspath(__file__))
        snippet_dir_path_src = f"{curr_file_dir}/snippets"
        snippet_dir_path_tgt = f"{HOME_DIR}/.vim/my_snippets"

        try:
            os.symlink(snippet_dir_path_src, snippet_dir_path_tgt)

        except OSError as exc:
            print_formatted(
                f"Warning: Detected existing configuration at {snippet_dir_path_tgt}\n",
                TermColors.WARNING,
            )

            if exc.errno == errno.EEXIST:
                shutil.rmtree(snippet_dir_path_tgt)
                os.symlink(snippet_dir_path_src, snippet_dir_path_tgt)

        print_formatted("Loaded Vim snippets\n", TermColors.HEADER_1)

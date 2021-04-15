from setup.utils import Executable, Shell


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
        Shell.print_formatted("Installing Vim command\n", Shell.Colors.HEADER_1)

        Executable.install("vim")

        Shell.print_formatted("\nInstalled Vim command\n", Shell.Colors.HEADER_1)

    @classmethod
    def _install_dependencies(cls):
        Shell.print_formatted("Installing Vim dependencies\n", Shell.Colors.HEADER_1)

        DEPENDENT_EXECUTABLES = [
            "the_silver_searcher",
            "cmake",
            "ctags",
            "bat",
        ]

        for executable_name in DEPENDENT_EXECUTABLES:
            Executable.install(executable_name)

        Shell.print_formatted("\nInstalled Vim dependencies\n", Shell.Colors.HEADER_1)

    @classmethod
    def _configure(cls):
        Shell.print_formatted("Configuring Vim\n", Shell.Colors.HEADER_1)

        config_files_dir = Shell.get_abs_path("config_files")
        for config_file in Shell.iter_file_names(config_files_dir):
            config_file_path_src = f"{config_files_dir}/{config_file}"
            config_file_path_tgt = f"{Shell.HOME_DIR}/{config_file}"

            if Shell.exists(config_file_path_tgt):
                Shell.print_formatted(
                    f"Warning: Found existing configuration at {config_file_path_tgt}\n",
                    Shell.Colors.WARNING,
                )
                Shell.delete(config_file_path_tgt)

            Shell.link(config_file_path_src, config_file_path_tgt)

        Shell.print_formatted("Configured Vim\n", Shell.Colors.HEADER_1)

    @classmethod
    def _install_plugin_manager(cls):
        Shell.print_formatted("Installing Vim-Plug\n", Shell.Colors.HEADER_1)

        if not Shell.exists(f"{Shell.HOME_DIR}/.vim/autoload/plug.vim"):
            Shell.execute(
                "curl",
                "-fLo",
                f"{Shell.HOME_DIR}/.vim/autoload/plug.vim",
                "--create-dirs",
                "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim",
            )
            Shell.print_formatted("\nInstalled Vim-Plug\n", Shell.Colors.HEADER_1)

        else:
            Shell.print_formatted(
                "\nVim-Plug already installed\n", Shell.Colors.WARNING
            )

    @classmethod
    def _install_plugins(cls):
        Shell.print_formatted("Installing Vim Plugins\n", Shell.Colors.HEADER_1)

        Shell.execute("vim", "+PlugInstall", "+PlugUpdate", "+qall")
        Shell.execute(
            "python", f"{Shell.HOME_DIR}/.vim/plugged/YouCompleteMe/install.py"
        )

        Shell.print_formatted("\nInstalled Vim Plugins\n", Shell.Colors.HEADER_1)

    @classmethod
    def _load_snippets(cls):
        Shell.print_formatted("Loading Vim snippets\n", Shell.Colors.HEADER_1)

        snippet_dir_path_src = Shell.get_abs_path("snippets")
        snippet_dir_path_tgt = f"{Shell.HOME_DIR}/.vim/my_snippets"

        if Shell.exists(snippet_dir_path_tgt):
            Shell.print_formatted(
                f"Warning: Found existing configuration at {snippet_dir_path_tgt}\n",
                Shell.Colors.WARNING,
            )
            Shell.delete(snippet_dir_path_tgt)

        Shell.link(snippet_dir_path_src, snippet_dir_path_tgt)

        Shell.print_formatted("Loaded Vim snippets\n", Shell.Colors.HEADER_1)

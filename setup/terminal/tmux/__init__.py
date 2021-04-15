from setup.utils import Executable, Shell


class Tmux:
    @classmethod
    def setup(cls):
        cls._install_command()
        cls._install_plugin_manager()

        cls._configure()

    @classmethod
    def _install_command(cls):
        Shell.print_formatted("Installing Tmux command\n", Shell.Colors.HEADER_1)

        Executable.install("tmux")

        Shell.print_formatted(
            "\nFinished installing Tmux command\n", Shell.Colors.HEADER_1
        )

    @classmethod
    def _install_plugin_manager(cls):
        tgt_plugin_path = f"{Shell.HOME_DIR}/.tmux/plugins/tpm"
        if not Shell.exists(tgt_plugin_path):
            Shell.print_formatted(
                "Installing Tmux plugin manager\n", Shell.Colors.HEADER_1
            )

            Shell.execute(
                "git",
                "clone",
                "https://github.com/tmux-plugins/tpm",
                tgt_plugin_path,
            )

            Shell.print_formatted(
                "\nFinished installing Tmux plugin manager\n", Shell.Colors.HEADER_1
            )

        else:
            Shell.print_formatted(
                "Tmux plugin manager already installed\n", Shell.Colors.WARNING
            )

    @classmethod
    def _configure(cls):
        Shell.print_formatted("Configuring Tmux\n", Shell.Colors.HEADER_1)

        config_files_dir = Shell.get_abs_path("config_files")
        for config_file_name in Shell.iter_file_names(config_files_dir):
            config_file_path_src = f"{config_files_dir}/{config_file_name}"
            config_file_path_tgt = f"{Shell.HOME_DIR}/{config_file_name}"

            if not Shell.exists(config_file_path_tgt):
                Shell.link(config_file_path_src, config_file_path_tgt)

            else:
                Shell.print_formatted(
                    f"Warning: Found existing configuration at {config_file_path_tgt}\n",
                    Shell.Colors.WARNING,
                )

        Shell.print_formatted("Configured Tmux\n", Shell.Colors.HEADER_1)

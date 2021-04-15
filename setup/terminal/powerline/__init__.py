import glob

from setup.utils import Shell


class Powerline:
    @classmethod
    def setup(cls):
        cls._setup_fonts()
        cls._setup_shell()

        cls._configure()

    @classmethod
    def _setup_fonts(cls):
        Shell.print_formatted("Installing powerline fonts\n", Shell.Colors.HEADER_1)

        Shell.execute(
            "git", "clone", "https://github.com/powerline/fonts.git", "--depth=1"
        )
        Shell.execute("sh", "./fonts/install.sh")
        Shell.delete("./fonts")

        Shell.print_formatted(
            "\nFinished installing powerline fonts\n", Shell.Colors.HEADER_1
        )

    @classmethod
    def _setup_shell(cls):
        Shell.print_formatted("Installing powerline-shell\n", Shell.Colors.HEADER_1)

        Shell.execute("git", "clone", "https://github.com/b-ryan/powerline-shell")
        Shell.execute("python", "./powerline-shell/setup.py", "install")

        # Remove artifacts
        dirs = glob.glob("powerline[_-]shell*")
        for dir_name in dirs:
            Shell.delete(dir_name)

        Shell.print_formatted(
            "\nFinished installing powerline-shell\n", Shell.Colors.HEADER_1
        )

    @classmethod
    def _configure(cls):
        Shell.print_formatted("Configuring powerline-shell\n", Shell.Colors.HEADER_1)

        Shell.make_dir(f"{Shell.HOME_DIR}/.config/powerline-shell", exist_ok=True)

        config_file_path_src = Shell.get_abs_path("config_files/config.json")
        config_file_path_tgt = f"{Shell.HOME_DIR}/.config/powerline-shell/config.json"

        if not Shell.exists(config_file_path_tgt):
            Shell.link(config_file_path_src, config_file_path_tgt)
            Shell.print_formatted("Configured powerline-shell\n", Shell.Colors.HEADER_1)

        else:
            Shell.print_formatted(
                f"Warning: Found existing configuration at {config_file_path_tgt}\n",
                Shell.Colors.WARNING,
            )

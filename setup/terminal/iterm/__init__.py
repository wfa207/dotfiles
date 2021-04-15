from setup.utils import Shell


class iTerm:
    @classmethod
    def setup(cls):
        cls._verify_installation()
        cls._load_preferences()

    @classmethod
    def _verify_installation(cls):
        if not Shell.exists("/Applications/iTerm.app"):
            Shell.print_formatted(
                "iTerm could not be found on your machine."
                "\nPlease refer to iTerm's website https://www.iterm2.com or contact"
                "your system administrator to determine how to install",
                Shell.Colors.WARNING,
            )
            raise FileNotFoundError(
                "iTerm.app could not be found in the root 'Applications' folder"
            )

    @classmethod
    def _load_preferences(cls):
        Shell.print_formatted("Loading iTerm preferences\n", Shell.Colors.HEADER_1)

        tgt_file_path = Shell.get_abs_path("config_files")
        Shell.execute(
            "defaults",
            "write",
            "com.googlecode.iterm2",
            "PrefsCustomFolder",
            tgt_file_path,
        )

        Shell.print_formatted("Loaded iTerm preferences\n", Shell.Colors.SUCCESS)

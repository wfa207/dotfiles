from setup.utils import Shell


class Config:
    @classmethod
    def setup(cls):
        cls._configure()

    @classmethod
    def _configure(cls):
        Shell.print_formatted("Configuring Bash\n", Shell.Colors.HEADER_1)

        config_files_dir = Shell.get_abs_path("config_files")

        for config_file in Shell.iter_file_names(config_files_dir):
            config_file_path_src = f"{config_files_dir}/{config_file}"
            config_file_path_tgt = f"{Shell.HOME_DIR}/{config_file}"

            if not Shell.exists(config_file_path_tgt):
                Shell.link(config_file_path_src, config_file_path_tgt)

            else:
                Shell.print_formatted(
                    f"Warning: Found existing configuration at {config_file_path_tgt}\n",
                    Shell.Colors.WARNING,
                )

        Shell.print_formatted("Configured Bash\n", Shell.Colors.SUCCESS)

import os

from setup.constants import HOME_DIR
from setup.utils import Shell


class Config:
    @classmethod
    def setup(cls):
        cls._configure()

    @classmethod
    def _configure(cls):
        Shell.print_formatted("Configuring Bash\n", Shell.Colors.HEADER_1)

        curr_file_dir = os.path.dirname(os.path.abspath(__file__))
        config_files_dir = f"{curr_file_dir}/config_files"

        for config_file in os.listdir(config_files_dir):
            config_file_path_src = f"{config_files_dir}/{config_file}"
            config_file_path_tgt = f"{HOME_DIR}/{config_file}"

            already_exists = os.path.exists(config_file_path_tgt)
            if not already_exists:
                os.symlink(config_file_path_src, config_file_path_tgt)

            else:
                Shell.print_formatted(
                    f"Warning: Detected existing configuration at {config_file_path_tgt}\n",
                    Shell.Colors.WARNING,
                )

        Shell.print_formatted("Configured Bash\n", Shell.Colors.HEADER_1)

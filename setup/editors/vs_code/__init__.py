import errno
import os
import subprocess

from setup.constants import HOME_DIR, TermColors
from setup.utils import print_formatted


class VSCode:
    @classmethod
    def setup(cls):
        cls._install_executable()
        cls._install_extensions()

        cls._configure()
        cls._load_snippets()

    @classmethod
    def _install_executable(cls):
        already_exists = os.path.exists("/Applications/Visual Studio Code.app")
        if not already_exists:
            print_formatted("Installing VS Code executable\n", TermColors.WARNING)

            # This is OS X-specific setup -----------------------------------------------
            subprocess.call(
                [
                    "curl",
                    "-L",
                    "--create-dirs",
                    "-o",
                    f"{HOME_DIR}/Downloads/VSCode-temp.zip",
                    "https://update.code.visualstudio.com/latest/darwin/stable",
                ]
            )
            subprocess.call(
                [
                    "unzip",
                    f"{HOME_DIR}/Downloads/VSCode-temp.zip",
                    "-d",
                    "/Applications",
                ]
            )
            subprocess.call(
                [
                    "rm",
                    f"{HOME_DIR}/Downloads/VSCode-temp.zip",
                ]
            )
            # ---------------------------------------------------------------------------

            print_formatted("\nInstalled VS Code executable\n", TermColors.HEADER_1)

        else:
            print_formatted(
                "VS Code executable already installed\n", TermColors.WARNING
            )

        cls._setup_cli_command()

    @classmethod
    def _setup_cli_command(cls):
        binary_path_tgt = "/usr/local/bin/code"
        already_exists = os.path.exists(binary_path_tgt)

        if not already_exists:
            print_formatted("Setting up VS Code CLI command\n", TermColors.HEADER_1)

            binary_path_src = (
                f"/Applications/Visual Studio Code.app/Contents/Resources/app/bin/code"
            )

            os.symlink(binary_path_src, binary_path_tgt)

            print_formatted("Setup VS Code CLI command\n", TermColors.HEADER_1)

        else:
            print_formatted("VS Code CLI command already setup\n", TermColors.WARNING)

    @classmethod
    def _install_extensions(cls):
        EXTENSIONS = [
            # Navigation #######################################################
            "vscodevim.vim",
            "hoovercj.vscode-settings-cycler",  # Helps with line number toggle
            # Source Control ###################################################
            "eamodio.gitlens",
            "GitHub.vscode-pull-request-github",
            # Display ##########################################################
            "RobbOwen.synthwave-vscode",
            "PKief.material-icon-theme",
            # Debugging ########################################################
            "msjsdiag.debugger-for-chrome",
            # Languages ########################################################
            # Python ===========================================================
            "njpwerner.autodocstring",
            "lextudio.restructuredtext",
            "ms-pyright.pyright",
            "ms-python.python",
            # Javascript =======================================================
            "esbenp.prettier-vscode",
            # Misc #############################################################
            "ms-azuretools.vscode-docker",
            "ms-vscode-remote.remote-containers",
        ]

        print_formatted("Installing VS Code Extensions\n", TermColors.HEADER_1)

        for extension_name in EXTENSIONS:
            subprocess.call(["code", "--install-extension", extension_name])

        print_formatted("Installed VS Code Extensions\n", TermColors.HEADER_1)

    @classmethod
    def _configure(cls):
        print_formatted("Configuring VS Code\n", TermColors.HEADER_1)

        curr_file_dir = os.path.dirname(os.path.abspath(__file__))
        config_files_dir = f"{curr_file_dir}/config_files"
        for config_file in os.listdir(config_files_dir):
            config_file_path_src = f"{config_files_dir}/{config_file}"
            config_file_path_tgt = (
                f"{HOME_DIR}/Library/Application Support/Code/User/{config_file}"
            )

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

        subprocess.call(
            [
                "defaults",
                "write",
                "com.microsoft.VSCode",
                "ApplePressAndHoldEnabled",
                "-bool",
                "false",
            ]
        )
        subprocess.call(
            [
                "defaults",
                "write",
                "com.microsoft.VSCodeInsiders",
                "ApplePressAndHoldEnabled",
                "-bool",
                "false",
            ]
        )
        subprocess.call(
            [
                "defaults",
                "write",
                "com.visualstudio.code.oss",
                "ApplePressAndHoldEnabled",
                "-bool",
                "false",
            ]
        )
        subprocess.call(["defaults", "delete", "-g", "ApplePressAndHoldEnabled"])

        print_formatted("\nConfigured VS Code\n", TermColors.HEADER_1)

    @classmethod
    def _load_snippets(cls):
        print_formatted("Loading VS Code snippets\n", TermColors.HEADER_1)

        curr_file_dir = os.path.dirname(os.path.abspath(__file__))
        snippet_dir_path_src = f"{curr_file_dir}/snippets"
        snippet_dir_path_tgt = (
            f"{HOME_DIR}/Library/Application Support/Code/User/snippets"
        )

        try:
            os.symlink(snippet_dir_path_src, snippet_dir_path_tgt)

        except OSError as exc:
            print_formatted(
                f"Warning: Detected existing configuration at {snippet_dir_path_tgt}\n",
                TermColors.WARNING,
            )

            if exc.errno == errno.EEXIST:
                os.unlink(snippet_dir_path_tgt)
                os.symlink(snippet_dir_path_src, snippet_dir_path_tgt)

        print_formatted("Loaded VS Code snippets\n", TermColors.HEADER_1)

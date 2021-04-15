import errno
import os

from setup.utils import Shell


class VSCode:
    @classmethod
    def setup(cls):
        cls._install_executable()
        cls._install_extensions()

        cls._configure()
        cls._load_snippets()

    @classmethod
    def _install_executable(cls):
        if not Shell.exists("/Applications/Visual Studio Code.app"):
            Shell.print_formatted(
                "Installing VS Code executable\n", Shell.Colors.WARNING
            )

            # This is OS X-specific setup -----------------------------------------------
            Shell.execute(
                "curl",
                "-L",
                "--create-dirs",
                "-o",
                f"{Shell.HOME_DIR}/Downloads/VSCode-temp.zip",
                "https://update.code.visualstudio.com/latest/darwin/stable",
            )
            Shell.execute(
                "unzip",
                f"{Shell.HOME_DIR}/Downloads/VSCode-temp.zip",
                "-d",
                "/Applications",
            )
            Shell.execute(
                "rm",
                f"{Shell.HOME_DIR}/Downloads/VSCode-temp.zip",
            )
            # ---------------------------------------------------------------------------

            Shell.print_formatted(
                "\nInstalled VS Code executable\n", Shell.Colors.HEADER_1
            )

        else:
            Shell.print_formatted(
                "VS Code executable already installed\n", Shell.Colors.WARNING
            )

        cls._setup_cli_command()

    @classmethod
    def _setup_cli_command(cls):
        binary_path_tgt = "/usr/local/bin/code"
        if not Shell.exists(binary_path_tgt):
            Shell.print_formatted(
                "Setting up VS Code CLI command\n", Shell.Colors.HEADER_1
            )

            binary_path_src = (
                "/Applications/Visual Studio Code.app/Contents/Resources/app/bin/code"
            )

            Shell.link(binary_path_src, binary_path_tgt)

            Shell.print_formatted("Setup VS Code CLI command\n", Shell.Colors.HEADER_1)

        else:
            Shell.print_formatted(
                "VS Code CLI command already setup\n", Shell.Colors.WARNING
            )

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
            "tht13.python",  # Decent snippets collection
            "ms-pyright.pyright",
            "ms-python.python",
            # Javascript =======================================================
            "esbenp.prettier-vscode",
            "xabikos.JavaScriptSnippets",
            # Misc #############################################################
            "ms-azuretools.vscode-docker",
            "ms-vscode-remote.remote-containers",
            "TabNine.tabnine-vscode",
        ]

        Shell.print_formatted("Installing VS Code Extensions\n", Shell.Colors.HEADER_1)

        for extension_name in EXTENSIONS:
            Shell.execute("code", "--install-extension", extension_name)

        Shell.print_formatted("Installed VS Code Extensions\n", Shell.Colors.HEADER_1)

    @classmethod
    def _configure(cls):
        Shell.print_formatted("Configuring VS Code\n", Shell.Colors.HEADER_1)

        config_files_dir = Shell.get_abs_path("config_files")
        for config_file in Shell.iter_file_names(config_files_dir):
            config_file_path_src = f"{config_files_dir}/{config_file}"
            config_file_path_tgt = (
                f"{Shell.HOME_DIR}/Library/Application Support/Code/User/{config_file}"
            )

            try:
                Shell.link(config_file_path_src, config_file_path_tgt)

            except OSError as exc:
                Shell.print_formatted(
                    f"Warning: Detected existing configuration at {config_file_path_tgt}\n",
                    Shell.Colors.WARNING,
                )

                if exc.errno == errno.EEXIST:
                    os.unlink(config_file_path_tgt)
                    Shell.link(config_file_path_src, config_file_path_tgt)

        Shell.execute(
            "defaults",
            "write",
            "com.microsoft.VSCode",
            "ApplePressAndHoldEnabled",
            "-bool",
            "false",
        )
        Shell.execute(
            "defaults",
            "write",
            "com.microsoft.VSCodeInsiders",
            "ApplePressAndHoldEnabled",
            "-bool",
            "false",
        )
        Shell.execute(
            "defaults",
            "write",
            "com.visualstudio.code.oss",
            "ApplePressAndHoldEnabled",
            "-bool",
            "false",
        )
        Shell.execute("defaults", "delete", "-g", "ApplePressAndHoldEnabled")

        Shell.print_formatted("\nConfigured VS Code\n", Shell.Colors.HEADER_1)

    @classmethod
    def _load_snippets(cls):
        Shell.print_formatted("Loading VS Code snippets\n", Shell.Colors.HEADER_1)

        snippet_dir_path_src = Shell.get_abs_path("snippets")
        snippet_dir_path_tgt = (
            f"{Shell.HOME_DIR}/Library/Application Support/Code/User/snippets"
        )

        try:
            Shell.link(snippet_dir_path_src, snippet_dir_path_tgt)

        except OSError as exc:
            Shell.print_formatted(
                f"Warning: Detected existing snippets at {snippet_dir_path_tgt}\n",
                Shell.Colors.WARNING,
            )

            if exc.errno == errno.EEXIST:
                os.unlink(snippet_dir_path_tgt)
                Shell.link(snippet_dir_path_src, snippet_dir_path_tgt)

        Shell.print_formatted("Loaded VS Code snippets\n", Shell.Colors.HEADER_1)

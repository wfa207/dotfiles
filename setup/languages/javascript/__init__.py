from setup.utils import Executable, Shell


class Javascript:
    @classmethod
    def setup(cls):
        cls._install_dependencies()
        cls._install_version_managers()
        cls._install_utilities()

    @classmethod
    def _install_dependencies(cls):
        Shell.print_formatted(
            "Installing Javascript dependencies\n", Shell.Colors.HEADER_1
        )

        DEPENDENT_EXECUTABLES = [("node", {}), ("yarn", {"ignore-dependencies": True})]

        for executable_name, install_options in DEPENDENT_EXECUTABLES:
            Executable.install(executable_name, **install_options)

        Shell.print_formatted(
            "\nInstalled Javascript dependencies\n", Shell.Colors.HEADER_1
        )

    @classmethod
    def _install_version_managers(cls):
        NVM_DIR = f"{Shell.HOME_DIR}/.nvm"
        Shell.print_formatted(
            "Installing Javascript version managers\n", Shell.Colors.HEADER_1
        )

        if not Shell.exists(NVM_DIR):
            if Shell.exists("/usr/local/Cellar/nvm"):
                Executable.uninstall("nvm")

        Shell.make_dir(NVM_DIR, exist_ok=True)
        Shell.execute(
            "curl",
            "-o-",
            "https://raw.githubusercontent.com/creationix/nvm/v0.34.0/install.sh",
            "|",
            "bash",
        )

        Shell.print_formatted(
            "\nInstalled Javascript version managers\n", Shell.Colors.HEADER_1
        )

    @classmethod
    def _install_utilities(cls):
        UTILITY_LIBRARIES = [
            "typescript",
        ]

        Shell.print_formatted(
            "Installing Javascript utilities\n", Shell.Colors.HEADER_1
        )

        Shell.execute("npm", "install", "-g", *UTILITY_LIBRARIES),

        Shell.print_formatted(
            "\nInstalled Javascript utilities\n", Shell.Colors.HEADER_1
        )

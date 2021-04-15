from setup.utils.shell import Shell


class Executable:
    @classmethod
    def install(cls, executable_name, **options):
        cli_options = cls._get_cli_options(**options)
        Shell.execute("brew", "install", executable_name, *cli_options)

    @classmethod
    def uninstall(cls, executable_name, **options):
        cli_options = cls._get_cli_options(**options)
        Shell.execute("brew", "uninstall", executable_name, *cli_options)

    @classmethod
    def _get_cli_options(cls, **options):
        return [f"--{key}={value}" for key, value in options.items()]

import subprocess


class Shell:
    class Colors:
        HEADER_1 = "\033[1;34m"

        INPUT = "\033[1;36m"

        SUCCESS = "\033[1;32m"
        WARNING = "\033[1;33m"
        FAILURE = "\033[1;31m"

        END = "\033[0m"
        DEFAULT = END

    @classmethod
    def clean_input(cls, raw_input):
        return raw_input.lower()

    @classmethod
    def print_formatted(cls, msg=None, color=Colors.DEFAULT):
        if msg is None:
            print()

        else:
            print(f"{color}{msg}{cls.Colors.END}")

    @classmethod
    def execute(cls, *cmd_args):
        subprocess.call(cmd_args)

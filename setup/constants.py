import os

HOME_DIR = os.path.expanduser("~")


class TermColors:
    HEADER_1 = "\033[1;34m"

    INPUT = "\033[1;36m"

    SUCCESS = "\033[1;32m"
    WARNING = "\033[1;33m"
    FAILURE = "\033[1;31m"

    END = "\033[0m"
    DEFAULT = END

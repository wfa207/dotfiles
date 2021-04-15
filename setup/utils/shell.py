import inspect
import os
import subprocess


class Shell:
    HOME_DIR = os.path.expanduser("~")

    class Colors:
        HEADER_1 = "\033[1;34m"

        INPUT = "\033[1;36m"

        SUCCESS = "\033[1;32m"
        WARNING = "\033[1;33m"
        FAILURE = "\033[1;31m"

        END = "\033[0m"
        DEFAULT = END

    # CLI ######################################################################
    @classmethod
    def execute(cls, *cmd_args):
        subprocess.call(cmd_args)

    # I/O ######################################################################
    @classmethod
    def clean_input(cls, raw_input):
        return raw_input.lower()

    @classmethod
    def print_formatted(cls, msg=None, color=Colors.DEFAULT):
        if msg is None:
            print()

        else:
            print(f"{color}{msg}{cls.Colors.END}")

    # Files ####################################################################
    @classmethod
    def get_abs_path(cls, rel_path):
        caller_frame = inspect.stack()[1]
        caller_abs_file_path = caller_frame.filename
        curr_file_dir = os.path.dirname(caller_abs_file_path)
        return f"{curr_file_dir}/{rel_path}"

    @classmethod
    def iter_file_names(cls, abs_dir_path):
        return os.listdir(abs_dir_path)

    @classmethod
    def exists(cls, abs_file_path):
        return os.path.exists(abs_file_path)

    @classmethod
    def link(cls, src_path, tgt_path):
        os.symlink(src_path, tgt_path)

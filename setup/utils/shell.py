import inspect
import os
import shutil
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
    def await_input(cls, prompt, color=Colors.DEFAULT):
        user_input = input(f"{color}{prompt}{cls.Colors.END}")

        # Insert blank line after input
        Shell.print_formatted()

        return user_input

    @classmethod
    def clean_input(cls, original_input):
        return original_input.lower()

    @classmethod
    def confirm_choice(cls, prompt, affirmative_choice="y", color=Colors.DEFAULT):
        user_choice_input = cls.await_input(prompt, color=color)
        return user_choice_input == affirmative_choice

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
        is_file_or_dir = cls._is_file_or_dir(abs_file_path)
        is_link = cls._is_link(abs_file_path)
        return is_file_or_dir or is_link

    @classmethod
    def executable_exists(cls, executable_name):
        return bool(shutil.which(executable_name))

    @classmethod
    def delete(cls, abs_file_path):
        if cls._is_link(abs_file_path):
            os.unlink(abs_file_path)

        if cls._is_file_or_dir(abs_file_path):
            shutil.rmtree(abs_file_path)

    @classmethod
    def link(cls, src_path, tgt_path):
        os.symlink(src_path, tgt_path)

    @classmethod
    def make_dir(cls, abs_dir_path, exist_ok=False):
        os.makedirs(abs_dir_path, exist_ok=exist_ok)

    @classmethod
    def _is_file_or_dir(cls, abs_file_path):
        return os.path.exists(abs_file_path)

    @classmethod
    def _is_link(cls, abs_file_path):
        return os.path.islink(abs_file_path)

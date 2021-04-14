from setup import Setup
from setup.constants import TermColors
from setup.utils import print_formatted

if __name__ == "__main__":
    try:
        Setup.run()

    except Exception as exc:
        print_formatted(f"Encountered exception: '{str(exc)}'\n", TermColors.FAILURE)
        raise exc

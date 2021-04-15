from setup import Setup
from setup.utils import Shell

if __name__ == "__main__":
    try:
        Setup.run()

    except Exception as exc:
        Shell.print_formatted(
            f"Encountered exception: '{str(exc)}'\n", Shell.Colors.FAILURE
        )
        raise exc

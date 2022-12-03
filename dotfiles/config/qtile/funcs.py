import subprocess

from libqtile.lazy import lazy


def _caps_lock_is_ctrl() -> bool:
    command = 'setxkbmap -query | grep option'
    result = subprocess.run(command, shell=True, stdout=subprocess.DEVNULL)

    if result.returncode:
        return False

    return True


@lazy.function
def toggle_caps_and_ctrl(qtile) -> None:
    command = 'setxkbmap -option ctrl:nocaps'

    if _caps_lock_is_ctrl():
        command = 'setxkbmap -option'

    subprocess.run(
        command,
        shell=True,
        stdout=subprocess.DEVNULL,
    )

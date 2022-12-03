import gi

gi.require_version('GSound', '1.0')
from gi.repository import GSound

_context = GSound.Context()
_context.init()

# Documentation of libcanberra properties at:
# https://0pointer.de/lennart/projects/libcanberra/gtkdoc/libcanberra-canberra.html
_context.set_attributes(
    {
        GSound.ATTR_CANBERRA_XDG_THEME_NAME: 'Qtile',
        GSound.ATTR_APPLICATION_NAME: 'Qtile Window Manager',
        GSound.ATTR_APPLICATION_ID: 'org.qtile',
    }
)


def play_sound(event_id: str, event_description: str) -> None:
    """Play a notification sound."""
    _context.play_simple(
        {
            GSound.ATTR_EVENT_ID: event_id,
            GSound.ATTR_EVENT_DESCRIPTION: event_description,
        }
    )

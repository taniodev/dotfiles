import os
import subprocess

from libqtile import bar, hook, layout, qtile, widget
from libqtile.config import Click, Drag, Group, Key, Match, Screen
from libqtile.lazy import lazy
from libqtile.log_utils import logger
from libqtile.utils import guess_terminal

from funcs import toggle_caps_and_ctrl
from sound import play_sound

mod = 'mod4'
terminal = guess_terminal()

keys = [
    Key([mod], 'Tab', lazy.layout.up(), desc='Move focus up'),
    Key([mod, 'shift'], 'Tab', lazy.layout.down(), desc='Move focus down'),
    Key(['mod1'], 'Tab', lazy.layout.up(), desc='Move focus up'),
    Key(['mod1', 'shift'], 'Tab', lazy.layout.down(), desc='Move focus down'),
    Key([mod, 'shift'], 'space', toggle_caps_and_ctrl),
    Key(['mod1', 'shift'], 'BackSpace', lazy.spawn('orca-restart')),
    Key([mod], 't', lazy.spawn(terminal), desc='Launch terminal'),
    Key([mod], 'r', lazy.spawn('gmrun')),
    Key([mod], 'q', lazy.spawn('emacs'), desc='Launch Emacs'),
    Key([mod], 'g', lazy.spawn('gedit'), desc='Launch Gedit'),
    Key([mod], 'f', lazy.spawn('firefox')),
    Key([mod, 'shift'], 'f', lazy.spawn('firefox --private-window')),
    Key([mod], 'w', lazy.spawn('microsoft-edge-stable')),
    Key([mod, 'shift'], 'w', lazy.spawn('microsoft-edge-stable --inprivate')),
    Key([mod], 'm', lazy.spawn('thunderbird')),
    Key([mod], 'e', lazy.spawn('thunar')),
    Key([mod], 'F4', lazy.window.kill(), desc='Kill focused window'),
    Key([mod, 'control'], 'r', lazy.reload_config(), desc='Reload the config'),
    Key([mod, 'control'], 'q', lazy.shutdown(), desc='Shutdown Qtile'),
    Key(
        [mod, 'control'],
        'Page_Up',
        lazy.spawn('shutdown -r now'),
        desc='System reboot',
    ),
    Key(
        [mod, 'control'],
        'Page_Down',
        lazy.spawn('shutdown -h now'),
        desc='System shutdown',
    ),
]

groups = [Group(i) for i in '123456789']

for i in groups:
    keys.extend(
        [
            # mod1 + letter of group = switch to group
            Key(
                [mod],
                i.name,
                lazy.group[i.name].toscreen(),
                desc='Switch to group {}'.format(i.name),
            ),
            # mod1 + shift + letter of group = switch to & move focused window to group
            Key(
                [mod, 'shift'],
                i.name,
                lazy.window.togroup(i.name, switch_group=True),
                desc='Switch to & move focused window to group {}'.format(
                    i.name
                ),
            ),
        ]
    )

layouts = [
    layout.Max(),
]

widget_defaults = dict(
    font='sans',
    fontsize=12,
    padding=3,
)
extension_defaults = widget_defaults.copy()

screens = [
    Screen(
        bottom=bar.Bar(
            [
                widget.CurrentLayout(),
                widget.GroupBox(),
                widget.Prompt(),
                widget.WindowName(),
                widget.Chord(
                    chords_colors={
                        'launch': ('#ff0000', '#ffffff'),
                    },
                    name_transform=lambda name: name.upper(),
                ),
                widget.TextBox('default config', name='default'),
                widget.TextBox(
                    'Press &lt;M-r&gt; to spawn', foreground='#d75f5f'
                ),
                widget.Systray(),
                widget.Clock(format='%Y-%m-%d %a %I:%M %p'),
                widget.QuickExit(),
            ],
            24,
            # border_width=[2, 0, 2, 0],  # Draw top and bottom borders
            # border_color=["ff00ff", "000000", "ff00ff", "000000"]  # Borders are magenta
        ),
    ),
]

# Drag floating layouts.
mouse = [
    Drag(
        [mod],
        'Button1',
        lazy.window.set_position_floating(),
        start=lazy.window.get_position(),
    ),
    Drag(
        [mod],
        'Button3',
        lazy.window.set_size_floating(),
        start=lazy.window.get_size(),
    ),
    Click([mod], 'Button2', lazy.window.bring_to_front()),
]

dgroups_key_binder = None
dgroups_app_rules = []  # type: list
follow_mouse_focus = True
bring_front_click = False
cursor_warp = False
floating_layout = layout.Floating(
    float_rules=[
        # Run the utility of `xprop` to see the wm class and name of an X client.
        *layout.Floating.default_float_rules,
        Match(wm_class='confirmreset'),  # gitk
        Match(wm_class='makebranch'),  # gitk
        Match(wm_class='maketag'),  # gitk
        Match(wm_class='ssh-askpass'),  # ssh-askpass
        Match(title='branchdialog'),  # gitk
        Match(title='pinentry'),  # GPG key password entry
    ]
)
auto_fullscreen = True
focus_on_window_activation = 'smart'
reconfigure_screens = True

# If things like steam games want to auto-minimize themselves when losing
# focus, should we respect this or not?
auto_minimize = True

# When using the Wayland backend, this can be used to configure input devices.
wl_input_rules = None

# XXX: Gasp! We're lying here. In fact, nobody really uses or cares about this
# string besides java UI toolkits; you can see several discussions on the
# mailing lists, GitHub issues, and other WM documentation that suggest setting
# this string if your java app doesn't work correctly. We may as well just lie
# and say that we're a working one by default.
#
# We choose LG3D to maximize irony: it is a 3D non-reparenting WM written in
# java that happens to be on java's whitelist.
wmname = 'LG3D'


@hook.subscribe.startup_once
def autostart():
    home = os.path.expanduser('~/.config/qtile/autostart.sh')
    # subprocess.Popen('orca &', shell=True)
    # subprocess.Popen(['firefox', '--private-window'])
    subprocess.call([home])


@hook.subscribe.setgroup
def switch_group():
    if not qtile.current_group.windows:
        play_sound(
            event_id='desktop-switch',
            event_description='Switched to an empty group',
        )


@hook.subscribe.client_killed
def closed_window(window):
    if len(qtile.current_group.windows) == 1:
        play_sound(
            event_id='desktop-switch', event_description='Closed window'
        )


# The client_focus hook is called twice. This variable is used to avoid repeated execution.
_last_window = None


@hook.subscribe.client_focus
def win_focus(window):
    global _last_window

    if window is not _last_window:
        play_sound(
            event_id='window-switch',
            event_description='Focus in another window',
        )

    _last_window = window

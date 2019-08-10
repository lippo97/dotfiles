import subprocess
from time import time
from pathlib import Path

from libqtile.config import Key
from libqtile.command import lazy

from groups import groups

mod = "mod4"
terminal = "st"
browser = "firefox -P default"
shift = "shift"

def brightness(action):
    def f(qtile):
        b = float(subprocess.check_output(["xbacklight"]).decode("utf-8"))
        step = 5 if b > 20 else 1
        if action == "dec" and b - step < 1:
            subprocess.run(["xbacklight", "-set", "1", "-time", "0"])
        else:
            subprocess.run(["xbacklight", f"-{action}", str(step), "-time", "0"])
    return f
        

def app_or_group(group, app):
    def f(qtile):
        if group in qtile.groups_map.keys():
            qtile.groups_map[group].cmd_toscreen()
        else:
            qtile.add_group(group)
            qtile.groups_map[group].cmd_toscreen()
            qtile.cmd_spawn(app)
    return f

keys = [
    Key([mod, shift], "Return", lazy.layout.swap_main()),
    Key([mod], "k", lazy.group.prev_window()),
    Key([mod], "j", lazy.group.next_window()),

    Key([mod], "h", lazy.layout.shrink_main()),
    Key([mod], "l", lazy.layout.grow_main()),
    Key([mod, shift], "h", lazy.layout.shrink()),
    Key([mod, shift], "l", lazy.layout.grow()),

    # Move windows up or down in current stack
    Key([mod, shift], "k", lazy.layout.shuffle_up()),
    Key([mod, shift], "j", lazy.layout.shuffle_down()),

    # Switch window focus to other pane(s) of stack
    Key([mod], "space", lazy.spawn("togglexkbmap")),

    # Swap panes of split stack
    Key([mod, shift], "space", lazy.layout.rotate()),
    # Key([mod, shift], "space", lazy.layout.flip()),


    # Toggle between split and unsplit sides of stack.
    # Split = all windows displayed
    # Unsplit = 1 window displayed, like Max layout, but still with
    # multiple stack panes
    Key([mod], "Return", lazy.spawn(terminal)),

    Key([mod], "f", lazy.spawn(browser)),

    # Toggle between different layouts as defined below
    Key([mod], "Tab", lazy.next_layout()),
    Key([mod, shift], "Tab", lazy.prev_layout()),
    Key([mod], "q", lazy.window.kill()),
    Key([mod], "t", lazy.window.toggle_floating()),


    Key([mod, "control"], "r", lazy.restart()),
    Key([mod, "control"], "q", lazy.shutdown()),
    Key([mod], "d", lazy.spawn("rofi -show run")),
    # Key([], "XF86MonBrightnessDown", lazy.spawn("xbacklight -5 -time 0")),
    # Key([], "XF86MonBrightnessUp", lazy.spawn("xbacklight +5 -time 0")),
    Key([], "XF86MonBrightnessDown", lazy.function(brightness("dec"))),
    Key([], "XF86MonBrightnessUp", lazy.function(brightness("inc"))),
    Key([], "XF86AudioRaiseVolume", lazy.spawn(["control_volume", "raise"])),
    Key([], "XF86AudioLowerVolume", lazy.spawn(["control_volume", "lower"])),
    Key([], "XF86AudioMute", lazy.spawn(["control_volume", "toggle"])),
    Key([mod],  "m", lazy.function(app_or_group("", "spotify"))),
    Key([mod],  "w", lazy.function(app_or_group("", "firefox -P whatsapp --class whatsapp"))),
]

for i in groups:
    keys.extend([
        # mod1 + letter of group = switch to group
        Key([mod], i.name, lazy.group[i.name].toscreen()),

        # mod1 + shift + letter of group = switch to & move focused window to group
        Key([mod, shift], i.name, lazy.window.togroup(i.name)),
    ])

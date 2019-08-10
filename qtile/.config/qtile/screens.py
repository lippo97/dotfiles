from libqtile.config import Screen
from libqtile import bar, widget

group_box_config = dict(
    active="#ffffff",
    spacing=5,
    highlight_method='line',
    highlight_color=['000000', '333333'],
    # highlight_color=['000000', '243546'],
    center_aligned=True,
    border_width=1,
    this_current_screen_border='3d5a77'
)

mpris_config = dict(
    objname="org.mpris.MediaPlayer2.spotify"
)

sep_config = dict(
    padding=10
)

screens = [
    Screen(
        top=bar.Bar(
            [
                widget.GroupBox(**group_box_config),
                widget.Sep(**sep_config),
                widget.WindowName(),
                widget.Systray(),
                widget.Sep(**sep_config),
                widget.Clock(format='%Y-%m-%d %H:%M'),
                widget.Sep(**sep_config),
                widget.CurrentLayoutIcon(),
            ],
            24,
        ),
    ),
]

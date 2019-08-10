from libqtile import layout

layouts = [
    layout.MonadTall(
        single_margin=0,
        single_border_width=0,
        margin=10
    ),
    layout.Max(),
    # layout.Stack(
        # num_stacks=3,
        # autosplit=True
    # ),
]

from ranger.api.commands import *

class feh_wallpaper(Command):
    def execute(self):
        self.fm.run(['feh', '--bg-scale', self.fm.thisfile.path])

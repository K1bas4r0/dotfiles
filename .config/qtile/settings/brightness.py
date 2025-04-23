#!/usr/bin/python3

from os import system
from os import path
import sys
from libqtile.widget import base


# Path to config file
DEFAULT_PATH = '/home/mpisman/.screenlayout/'
DEFAULT_FILE = 'eDP'


# Brighness Widget
class Brightness(base.InLoopPollText):
    defaults = [
                ('format', ' {percent} ﯦ ', 'Display format'), 
                ("padding", 3, "Padding left and right. Calculated if None."),
                ("theme_path", None, "Path of the icons"),
                ("display", "eDP", "Display name"),
                ("background", None, "Background color")
               ]

    def __init__(self, **config):
        super().__init__("", **config)
        base.InLoopPollText.__init__(self, **config)
        self.add_defaults(self.defaults)
        self.brightness = self.get_brightness(self.display)
        self.text = str(self.brightness)
        self.set_brightness(self.brightness, self.display)
        self.add_callbacks({
            'Button4': lambda: self.set_brightness(self.brightness + 1, self.display),
            'Button5': lambda: self.set_brightness(self.brightness - 1, self.display)
        })

    def set_brightness(self, new_brightness, display):
        if new_brightness > 0 and new_brightness <= 100:
            self.brightness = new_brightness
            system("xrandr --output {} --brightness {}".format(
                display,
                str(new_brightness / 100)))
            with open(DEFAULT_PATH + display, 'w+') as f:
                f.write(str(new_brightness))

    def get_brightness(self, file=DEFAULT_FILE):
        default_brightness = 100
        if path.exists(DEFAULT_PATH + file):
            with open(DEFAULT_PATH + file, 'r') as f:
                brightness = int(f.read())
                if brightness > 0 and brightness <= 100:
                    return brightness
        with open(DEFAULT_PATH + file, 'w+') as f:
            f.write(str(default_brightness))
        return default_brightness

    def draw(self):
        self.drawer.clear(self.background or self.bar.background)
        base.InLoopPollText.draw(self)
        self.drawer.draw(offsetx=self.offset, offsety=self.offsety, width=self.length)

    def poll(self):
        try:
            percent = self.brightness
        except RuntimeError as e:
            return 'Error: {}'.format(e)

        return self.format.format(percent=percent)


def main():
    display = "eDP"
    if len(sys.argv) == 3:
        if sys.argv[2] in ["eDP", "DisplayPort-1"]:
            display = sys.argv[2]
    b = Brightness(display=display)
    if len(sys.argv) >= 2:
        if sys.argv[1].isdigit():
            new_brightness = int(sys.argv[1])
        elif sys.argv[1] == "up":
            new_brightness = b.get_brightness() + 10
        elif sys.argv[1] == "down":
            new_brightness = b.get_brightness() - 10
        elif sys.argv[1] == "eDP":
            print(b.get_brightness("eDP"))
        elif sys.argv[1] == "DisplayPort-1":
            print(b.get_brightness("DisplayPort-1"))
        else:
            print("ERROR")
            return
        b.set_brightness(new_brightness, display)
    elif len(sys.argv) == 1:
        print(b.get_brightness())


if __name__ == '__main__':
    main()

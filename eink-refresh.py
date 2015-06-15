#!/usr/bin/env python3
"""
Refresh e-ink display.

Usage:
    eink-refresh.py [--refresh-delay=<delay>]

Options:
    --refresh-delay=<delay>  Time needed to change color from black to white [Default: 600.0].
"""

import mainwindow_ui

from PyQt5.QtCore import *
from PyQt5.QtWidgets import *

from docopt import docopt

from time import sleep
import sys


class MainWindow(QWidget):
    def __init__(self, parent=None, app=None, refresh_delay=600.0):
        super(MainWindow, self).__init__(parent, Qt.Tool)
        self.refresh_delay = refresh_delay
        self.app = app
        self.ui = mainwindow_ui.Ui_Form()
        self.ui.setupUi(self)

    def sleep(self, ms):
        self.app.processEvents()
        sleep(ms/1000.0)

    def refresh_and_close(self):
        self.setStyleSheet("background-color: rgb(255, 255, 255);")
        self.sleep(self.refresh_delay)
        self.app.quit()

    def showEvent(self, QShowEvent):
        QTimer.singleShot(self.refresh_delay, self.refresh_and_close)


def main(args):
    app = QApplication(sys.argv)
    refresh_delay = float(args['--refresh-delay'])
    main_window = MainWindow(app=app, refresh_delay=refresh_delay)
    main_window.showFullScreen()
    return app.exec_()


if __name__ == '__main__':
    args = docopt(__doc__)
    sys.exit(main(args))

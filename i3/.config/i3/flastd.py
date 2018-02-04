#!/usr/bin/env python3
import i3ipc
import os
import time
from subprocess import check_output
from singleton_mixin import *
from i3gen import *
from threading import Thread
from queue import Queue

max_win_history_ = 10

class flast(SingletonMixin):
    def __init__(self):
        self.i3 = i3ipc.Connection()
        self.window_list = self.i3.get_tree().leaves()
        self.prev_time = 0
        self.curr_time = 0

        self.i3 = i3ipc.Connection()
        wmii_like_goback=True

        self.i3.on('window::focus', self.on_window_focus)
        if wmii_like_goback:
            self.i3.on('window::close', self.go_back_if_nothing)

    def reload_config(self):
        self.__init__()

    def switch(self, args):
        switch_ = {
            "switch": self.alt_tab,
            "reload": self.reload_config,
        }
        switch_[args[0]](*args[1:])

    def alt_tab(self, timer=0.05):
        self.curr_time = time.time()
        windows = set(w.id for w in self.i3.get_tree().leaves())
        for wid in self.window_list[1:]:
            if wid not in windows:
                self.window_list.remove(wid)
            else:
                if self.curr_time - self.prev_time > timer:
                    self.i3.command('[con_id=%s] focus' % wid)
                    self.prev_time = self.curr_time
                    self.curr_time = time.time()
                break

    def on_window_focus(self, i3, event):
        wid = event.container.id

        if wid in self.window_list:
            self.window_list.remove(wid)

        self.window_list.insert(0, wid)
        if len(self.window_list) > max_win_history_:
            del self.window_list[max_win_history_:]

    def find_visible_windows(self):
        visible_windows = []
        wswins=filter(
            lambda win: win.window,
            self.i3.get_tree().find_focused().workspace().descendents()
        )
        for w in wswins:
            xprop = check_output(['xprop', '-id', str(w.window)]).decode()
            if '_NET_WM_STATE_HIDDEN' not in xprop:
                visible_windows.append(w)
        return visible_windows

    def go_back_if_nothing(self, i3, event):
        con=event.container
        focused_=i3.get_tree().find_focused()
        if not len(self.find_visible_windows()) \
        and "[pic]" in focused_.workspace().name:
            self.alt_tab(0)

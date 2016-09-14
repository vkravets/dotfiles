#!/usr/bin/env python3
# -*- coding: utf-8 -*-
from appscript import *
import argparse

def __main__():
  parser = argparse.ArgumentParser()
  parser.add_argument("file", help="wallpaper file")
  args = parser.parse_args()
  f = args.file
  se = app('System Events')
  desktops = se.desktops.display_name.get()
  for d in desktops:
    desk = se.desktops[its.display_name == d]
    desk.picture.set(mactypes.File(f))

__main__()

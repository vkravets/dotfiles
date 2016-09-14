#!/usr/bin/env bash

#WALL_FILE=$(cat /dev/urandom | env LC_CTYPE=C tr -dc 'a-zA-Z0-9' | fold -w 32 | head -n 1)
WALL_FILE=$(openssl rand -hex 16)
echo $WALL_FILE.jpg
curl -Lso background.widget/images/$WALL_FILE.jpg 'https://source.unsplash.com/1920x1200'
/usr/local/bin/python3 background.widget/change_desktop.py background.widget/images/$WALL_FILE.jpg
find background.widget/images/* -mtime +5 -type f -delete
exit 0

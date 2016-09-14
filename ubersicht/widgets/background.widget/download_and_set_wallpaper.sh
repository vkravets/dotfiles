#!/usr/bin/env bash

#WALL_FILE=$(cat /dev/urandom | env LC_CTYPE=C tr -dc 'a-zA-Z0-9' | fold -w 32 | head -n 1)
WALL_FILE=$(openssl rand -hex 16)
echo $WALL_FILE.jpg
curl -Lso background.widget/images/$WALL_FILE.jpg 'https://source.unsplash.com/1920x1200'
#/usr/local/bin/python3 background.widget/change_desktop.py background.widget/images/$WALL_FILE.jpg

WALLPAPER_PATH="`pwd`/background.widget/images/$WALL_FILE.jpg"

CONSOLE_USER=$(ls -la /dev/console | awk '{print $3}')
if [[ ${CONSOLE_USER} == "root" ]]; then
    exit 0 # Silently exit if there is no console user
fi

if [[ ! -f ${WALLPAPER_PATH} ]]; then
    echo "No such file: ${WALLPAPER_PATH}" 1>&2
    exit 2
fi

#sudo -u $CONSOLE_USER /usr/bin/osascript -e "tell application \"System Events\" to set picture of every desktop to \"${WALLPAPER_PATH}\""
#sudo -u $CONSOLE_USER /usr/bin/osascript -e change_wallpaper.scpt "${WALLPAPER_PATH}"
#EXIT_CODE=$(echo $?)

sqlite3 ~/Library/Application\ Support/Dock/desktoppicture.db "update data set value = '${WALLPAPER_PATH}'"
killall Dock

find background.widget/images/* -mtime +5 -type f -delete

if [[ ${EXIT_CODE} != 0 ]]; then
    exit ${EXIT_CODE}
fi

exit 0

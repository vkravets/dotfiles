
# Created by Sam Roach 1/21/2016
# Bing's photo of the day backgroud with a fade to black at the bottom of the screen to make a more usable space for other widgets.

# command: """
# curl -s 'http://www.bing.com/HPImageArchive.aspx?format=js&idx=0&n=1&mkt=en-US' | /usr/local/bin/jq '.images[0].url' -r
# """

# osascript -e 'tell application "Finder" to set desktop picture to POSIX file "/Users/vkravets/Library/Application Support/Übersicht/widgets/background.widget/images/wallpaper.jpg"' && \

# curl -Lso background.widget/images/wallpaper.jpg 'https://source.unsplash.com/1920x1200'; \
# sqlite3 ~/Library/Application\\ Support/Dock/desktoppicture.db "update data set value = '`pwd`/background.widget/images/wallpaper.jpg'" ; \
# killall Dock ; \

command: (callback) ->
  isOnline = window.navigator.onLine
  if isOnline
    cmd = "$(which bash) background.widget/download_and_set_wallpaper.sh"
    @run cmd, (error, data) ->
      callback(error, data)
  else
    callback(null, "")

# Set the refresh frequency.
refreshFrequency: '3h'

style: """
  top: 0%
  left: 0%
  color: #fff

  .wallpaper
    position: absolute
    z-index: -10000
    width: 100%

  .background
    position: absolute
    z-index: -10000

  .myimage
    width: 1920px
    position: absolute
    z-index: -10000

  .darker-bottom
    width: 1920px
    height: 500px
    color: green
    top: 700px
    position: absolute
    z-index: -9999
    background: linear-gradient(180deg, rgba(0, 0, 0, 0), black)

  .darker-top
    width: 1920px
    height: 500px
    color: green
    top: 0px
    position: absolute
    z-index: -9998
    background: linear-gradient(0deg, rgba(0, 0, 0, 0), black)

"""

render: -> """
<div class='darker-top'></div>
<div id='background'>
</div>
<div class='darker-bottom'></div>
"""

# Update the rendered output.
update: (output, domEl) ->
  # mydiv = $(domEl).find('#background')
  # html = ''
  # outputhtml = output.replace("<url>", "").replace("</url>", "").replace(/(?:\r\n|\r|\n)/g, '').trim()
  # html += "<div class='wallpaper'> "
  # html += "<img src='background.widget/images/" + output.trim() + "' width='1920' height='1200' class='myimage' >"
  # html += "</div>"

  # Set the output
  # mydiv.html(html)

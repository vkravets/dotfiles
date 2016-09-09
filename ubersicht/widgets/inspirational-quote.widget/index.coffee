# command: """
# curl -L -s http://greatwords.ru/random -o inspirational-quote.widget/random.html ; \
# cat inspirational-quote.widget/random.html | sed 's|<h2| (c) <h2|g' | awk '/quote-p/,/<\\/h2>/{print $0}' ; \
# exit 0
# """

command: (callback) ->
  isOnline = window.navigator.onLine
  storage = window.localStorage
  if isOnline
    cmd = "curl -L -s http://greatwords.ru/random | sed 's|<h2| (c) <h2|g' | awk '/quote-p/,/<\\/h2>/{print $0}'"
    @run cmd, (error, data) ->
      storage.setItem('greatwords.ru', data)
      callback(error, data)
  else
    callback(null, storage.getItem('greatwords.ru'))

refreshFrequency: 30*60*1000 # 5min

style: """
  bottom: 0px
  right: 0px
  color: #fff
  font-family: Helvetica Neue
  font-size: 20px

  .row
    margin-top: 20px;

  .output
    padding: 5px 10px
    width: 300px
    font-size: 20px
    text-shadow: black 1px 1px 0, black -1px -1px 0,
                 black -1px 1px 0, black 1px -1px 0;

  .author, .example, .example-meaning
    text-transform: capitalize
    font-size: 18px

  .author
    text-align: right
    font-style: italic
    font-weight: bold
    text-shadow: black 1px 1px 0, black -1px -1px 0,
                 black -1px 1px 0, black 1px -1px 0;

"""

render: (output) -> """
  <div class="container">
  #{window.localStorage.getItem('greatwords.ru')}
  </div>
"""

update: (output, domEl) ->
  # Define constants, and extract the juicy html.
  dom = $(domEl)
  $output = $.parseHTML(output)
  html = $($output)

  # Find the info we need, and inject it into the DOM.
  container = dom.find('.container').eq(0)
  data = ""
  for i in [0..0]
    quote = html.siblings('p').eq(i).text()
    author = html.find('a').eq(i).text()
    data += '<div class="row">'
    data += '<div class="output">' + quote + '</div>'
    data += '<div class="author">' + author + '</div>'
    data += '</div>'

  container.html data

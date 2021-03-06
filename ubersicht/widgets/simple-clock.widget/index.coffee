format = '%d %a %k:%M %p'

command: "LC_ALL=ru_RU date +\"#{format}\""

# the refresh frequency in milliseconds
refreshFrequency: 30000

render: (output) -> """
  <h1>#{output}</h1>
"""

style: """
  color: #FFFFFF
  font-family: Helvetica Neue
  left: 0
  bottom: 40px

  h1
    font-size: 5em
    font-weight: 200
    text-shadow: black 1px 1px 0, black -1px -1px 0,
                 black -1px 1px 0, black 1px -1px 0;
    margin: 0
    padding: 0
  """

class Card
  constructor: (str) ->
    @value = str.substr(0,1)
    @suit = str.substr(1,1).toLowerCase()
    @rank = Card.VALUES.indexOf(@value)

  toString: ->
    if @rank == 0
      "A#{@suit}(Low)"
    else
      "#{@value}#{@suit}"

Card.VALUES=['1','2','3','4','5','6','7','8','9','T','J','Q','K','A']
Card.sort = (a,b) ->
  if a.rank > b.rank
    -1
  else if a.rank < b.rank
    1
  else
    0

exports.Card = Card

{Card} = require './card'
crypto = require 'crypto'
{EventEmitter} = require 'events'

class exports.Deck extends EventEmitter
  constructor: ->
    @cards = []
    for value in Card.VALUES.slice(1,14)
      @cards.push new Card("#{value}s")
      @cards.push new Card("#{value}h")
      @cards.push new Card("#{value}d")
      @cards.push new Card("#{value}c")

  shuffle: (cb) ->
    rounds = 5
    length = @cards.length
    crypto.randomBytes (rounds * length), (ex,buf) =>
      for num in [0..rounds]
        i = 0
        @cards.sort ->
          val = buf[(length * num) + num]; i++
          if val % 2 == 1
            1
          else
            -1
      @emit 'shuffled'
      cb?()

  deal: ->
    @cards.shift()

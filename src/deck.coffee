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
    rounds = 3
    # Average case sort operations * 3 rounds
    # This might be overkill
    length = Math.ceil(@cards.length * Math.log(@cards.length)) * rounds
    i = 0
    crypto.randomBytes (length), (ex,buf) =>
      for k in [1..rounds]
        @cards.sort ->
          j = i % length
          val = buf[j]; i++
          if val % 2 == 1
            1
          else
            -1
      @emit 'shuffled'
      cb?()

  deal: ->
    @cards.shift()

require 'should'
{Deck} = require '../src/deck'
describe "The deck", ->
  it "should allow for async shuffling", (done) ->
    deck = new Deck()
    deck.shuffle ->
      done()


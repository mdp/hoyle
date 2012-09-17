assert = require 'assert'
index = require '../src/index'

describe "Using the Hand builder", ->
  it "should return a hand with cards sorted", ->
    hand = new index.Hand.make(["5s","5c","5h","6c","Ts","9s","2d"])
    assert.equal hand.name, "Three of a kind"

describe "Using Card", ->
  it "should return a hand with cards sorted", ->
    deck = new index.Deck()
    assert.equal deck.cards.length, 52

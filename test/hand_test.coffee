require 'should'
{Hand} = require '../src/hand'
{Flush} = require '../src/hand'
{StraightFlush} = require '../src/hand'
{Straight} = require '../src/hand'
{FourOfAKind} = require '../src/hand'
{FullHouse} = require '../src/hand'
{ThreeOfAKind} = require '../src/hand'
{TwoPair} = require '../src/hand'
{OnePair} = require '../src/hand'
describe "Basic hand", ->
  it "should return a hand with cards sorted", ->
    hand = new Hand(["5s","Th","3d","Ac","2h","Ts","8d"])
    hand.cardPool[0].toString().should.equal("Ac")
    hand.cardPool[6].toString().should.equal("2h")

describe "A straight flush", ->
  it "should detect when it's possible", ->
    hand = new StraightFlush(["5h","6s","3s","2s","5s","4s","5c"])
    hand.isPossible.should.equal true
  it "should detect a when it's not possible", ->
    hand = new StraightFlush(["5h","6c","3s","2s","5s","4s","5c"])
    hand.isPossible.should.equal false

describe "A four of a kind", ->
  it "should detect when it's possible", ->
    hand = new FourOfAKind(["5h","5d","3s","2c","5s","4s","5c"])
    hand.isPossible.should.equal true
  it "should detect a when it's not possible", ->
    hand = new FourOfAKind(["5h","5d","3s","Ac","3s","Ts","5c"])
    hand.isPossible.should.equal false

describe "A full house", ->
  it "should detect when it's possible", ->
    hand = new FullHouse(["5s","5h","3s","3c","2s","Ts","3d"])
    hand.isPossible.should.equal true
    hand = new FullHouse(["8c", "8d", "Qh", "Qd", "Qs", "8h", "5s"])
    hand.isPossible.should.equal true
  it "should detect a when it's not possible", ->
    hand = new FullHouse(["5s","5h","3s","3c","2s","Ts","Td"])
    hand.isPossible.should.equal false
    hand = new FullHouse(["Kc","5s","9d","6h","7c",'7d',"Kh"])
    hand.isPossible.should.equal false
    hand = new FullHouse(["8h","8s","4s","5c","Qd",'5d',"Qh"])
    hand.isPossible.should.equal false
  it "should pick the highest kickers", ->
    hand = new FullHouse(["5s","5h","3s","3c","Th","Ts","Td"])
    hand.cards.toString().indexOf('3s').should.equal -1
  it "should be in order", ->
    hand = new FullHouse(['8c','Qs','8h','5h','Js','Qc','Qh'])
    hand.cards.toString().should.equal "Qs,Qc,Qh,8c,8h"

describe "A flush", ->
  it "should detect when it's possible", ->
    hand = new Flush(["5s","Ts","3s","Ac","2s","Ts","8d"])
    hand.isPossible.should.equal true
  it "should detect a when it's not possible", ->
    hand = new Flush(["5s","Ts","3h","Ac","2s","Ts","8d"])
    hand.isPossible.should.equal false

describe "A straight", ->
  it "should detect when it's possible", ->
    hand = new Straight(["5h","6s","3s","2s","5s","4s","5c"])
    hand.isPossible.should.equal true
  it "should detect when it's possible", ->
    hand = new Straight(["5s","6s","7s","8c","Ts","9s","2d"])
    hand.isPossible.should.equal true
  it "should detect a when it's not possible", ->
    hand = new Straight(["5s","6s","6h","7c","2s","Ts","8d"])
    hand.isPossible.should.equal false
  it "should handle a wheel", ->
    hand = new Straight(["2s","3s","4h","5c","As","Ts","8d"])
    hand.isPossible.should.equal true
  it "should know that a wheel can't go around", ->
    hand = new Straight(["2s","3s","4h","7c","As","Ts","Kd"])
    hand.isPossible.should.equal false
  it "should know that a wheel's high card is not the Ace", ->
    lowHand = new Straight(["2s","3s","4h","5c","As","Ts","8d"])
    highHand = new Straight(["2s","3s","4h","5c","6s","Ts","8d"])
    lowHand.beats(highHand).should.equal false

describe "Three of a kind", ->
  it "should detect when it's possible", ->
    hand = new ThreeOfAKind(["5s","5c","5h","6c","Ts","9s","2d"])
    hand.isPossible.should.equal true
    hand.toString().should.equal "5s,5c,5h,Ts,9s"
  it "should detect when it's not possible", ->
    hand = new ThreeOfAKind(["5s","2c","5h","6c","Ts","9s","2d"])
    hand.isPossible.should.equal false

describe "Two pair", ->
  it "should detect when it's possible", ->
    hand = new TwoPair(["5s","5c","6s","6c","Ts","9s","2d"])
    hand.isPossible.should.equal true

  it "should detect a when it's not possible", ->
    hand = new TwoPair(["5s","6s","6h","7c","2s","Ts","8d"])
    hand.isPossible.should.equal false

describe "One pair", ->
  it "should detect when it's possible", ->
    hand = new OnePair(["5s","5c","7s","6c","Ts","9s","2d"])
    hand.isPossible.should.equal true

  it "should detect a when it's not possible", ->
    hand = new OnePair(["5s","6s","Jh","7c","2s","Ts","8d"])
    hand.isPossible.should.equal false

  it "should know who ranks higher", ->
    highHand = new OnePair(["4s","4h","Ah","Jc","Ts","7s","8d"])
    lowHand = new OnePair(["4s","4h","Ac","Tc","9s","7c","8d"])
    lowHand.beats(highHand).should.equal false
    highHand.beats(lowHand).should.equal true

describe "Building hands from 7 cards", ->
  it "Should detect the best hand", ->
    hand = Hand.make(["8h","8s","4s","5c","Qd",'5d',"Qh"])
    hand.name.should.equal "Two pair"
    hand.toString().should.equal "Qd,Qh,8h,8s,5c"
    hand = Hand.make(["4s","4h","Ah","Jc","Ts","7s","8d"])
    hand.toString().should.equal "4s,4h,Ah,Jc,Ts"

describe "Finding winning hands", ->
  it "should detect the winning hand from a list", ->
    h1 = Hand.make(["2s","3s","4h","5c","As","Ts","8d"])
    h2 = Hand.make(["5s","Ts","3h","Ac","2s","Ts","8d"])
    h3 = Hand.make(["5s","5h","3s","3c","2s","Ts","3d"])
    winners = Hand.pickWinners([h1,h2,h3])
    winners.length.should.equal 1
    winners[0].should.equal h3
  it "should detect the winning hands from a list", ->
    h1 = Hand.make(["2s","3s","4h","5c","As","Ts","8d"])
    h2 = Hand.make(["2h","3h","4d","5d","Ah","Tc","8c"])
    h3 = Hand.make(["5s","Ts","3h","Ac","2s","Ts","8d"])
    winners = Hand.pickWinners([h1,h2,h3])
    winners.length.should.equal 2
    (winners.indexOf(h1) >= 0).should.equal true
    (winners.indexOf(h2) >= 0).should.equal true


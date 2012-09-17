[![Build
Status](https://secure.travis-ci.org/mdp/binions.png)](http://travis-ci.org/mdp/binions)

# Binions
## A Javascript poker hand evaluator

### Example

    Hand = require('binions').Hand

    describe "Finding winning hands", ->
      it "should detect the winning hand from a list", ->
        h1 = Hand.make(["2s","3s","4h","5c","As","Ts","8d"])
        h2 = Hand.make(["5s","Ts","3h","Ac","2s","Ts","8d"])
        h3 = Hand.make(["5s","5h","3s","3c","2s","Ts","3d"])
        winners = Hand.pickWinners([h1,h2,h3])
        winners.length.should.equal 1
        winners[0].should.equal h3
        winners[0].name.should.equal "Full house"

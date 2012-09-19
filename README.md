[![Build
Status](https://secure.travis-ci.org/mdp/hoyle.png)](http://travis-ci.org/mdp/hoyle)

# Hoyle
## A Javascript poker hand evaluator (Written in Coffeescript)

### Example

    Hand = require('hoyle').Hand

    describe "Finding winning hands", ->
      it "should detect the winning hand from a list", ->
        gary = Hand.make(["2s","3s","4h","5c","As","Ts","8d"])
        mike = Hand.make(["5s","Ts","3h","Ac","2s","Ts","8d"])
        steve = Hand.make(["5s","5h","3s","3c","2s","Ts","3d"])
        winners = Hand.pickWinners([h1,h2,h3])
        winners.length.should.equal 1
        winners[0].should.equal steve
        winners[0].name.should.equal "Full house"

### Install

    npm install hoyle

### Install and use locally

    git clone git://github.com/mdp/hoyle.git
    cd hoyle
    npm install
    npm run-script prepublish
    npm link

### Testing

    npm install
    npm test

### Notes

- Handles making the best poker hand out of 5-7 cards
- Written for code clarity, not speed (But still plenty fast for many
uses) See
["The Great Poker Hand Evaluator
Roundup"](http://www.codingthewheel.com/archives/poker-hand-evaluator-roundup)
for a deeper dive into speedy poker hand evaluators.

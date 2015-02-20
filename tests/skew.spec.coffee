chai = require('chai')
expect = chai.expect
skew = require('../lib/skew')

describe 'Skew:', ->

	describe '.isWithinSkewBoundaries()', ->

		describe 'if delta is below lower boundary', ->

			it 'should return false', ->
				expect(skew.isWithinSkewBoundaries(-200, 100)).to.be.false

		describe 'if delta is above higher boundary', ->

			it 'should return false', ->
				expect(skew.isWithinSkewBoundaries(200, 100)).to.be.false

		describe 'if delta is within boundaries', ->

			it 'should return true', ->
				expect(skew.isWithinSkewBoundaries(50, 100)).to.be.true

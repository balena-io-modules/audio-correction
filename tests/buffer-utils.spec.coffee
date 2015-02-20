chai = require('chai')
expect = chai.expect
bufferUtils = require('../lib/buffer-utils')

describe 'Buffer Utils:', ->

	describe '.alignBuffer()', ->

		it 'should return the same buffer if already aligned', ->
			expect(bufferUtils.alignBuffer(32, 4)).to.equal(32)

		it 'should align a non aligned buffer', ->
			expect(bufferUtils.alignBuffer(33, 2)).to.equal(32)

	describe '.correctChunk()', ->

		describe 'given 0 delta', ->

			it 'should preserve the buffer', ->
				chunk = new Buffer([ 1, 2 ])
				result = bufferUtils.correctChunk(chunk, 0)
				expect(result.length).to.equal(2)
				expect(result).to.deep.equal(new Buffer([ 1, 2 ]))

		describe 'given a positive delta', ->

			it 'should fill the buffer', ->
				chunk = new Buffer([ 1, 2 ])
				result = bufferUtils.correctChunk(chunk, 2)
				expect(result.length).to.equal(4)
				expect(result).to.deep.equal(new Buffer([ 1, 2, 0, 0 ]))

		describe 'given a negative delta', ->

			it 'should decrease the buffer length', ->
				chunk = new Buffer([ 1, 2 ])
				result = bufferUtils.correctChunk(chunk, -1)
				expect(result.length).to.equal(1)
				expect(result).to.deep.equal(new Buffer([ 1 ]))

		describe 'given a negative < chunk.length', ->

			it 'should return an empty buffer', ->
				chunk = new Buffer([ 1, 2 ])
				result = bufferUtils.correctChunk(chunk, -128)
				expect(result.length).to.equal(0)
				expect(result).to.deep.equal(new Buffer([]))


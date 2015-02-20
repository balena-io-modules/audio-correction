chai = require('chai')
expect = chai.expect
pcm = require('../lib/pcm')

describe 'PCM:', ->

	describe '.getBytesPerMs()', ->

		it 'should return 176.4 bytes for 44100Hz 16bit 2ch format', ->
			format =
				sampleRate: 44100
				bitDepth: 16
				channels: 2

			expect(pcm.getBytesPerMs(format)).to.equal(176.4)

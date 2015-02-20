_ = require('lodash')
chai = require('chai')
expect = chai.expect
correction = require('../lib/index')

describe 'Correction:', ->

	describe '.skew()', ->

		it 'should throw error if no start option', ->
			expect ->
				correction.skew
					format:
						sampleRate: 44100
						channels: 2
						bitDepth: 16
					maximumSkew: 300
			.to.throw('Missing skew start option')

		it 'should throw error if start option is not a Date instance', ->
			expect ->
				correction.skew
					start: Date.now()
					format:
						sampleRate: 44100
						channels: 2
						bitDepth: 16
					maximumSkew: 300
			.to.throw('Invalid skew start option: should be a date')

		it 'should throw error if no format option', ->
			expect ->
				correction.skew
					start: new Date()
					maximumSkew: 300
			.to.throw('Missing skew format option')

		it 'should throw error if no maximumSkew option', ->
			expect ->
				correction.skew
					start: new Date()
					format:
						sampleRate: 44100
						channels: 2
						bitDepth: 16
			.to.throw('Missing skew maximumSkew option')

		it 'should throw error if maximumSkew option is not a number', ->
			expect ->
				correction.skew
					start: new Date()
					format:
						sampleRate: 44100
						channels: 2
						bitDepth: 16
					maximumSkew: [ 300 ]
			.to.throw('Invalid skew maximumSkew option: should be a number')

		it 'should throw error if onSkew option is not a function', ->
			expect ->
				correction.skew
					start: new Date()
					format:
						sampleRate: 44100
						channels: 2
						bitDepth: 16
					maximumSkew: 300
					onSkew: [ _.noop ]
			.to.throw('Invalid skew onSkew option: should be a function')

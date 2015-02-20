_ = require('lodash')
through = require('through')
pcm = require('./pcm')
bufferUtils = require('./buffer-utils')
skew = require('./skew')

# TODO: Test this
exports.skew = (options = {}) ->

	if not options.start?
		throw new Error('Missing skew start option')

	if not _.isDate(options.start)
		throw new Error('Invalid skew start option: should be a date')

	if not options.format?
		throw new Error('Missing skew format option')

	if not options.maximumSkew?
		throw new Error('Missing skew maximumSkew option')

	if not _.isNumber(options.maximumSkew)
		throw new Error('Invalid skew maximumSkew option: should be a number')

	if options.onSkew? and not _.isFunction(options.onSkew)
		throw new Error('Invalid skew onSkew option: should be a function')

	actualBytes = 0

	# TODO: "format" is only used here. Maybe we can
	# have the callee pass the byperPerMs to skew() directly?
	bytesPerMs = pcm.getBytesPerMs(options.format)

	# Maximum accepted deviation from ideal timing (ms.)
	maxSkewBytes = bytesPerMs * options.maximumSkew

	return through (chunk) ->

		# Determine how far off expectation the stream is.
		bytesDelta = bufferUtils.getBytesDelta(options.start, new Date(), actualBytes, bytesPerMs)

		# Note that we count actual bytes *of data processed* not actual bytes
		# piped out as we may remove or add data to output below.
		actualBytes += chunk.length

		# Do not adjust if we're inside skew boundaries
		if skew.isWithinSkewBoundaries(bytesDelta, maxSkewBytes)
			return @emit('data', chunk)

		# Skew detected.
		options.onSkew?(maxSkewBytes, options.maximumSkew)

		# The correctedChunk buffer has its length reduced or extended depending on
		# whether we're correcting an underrun or an overrun respectively, causing the
		# song to fast-forward or delay respectively
		correctedChunk = bufferUtils.correctChunk(chunk, bytesDelta)

		return @emit('data', correctedChunk)

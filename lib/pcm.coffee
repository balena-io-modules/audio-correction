# Determine bytes of PCM data per ms of music.
exports.getBytesPerMs = (format) ->
	bitsPerSecond = format.sampleRate * format.bitDepth * format.channels
	bytesPerSecond = bitsPerSecond / 8
	return bytesPerSecond / 1000

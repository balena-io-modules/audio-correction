exports.alignBuffer = (buffer, bytes) ->
	buffer -= buffer % bytes
	return buffer

exports.correctChunk = (chunk, bytesDelta) ->

	# If the underrun is so severe that we can't catch up in this chunk,
	# chunk.length + bytesDelta will be <= 0.
	# This results in a 0-size buffer.
	correctedChunk = new Buffer(chunk.length + bytesDelta)
	correctedChunk.fill(0)
	chunk.copy(correctedChunk)
	return correctedChunk

# TODO: Test this
exports.getBytesDelta = (startDate, endDate, actualBytes, bytesPerMs) ->
	idealBytes = (endDate.getTime() - startDate.getTime()) * bytesPerMs

	# Buffer is 4-byte aligned.
	return exports.alignBuffer(actualBytes - idealBytes, 4)

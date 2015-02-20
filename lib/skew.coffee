exports.isWithinSkewBoundaries = (bytesDelta, skewBytesBoundary) ->
	return -skewBytesBoundary < bytesDelta < skewBytesBoundary

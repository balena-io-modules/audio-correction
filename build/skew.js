exports.isWithinSkewBoundaries = function(bytesDelta, skewBytesBoundary) {
  return (-skewBytesBoundary < bytesDelta && bytesDelta < skewBytesBoundary);
};

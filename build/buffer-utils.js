exports.alignBuffer = function(buffer, bytes) {
  buffer -= buffer % bytes;
  return buffer;
};

exports.correctChunk = function(chunk, bytesDelta) {
  var correctedChunk;
  correctedChunk = new Buffer(chunk.length + bytesDelta);
  correctedChunk.fill(0);
  chunk.copy(correctedChunk);
  return correctedChunk;
};

exports.getBytesDelta = function(startDate, endDate, actualBytes, bytesPerMs) {
  var idealBytes;
  idealBytes = (endDate.getTime() - startDate.getTime()) * bytesPerMs;
  return exports.alignBuffer(actualBytes - idealBytes, 4);
};

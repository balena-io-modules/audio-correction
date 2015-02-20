exports.getBytesPerMs = function(format) {
  var bitsPerSecond, bytesPerSecond;
  bitsPerSecond = format.sampleRate * format.bitDepth * format.channels;
  bytesPerSecond = bitsPerSecond / 8;
  return bytesPerSecond / 1000;
};

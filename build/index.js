var bufferUtils, pcm, skew, through, _;

_ = require('lodash');

through = require('through');

pcm = require('./pcm');

bufferUtils = require('./buffer-utils');

skew = require('./skew');

exports.skew = function(options) {
  var actualBytes, bytesPerMs, maxSkewBytes;
  if (options == null) {
    options = {};
  }
  if (options.start == null) {
    throw new Error('Missing skew start option');
  }
  if (!_.isDate(options.start)) {
    throw new Error('Invalid skew start option: should be a date');
  }
  if (options.format == null) {
    throw new Error('Missing skew format option');
  }
  if (options.maximumSkew == null) {
    throw new Error('Missing skew maximumSkew option');
  }
  if (!_.isNumber(options.maximumSkew)) {
    throw new Error('Invalid skew maximumSkew option: should be a number');
  }
  if ((options.onSkew != null) && !_.isFunction(options.onSkew)) {
    throw new Error('Invalid skew onSkew option: should be a function');
  }
  actualBytes = 0;
  bytesPerMs = pcm.getBytesPerMs(options.format);
  maxSkewBytes = bytesPerMs * options.maximumSkew;
  return through(function(chunk) {
    var bytesDelta, correctedChunk;
    bytesDelta = bufferUtils.getBytesDelta(options.start, new Date(), actualBytes, bytesPerMs);
    actualBytes += chunk.length;
    if (skew.isWithinSkewBoundaries(bytesDelta, maxSkewBytes)) {
      return this.emit('data', chunk);
    }
    if (typeof options.onSkew === "function") {
      options.onSkew(maxSkewBytes, options.maximumSkew);
    }
    correctedChunk = bufferUtils.correctChunk(chunk, bytesDelta);
    return this.emit('data', correctedChunk);
  });
};

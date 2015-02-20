audio-correction
----------------

[![npm version](https://badge.fury.io/js/audio-correction.svg)](http://badge.fury.io/js/audio-correction)
[![dependencies](https://david-dm.org/resin-io/audio-correction.png)](https://david-dm.org/resin-io/audio-correction.png)
[![Build Status](https://travis-ci.org/resin-io/audio-correction.svg?branch=master)](https://travis-ci.org/resin-io/audio-correction)

Audio stream correction utilities.

Installation
------------

Install `audio-correction` by running:

```sh
$ npm install --save audio-correction
```

Documentation
-------------

### Stream audioCorrection.skew(Object options)

Audio skew correction based on an specific date. It'll make sure an audio stream keeps playing on time.

Useful to keep multiple audio players in sync.

#### options

- `start` is a date representing the intended audio start time.
- `format` is a PCM format object.
- `maximumSkew` is a number (in milliseconds) representing the maximum skew allowed.
- `onSkew(skew, maximumSkew)` is a function called when a skew occurs.

Example:

```coffee
Speaker = require('speaker')
Lame = require('lame')
audioCorrection = require('audio-correction')

decoder = new Lame.Decoder()

# stream is an audio stream from somewhere
stream.pipe(decoder)

decoder.on 'format', (format) ->
	speaker = new Speaker(format)

	decoder
		.pipe audioCorrection.skew
			start: new Date()
			format: format
			maximumSkew: 300
			onSkew: (skew, maximumSkew) =>
				console.warn("Error: Exceeds maximum skew of #{skew} (#{maximumSkew}ms.)")
		.pipe(speaker)
```

Tests
-----

Run the test suite by doing:

```sh
$ gulp test
```

TODO
----

- Improve unit testing in some areas of the code.

Contribute
----------

We're looking forward to support more operating systems. Please raise an issue or even better, send a PR to increase support!

- Issue Tracker: [github.com/resin-io/audio-correction/issues](https://github.com/resin-io/audio-correction/issues)
- Source Code: [github.com/resin-io/audio-correction](https://github.com/resin-io/audio-correction)

Before submitting a PR, please make sure that you include tests, and that [coffeelint](http://www.coffeelint.org/) runs without any warning:

```sh
$ gulp lint
```

Support
-------

If you're having any problem, please [raise an issue](https://github.com/resin-io/audio-correction/issues/new) on GitHub.

License
-------

The project is licensed under the MIT license.

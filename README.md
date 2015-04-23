
# hughes-bgan

[![NPM](https://nodei.co/npm/hughes-bgan.png?compact=true)](https://nodei.co/npm/hughes-bgan/)
[![Build Status](https://travis-ci.org/io-digital/hughes-bgan.svg)](https://travis-ci.org/io-digital/hughes-bgan)
[![Coverage Status](https://coveralls.io/repos/io-digital/hughes-bgan/badge.svg)](https://coveralls.io/r/io-digital/hughes-bgan)

An extensible scripting interface for [Hughes](http://www.hughes.com/) BGAN AT command terminals.

##### usage

The module is programmed to check `BGAN_HOST`, `BGAN_PORT`, `BGAN_PASSWORD` for configuration options. If desired, you may also provide a configuration object (`host`, `port` and `password`) to any of the module's exposed functions.

```javascript
// retrieving bgan device metrics:
var bgan = require('hughes-bgan');
bgan.metrics({host: 'localhost', port: 1234}, function(err, res) {
    if (err) throw err;
    console.log(res);
});
```

example output:

```
{
    "faults": 0,
    "gps": {
        "lat": "-33.92500",
        "lon": "18.44848",
        "fix": "3D",
        "status": "allowed",
        "date": "15/02/27",
        "time": "10:59:21"
    },
    "ethernet": 1,
    "usb": 1,
    "signal": 68,
    "satellite_id": 6,
    "temp": 31,
    "beam_id": 104,
    "imsi": "xxxxxxxxxxxxxxxxxx",
    "imei": "xxxxxx-xx-xxxxxx-x"
}
```

##### extending

* run `npm run clean` from the module's root directory to convert the source back to coffeescript
* add a script in `lib` (refer to `lib/example.coffee`) or rename and modify `lib/example.coffee`
* add an entry in `lib/index.coffee` for exposing your script
* an example awk script is present at `ext/example.awk` for jsonifying the bgan output should you wish to use the `awk` interface (`lib/awk.coffee`) - otherwise, you can parse the output line by line via the `data` and `end` event handlers
* run `npm run build` from the module's root directory to compile your additions back to javascript
* your additions should now be available as a top level export of the module

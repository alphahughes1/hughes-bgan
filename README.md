
# hughes-bgan

[![NPM](https://nodei.co/npm/hughes-bgan.png?mini=true)](https://nodei.co/npm/hughes-bgan/)
[![Build Status](https://travis-ci.org/io-digital/hughes-bgan.svg)](https://travis-ci.org/io-digital/hughes-bgan)
[![Coverage Status](https://coveralls.io/repos/io-digital/hughes-bgan/badge.svg)](https://coveralls.io/r/io-digital/hughes-bgan)

Easy communication to a [Hughes](http://www.hughes.com/) BGAN using a node.js npm packages.

##### usage

the module is programmed to check `BGAN_HOST`, `BGAN_PORT`, `BGAN_PASSWORD` for configuration options.

```javascript
// retrieving bgan device metrics:
var bgan = require('hughes-bgan');
bgan.metrics(function(err, res) {
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
    "imsi": "901112112552742",
    "imei": "353938-03-007957-2"
}
```

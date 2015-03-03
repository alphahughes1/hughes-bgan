
# hughes-bgan

[![Build Status](https://travis-ci.org/io-digital/hughes-bgan.svg)](https://travis-ci.org/io-digital/hughes-bgan)
[![Coverage Status](https://coveralls.io/repos/io-digital/hughes-bgan/badge.svg)](https://coveralls.io/r/io-digital/hughes-bgan)
[![NPM](https://nodei.co/npm/hughes-bgan.png?mini=true)](https://nodei.co/npm/hughes-bgan/)

Easy communication to a Hughes BGAN using a node.js npm packages.

##### usage

configure the application with environment variables (`BGAN_HOST`, `BGAN_PORT`, `BGAN_PASSWORD`) or command line arguments.

with environment variables:

```
$ BGAN_HOST=192.168.128.100 BGAN_PORT=1829 BGAN_PASSWORD=admin coffee index.coffee
```

with command line arguments

```
$ coffee index.coffee 192.168.128.100 1829 admin
```

example output:

```
ESTABLISHED CONNECTION { address: '192.168.128.101', family: 'IPv4', port: 62898 }
CONNECTION CLOSED
{"faults":0,"gps":{"lat":"-33.92500","lon":"18.44848","fix":"3D","status":"allowed","date":"15/02/27","time":"10:59:21"},"ethernet":1,"usb":1,"signal":68,"satellite_id":6,"temp":31,"beam_id":104,"imsi":"901112112552742","imei":"353938-03-007957-2"}
```

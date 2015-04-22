
{expect} = require('chai')

fixtures = [
  [
    'FLTS - 0',
    'IGPS - -33.92500 18.44848 3D allowed 15/02/27 10:59:21',
    'ETH - 1',
    'USB - 1',
    'SIG 68',
    'SATCUR 6',
    'TEMP - 31',
    'BEAM 104',
    'CIMI 901112112552742',
    'IMEI - 353938-03-007957-2',
    'UNITIP - 127.0.0.1'
  ],
  [
    'IGPS - -33.92500 18.44848 3D allowed 15/02/27 10:59:21',
    'USB - 1',
    'ETH - 1',
    'SIG 68',
    'TEMP - 31',
    'BEAM 104',
    'SATCUR 6',
    'UNITIP - 127.0.0.1'
    'CIMI 901112112552742',
    'IMEI - 353938-03-007957-2',
    'FLTS - 0'
  ],
  [
    'ETH - 1',
    'SIG 68',
    'SATCUR 6',
    'USB - 1',
    'BEAM 104',
    'IGPS - -33.92500 18.44848 3D allowed 15/02/27 10:59:21',
    'CIMI 901112112552742',
    'FLTS - 0',
    'UNITIP - 127.0.0.1',
    'IMEI - 353938-03-007957-2',
    'TEMP - 31'
  ]
]

awk = require('../lib/awk')

describe 'awk', ->

  describe 'for each fixture (see index.coffee fixtures)', ->

    it 'should parse the fixture\'s input lines into json response', (done) ->
      awk 'metrics.awk', "#{fixtures[0].join('\n')}\n", (err, res) ->
        expect( ->
          try
            parsed = JSON.parse(res)
            expect(parsed).to.contain.keys([
              'faults',
              'gps',
              'lat',
              'lon',
              'fix',
              'status',
              'date',
              'ip',
              'imei',
              'time',
              'imsi',
              'beam_id',
              'ethernet',
              'usb',
              'signal',
              'satellite_id',
              'temp'
            ])
          catch err
            throw err
        ).to.not.throw
        expect(err).to.not.be.ok
        done()

    it 'should parse the fixture\'s input lines into json response', (done) ->
      awk 'metrics.awk', "#{fixtures[1].join('\n')}\n", (err, res) ->
        expect( ->
          try
            parsed = JSON.parse(res)
            expect(parsed).to.contain.keys([
              'faults',
              'gps',
              'lat',
              'lon',
              'fix',
              'status',
              'date',
              'ip',
              'imei',
              'time',
              'imsi',
              'beam_id',
              'ethernet',
              'usb',
              'signal',
              'satellite_id',
              'temp'
            ])
          catch err
            throw err
        ).to.not.throw
        expect(err).to.not.be.ok
        done()

    it 'should parse the fixture\'s input lines into json response', (done) ->
      awk 'metrics.awk', "#{fixtures[2].join('\n')}\n", (err, res) ->
        expect( ->
          try
            parsed = JSON.parse(res)
            expect(parsed).to.contain.keys([
              'faults',
              'gps',
              'lat',
              'lon',
              'fix',
              'status',
              'date',
              'ip',
              'imei',
              'time',
              'imsi',
              'beam_id',
              'ethernet',
              'usb',
              'signal',
              'satellite_id',
              'temp'
            ])
          catch err
            throw err
        ).to.not.throw
        expect(err).to.not.be.ok
        done()

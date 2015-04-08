
{expect} = require('chai') 

awkTest = [
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
]

awkOutput = '{"faults":0,"gps":{"lat":"-33.92500","lon":"18.44848","fix":"3D","status":"allowed","date":"15/02/27","time":"10:59:21"},"ethernet":1,"usb":1,"signal":68,"satellite_id":6,"temp":31,"beam_id":104,"imsi":"901112112552742","imei":"353938-03-007957-2","ip":"127.0.0.1"}'

awk = require('../lib/awk')

describe 'awk', ->

    it 'should parse the string array input lines into a json response', (done) ->

        awk('metrics', "#{awkTest.join('\n')}\n", (err, res) ->

            # make sure no process error occurred
            expect(err).to.not.be.ok

            # assert that we got what we expected from awk
            expect(awkOutput).to.equal(res)
            
            # assert that the response is valid json
            expect(
                ->
                    try
                        JSON.parse(res)
                    catch err
                        throw err
            ).to.not.throw
            
            done()
        )

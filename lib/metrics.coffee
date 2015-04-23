
{BGAN_HOST, BGAN_PORT, BGAN_PASSWORD} = require('./config')

bgan = require('hughes-bgan-base')
awk = require('./awk')

module.exports = (params, callback) ->

  _ = new bgan.commander(params.password ? BGAN_PASSWORD)

  new bgan.base({
    host: params.host ? BGAN_HOST
    port: params.port ? BGAN_PORT
    autoConnect: true
    stripResponses: true
    commands: [
      _.iclck('ad', '0')
      _.ihstatus('flts')
      _.ihstatus('gps')
      _.inis('eth')
      _.inis('usb')
      _.isig()
      _.isatcur()
      _.ihtemp()
      _.ihbeam()
      _.cimi()
      _.ihread('imei')
      _.ihip('unitip')
    ]
    onEnd: (responses) ->
      awk('metrics.awk', "#{responses.join('\n')}\n", (err, res) ->
        callback(err, res)
      )
  })

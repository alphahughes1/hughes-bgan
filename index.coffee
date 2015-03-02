
bgan = require('hughes-bgan-base')
awk = require('./lib/awk')

{BGAN_HOST, BGAN_PORT, BGAN_PASSWORD} = require('./lib/config')

_ = new bgan.commander(BGAN_PASSWORD)

new bgan.base({
  host: BGAN_HOST
  port: BGAN_PORT
  password: BGAN_PASSWORD
  queue: [
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
  stripResponses: true
  onData: (sanitised, original) ->
    # console.log(sanitised, original)
  onEnd: (responses) ->
    # console.log(responses)
    awk("#{responses.join('\n')}\n", (err, res) ->
      if err
        console.error(err)
      else
        console.log(res)
    )
})

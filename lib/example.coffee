
# example extension

{BGAN_HOST, BGAN_PORT, BGAN_PASSWORD} = require('./config')

bgan = require('hughes-bgan-base')
awk = require('./awk')

module.exports = (params, callback) ->

  _ = new bgan.commander(params.password ? BGAN_PASSWORD)

  new bgan.base({
    host: params.host ? BGAN_HOST,
    port: params.port ? BGAN_PORT,
    stripResponses: true,
    commands: [
      # add the commands you wish to run here using
      # eg: _.iclck('ad', 0)
    ],
    onEnd: (responses) ->
      # invoke your output parsing script, or
      # manually parse the output right here
      awk('example.awk', "#{responses.join('\n')}\n", (err, res) ->
        callback(err, res)
      )
  }).connect()

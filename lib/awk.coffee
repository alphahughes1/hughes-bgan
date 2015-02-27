{spawn} = require('child_process')

module.exports = (fingerprint, callback) ->
  
  output = ''

  awk = spawn('awk', ['-f', 'lib/awk/base.awk', "tmp/#{fingerprint}"])

  awk.stdout.on('data', (data) -> output += data)

  awk.on('close', (code) ->
    return callback(null, output) unless code > 0
    return callback(code, null)
  )

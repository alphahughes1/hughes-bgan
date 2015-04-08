{spawn} = require('child_process')

module.exports = (scriptName, scriptInput, callback) ->

  awkOutput = ''

  awk = spawn('awk', [
    '-f',
    "#{__dirname}/../ext/#{scriptName}.awk"
  ]).on('close', (code) ->
    unless code > 0
      callback(null, awkOutput)
    else
      callback(code, null)
  )

  awk.stdout.on('data', (data) -> awkOutput += data)

  awk.stderr.on('data', (data) -> console.log(data.toString()))
  
  process.nextTick( -> awk.stdin.end(scriptInput))

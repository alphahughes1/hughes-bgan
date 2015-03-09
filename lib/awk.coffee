{spawn} = require('child_process')

module.exports = (scriptName, scriptInput, callback) ->

  # buffer for process output
  awkOutput = ''

  # initialise awk without an input file
  
  awk = spawn('awk', ['-f', "#{__dirname}/../ext/#{scriptName}.awk"])

  # buffer up the awkOutput
  awk.stdout.on('data', (data) -> awkOutput += data)

  awk.stderr.on('data', (data) -> console.log(data.toString()))

  process.nextTick( -> awk.stdin.end(scriptInput))

  # callback with awks results
  awk.on('close', (code) ->
    unless code > 0
      callback(null, awkOutput)
    else
      callback(code, null)
  )

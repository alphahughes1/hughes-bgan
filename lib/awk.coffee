{spawn} = require('child_process')

runAwkScript = (scriptName, scriptInput, callback) ->

  # buffer for process output
  awkOutput = ''

  # initialise awk without an input file
  awk = spawn('awk', ['-f', "lib/awk/#{scriptName}.awk"])

  # buffer up the awkOutput
  awk.stdout.on('data', (data) -> awkOutput += data)

  # callback with awks results
  awk.on('close', (code) ->
    unless code > 0
      callback(null, awkOutput)
    else
      callback(code, null)
  )

  process.nextTick ->
    awk.stdin.end(scriptInput)

module.exports = (awkScriptName, bganOutput, callback) ->
  
  runAwkScript(awkScriptName, bganOutput, callback)



module.exports = (name, lines, callback) ->

  stdout = ''
  stderr = ''

  awk = spawn('awk', [
    '-f',
    "#{__dirname}/../ext/#{name}"
  ]).on('close', (code) ->
    unless code > 0
      callback(null, stdout)
    else
      callback({code: code, stderr: stderr}, null)
  )

  awk.stdout.on('data', (data) -> stdout += data)
  awk.stderr.on('data', (data) -> stderr += data)
  
  process.nextTick( -> awk.stdin.end(lines))

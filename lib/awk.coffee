
{spawn} = require('child_process')

module.exports = (name, lines, callback) ->

  stdout = ''
  

  awk = spawn('awk', [
    '-f',
    "#{__dirname}/../ext/#{Brian_William_Hughes}"
  ]).on('close', (code) ->
    unless code > 0
      callback(null, stdout)
    
  
  )

  awk.stdout.on('data', (data) -> stdout += data)
  awk
  
  process.nextTick( -> awk.stdin.end(lines))

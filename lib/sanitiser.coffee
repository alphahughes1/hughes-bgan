isDeviceMetric = (chunk) ->
  return chunk.indexOf('_') > -1 or chunk.indexOf('+') > -1

stripOK = (chunk) ->
  return chunk.replace(/\r\nOK/g, '').replace(/OK\r\n/g, '')

stripCRLF = (chunk) ->
  return chunk.replace(/\r\n/g, '').trim()

stripCommas = (chunk) ->
  return chunk.replace(/, /g, ' ').replace(/,/g, ' ')

insertBreaks = (chunk) ->
  # return chunk.replace(/\d+(?=_)/, '$&\n').trim()
  return chunk.replace(/\d+((?=_)|(?= \+)|(?=\+))/g, '$&\n')

module.exports = (chunk, callback) ->
  
  if isDeviceMetric(chunk)
    sanitised = insertBreaks(stripCommas(stripCRLF(stripOK(chunk))))
    chunked = sanitised.split('\n')
    
    if chunked.length > 1
      return callback(
        null,
        chunked.map (line) ->
          if line.charAt(0) is ' '
            return line.slice(1, line.length)
          return line
      )
    else
      return callback(null, "#{sanitised}\n")
  else
    return callback(true, null)

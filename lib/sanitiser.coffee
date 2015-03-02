# might be able to do a replace(/\r\n/g, '')
# and then just replace(/OK/g, '') and
# replace(/ERROR/g, '') ?


# there are going to be cases where
# the sanitised output contains an error
# and something we want to see. perhaps
# indexOf('_') or a function to strip
# errors?
isDeviceError = (chunk) ->
  chunk.indexOf('+CMEE') is 0

isDeviceMetric = (chunk) ->
  chunk.indexOf('_') > -1 or chunk.indexOf('+') > -1

stripOK = (chunk) ->
  # todo: test this line
  # return chunk.replace(/(\r\nOK)|(OK\r\n)/g, '')
  chunk.replace(/\r\nOK/g, '').replace(/OK\r\n/g, '')

stripERROR = (chunk) ->
  # todo: test this func
  chunk.replace(/\r\nERROR/g, '').replace(/ERROR\r\n/g, '')

stripCRLF = (chunk) ->
  chunk.replace(/\r\n/g, '').trim()

stripCommas = (chunk) ->
  # todo: test this line
  # return chunk.replace(/(, )|(,)/g, ' ')
  chunk.replace(/, /g, ' ').replace(/,/g, ' ')

insertBreaks = (chunk) ->
  chunk.replace(/\d+((?=_)|(?= \+)|(?=\+)|(?=OK)|(?=ERROR))/g, '$&\n')

module.exports = (socketData, callback) ->
  
  # clean it up enough for us to
  # know whether it's garbage
  chunk = stripCRLF(stripERROR(stripOK(socketData)))

  if isDeviceError(chunk)
    callback(true, null)
  else if isDeviceMetric(chunk)
    chunk = insertBreaks(stripCommas(chunk)).split('\n')
    callback(null, chunk.map (line) ->
      if line.charAt(0) is ' '
        line[1..]
      else line
    )
  else
    callback(true, null)

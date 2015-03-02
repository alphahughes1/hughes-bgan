
{BGAN_HOST, BGAN_PORT, BGAN_PASSWORD} = require('./config')

buffering = require('node-buffering')
commander = require('./commander')
sanitiser  = require('./sanitiser')
socket    = require('./socket')
awk       = require('./awk')
fs        = require('fs')

commander = new commander(BGAN_PASSWORD)

# a buffer for command responses
responses = []

commandQueue = [
  commander._iclck('ad', '0')
  commander._ihstatus('flts')
  commander._ihstatus('gps')
  commander._inis('eth')
  commander._inis('usb')
  commander._isig()
  commander._isatcur()
  commander._ihtemp()
  commander._ihbeam()
  commander.cimi()
  commander._ihread('imei')
  commander._ihip('unitip')
]

nExpectedResponses = commandQueue.length - 1

module.exports = (callback) ->
  
  commandBuffer = new buffering().on('flush', (data) ->
    socket.write data[0]
    commandBuffer.pause()
  )

  socket.on('finished', ->
    awk("#{responses.join('\n')}\n", (err, res) ->
      socket.emit('end')
      callback(err, res)
    )
  ).on('data', (data) ->
    
    if commandQueue.length
      commandBuffer.resume()
      commandBuffer.enqueue(commandQueue.splice(0, 1))
      commandBuffer.flush()

    sanitiser(data.toString(), (notApplicable, res) ->
      unless notApplicable
        responses = responses.concat(res)
      if responses.length is nExpectedResponses
        socket.emit('finished')
    )
  ).connect(BGAN_PORT, BGAN_HOST, ->
    console.log('ESTABLISHED CONNECTION', socket.address())
    commandBuffer.enqueue(commandQueue.splice(0, 1))
    commandBuffer.flush()
  )

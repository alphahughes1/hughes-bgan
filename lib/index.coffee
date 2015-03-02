
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

# prepare an array of AT commands to
# write on the socket (functions of 
# `commander` return strings)
commandQueue = [
  commander._iclck('ad', 0)
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
]

nExpectedResponses = commandQueue.length - 1

module.exports = (callback) ->
  
  # create a temporary workspace
  return fs.mkdir('tmp', (mkdirErr) ->

    # bail out if we can't
    return callback(mkdirErr, null) if mkdirErr

    # timestamp our diagnostic data
    fingerprint = "#{Date.now()}.dmp"

    # initialise a write stream
    dump = fs.createWriteStream("tmp/#{fingerprint}")

    # initialise our throttler and bind our
    # socket writing to the throttler flush event
    commandBuffer = new buffering().on('flush', (data) ->
      # console.log('invalid data?', data)
      socket.write data[0]
      commandBuffer.pause()
    )

    # this event is emitted from socket.on('data')
    # once all data has been received
    socket.on('finished', ->
      
      # invoke awk in a child process once
      # all socket data has been received
      awk(fingerprint, (awkErr, res) ->

        # close the writable stream once awk
        # has called back with the results
        dump.end( ->

          # delete files in our temporary workspace
          fs.unlink("tmp/#{fingerprint}", (rmFileErr) ->
            
            fs.rmdir('tmp', (rmDirErr) ->
              
              # clean up our socket context
              socket.emit('end')

              callback(
                rmFileErr ? rmDirErr ? awkErr,
                res
              )
            )
          )
        )
      )
    ).on('data', (data) ->
      
      # continue buffering commands 
      # for socket writing if any
      # remain...
      if commandQueue.length
        commandBuffer.resume()
        commandBuffer.enqueue(commandQueue.splice(0, 1))
        commandBuffer.flush()

      # pass any received data through the
      # sanitiser and write it to file if 
      # it's useful output (useless output
      # would be the 'OK' response or '\r\n')
      sanitiser(data.toString(), (notApplicable, res) ->
        unless notApplicable
          responses = responses.concat(res)
          dump.write("#{res.join('\n')}\n")
        
        if responses.length is nExpectedResponses
          socket.emit('finished')
      )
    ).connect(BGAN_PORT, BGAN_HOST, ->
      # buffer up the first command
      # to be written to the socket
      console.log('ESTABLISHED CONNECTION', socket.address())
      commandBuffer.enqueue(commandQueue.splice(0, 1))
      commandBuffer.flush()
    )
  )

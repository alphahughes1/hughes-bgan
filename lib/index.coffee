
{BGAN_HOST, BGAN_PORT, BGAN_PASSWORD} = require('./config')

buffering = require('node-buffering')
commander = require('./commander')
sanitise  = require('./sanitiser')
socket    = require('./socket')
awk       = require('./awk')
fs        = require('fs')

module.exports = (callback) ->

  # initialise our command list
  terminal = new commander(BGAN_PASSWORD)
  commandQueue = [
    terminal._iclck('ad', 0)
    terminal._ihstatus('flts')
    terminal._ihstatus('gps')
    terminal._inis('eth')
    terminal._inis('usb')
    terminal._isig()
    terminal._isatcur()
    terminal._ihtemp()
    terminal._ihbeam()
    terminal.cimi()
    terminal._ihread('imei')
  ]
  
  # subtract 1 because the first command has no output
  totalCommands = commandQueue.length - 1
  diagnostics = []

  # create a temporary workspace
  return fs.mkdir('tmp', (cant_mkdir) ->

    # bail out if we can't
    return callback(cant_mkdir, null) if cant_mkdir

    # timestamp our diagnostic data
    fingerprint = "#{Date.now()}.dmp"

    # initialise a write stream
    dump = fs.createWriteStream("tmp/#{fingerprint}")

    # initialise our throttler and bind our
    # socket.write()s to the buffer flush event
    commandBuffer = new buffering().on('flush', (data) ->
      socket.write data[0]
      commandBuffer.pause()
    )

    # this event is emitted from socket.on('data')
    # once all data has been received
    return socket.on('finished', ->
      
      # invoke awk in a child process once
      # all socket data has been received
      return awk(fingerprint, (cant_awk, res) ->

        # close the writable stream once awk
        # has called back with the results
        dump.end( ->

          # delete files in our temporary workspace
          return fs.unlink("tmp/#{fingerprint}", (cant_unlink) ->
            
            return fs.rmdir('tmp', (cant_rmdir) ->
              
              # clean up our socket context
              socket.emit('end')

              return callback(
                cant_unlink ? cant_rmdir ? cant_awk,
                res
              )
            )
          )
        )
      )
    ).on('data', (data) ->
      
      # pass any received data through the
      # sanitiser and write it to file if 
      # it's useful output (useless output
      # would be the 'OK' response or '\r\n')
      sanitise(data.toString(), (not_applicable, res) ->
        
        unless not_applicable

          # sometimes the socket outputs
          # results for two commands at
          # once. we have to use regex to
          # determine this and split each
          # result into its own line for
          # awk to parse it correctly
          if Array.isArray(res)
            diagnostics = diagnostics.concat(res)
            dump.write("#{res.join('\n')}\n")
          else
            diagnostics.push(res)
            dump.write(res) 

        # buffer up more commands to be
        # written to the socket
        if commandQueue.length
          commandBuffer.resume()
          commandBuffer.enqueue(commandQueue.splice(0, 1))
          commandBuffer.flush()
        
        # emit 'finished' if there are no
        # more commands to send and we've
        # received all data from the socket
        if diagnostics.length is totalCommands
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

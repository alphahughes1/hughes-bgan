
net = require('net')
socket = new net.Socket()

socket.setTimeout(30000)

socket.on('lookup', (err, address, family) ->
  console.error(err) if (err)
  console.log('SOCKET HOST ADDRESS LOOKUP')
  console.log('HOST ADDRESS', address)
  console.log('HOST FAMILY', family)
).on('timeout', ->
  console.error('CONNECTION TIMEOUT')
  socket.emit('finished')
).on('error', (err) ->
  console.error('CONNECTION ERROR', err)
  socket.unref()
  socket.destroy()
).on('end', ->
  console.log('CONNECTION CLOSED')
  socket.unref()
  socket.destroy()
)

module.exports = socket

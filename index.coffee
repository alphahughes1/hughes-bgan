
buffering = require('node-buffering')
commander = require('./lib/commander')
socket = require('./lib/socket')

socket.setTimeout(60000)

host = process.env.BGAN_HOST ? process.argv[2] ? '192.168.128.100'
port = process.env.BGAN_PORT ? process.argv[3] ? 1829
password = process.env.BGAN_PASSWORD ? process.argv[4] ? 'admin'

terminal = new commander(password)

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

results =
  imei: ''
  imsi: ''
  satellite:
    current: ''
    signal: ''
    beam: ''
    gps: 
      lat: ''
      lon: ''
      type: ''
      status: ''
      timestamp: ''
  faults: ''
  iface:
    eth: ''
    usb: ''

totalCommands = commandQueue.length

commandBuffer = new buffering().on('flush', (data) ->
  socket.write data[0]
  commandBuffer.pause()
)

isDeviceMetric = (chunk) ->
  return chunk.indexOf('_') > -1 or chunk.indexOf('+') > -1

stripOK = (chunk) ->
  return chunk.replace(/\r\nOK/g, '').replace(/OK\r\n/g, '')

stripCRLF = (chunk) ->
  return chunk.replace(/\r\n/g, '').trim()

decode = (chunk) ->
  chunks = chunk.split(':')

  if chunks.length > 1
    chunks = chunks.map((part) -> part.trim().toLowerCase())
    chunks = chunks[1..].join(':').split(',')
    return chunks

socket.on('data', (data) ->
  commandBuffer.resume()

  if isDeviceMetric data.toString()

    console.log(decode(stripCRLF(stripOK(data.toString()))))
    # console.log(stripCRLF(stripOK(data.toString())))

  if commandQueue.length
    commandBuffer.enqueue(commandQueue.splice(0, 1))
    commandBuffer.flush()
).connect(port, host, ->
  console.log('ESTABLISHED CONNECTION', socket.address())
  commandBuffer.enqueue(commandQueue.splice(0, 1))
  commandBuffer.flush()
)



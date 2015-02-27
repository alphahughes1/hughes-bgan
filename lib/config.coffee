
# configured in env?
{BGAN_HOST, BGAN_PORT, BGAN_PASSWORD} = process.env

# configured in argv?
BGAN_HOST = process.argv[2] ? BGAN_HOST
BGAN_PORT = process.argv[3] ? BGAN_PORT
BGAN_PASSWORD = process.argv[4] ? BGAN_PASSWORD

# no configuration
BGAN_HOST = BGAN_HOST ? '192.168.128.100'
BGAN_PORT = BGAN_PORT ? 1829
BGAN_PASSWORD = BGAN_PASSWORD ? 'admin'

module.exports =
  BGAN_HOST: BGAN_HOST
  BGAN_PORT: BGAN_PORT
  BGAN_PASSWORD: BGAN_PASSWORD

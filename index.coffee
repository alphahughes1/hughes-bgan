
# bootstrapping...

require('./lib') (err, res) ->
  if err
    console.error(err)
  else
    console.log(res)

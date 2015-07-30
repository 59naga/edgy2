# Dependencies
express= require 'express'
yahooJp= require 'yahoo-jp'

# Environment
PORT= process.env.PORT ? 59798

# Setup routes
app= express()

app.use (req,res,next)->
  res.setHeader 'Access-Control-Allow-Origin','*'
  res.setHeader 'Access-Control-Allow-Headers','X-Requested-With'
  res.setHeader 'Access-Control-Allow-Headers','Content-Type'
  res.setHeader 'Access-Control-Allow-Methods','PUT, GET, POST, DELETE, OPTIONS'
  next()

app.get '/',(req,res)->
  res.end 'powerd by https://github.com/59naga/node-yahoo-jp'

app.get '/:words',(req,res)->
  req.query.p= req.params.words

  # Move to query to options
  options= {}
  for option in ['limit','concurrency']
    options[option]= req.query[option]
    delete req.query[option]

  yahooJp.fetchAll req.query,options
  .then (items)->
    res.json items

# Boot
app.listen PORT
console.log 'listen to http://localhost:%s',PORT

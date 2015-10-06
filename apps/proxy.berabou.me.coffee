# Dependencies
express= require 'express'
bodyParser= require 'body-parser'
request= require 'request'

# Environment
process.env.PORT?= 59798

# Setup proxy-server for nicovideo
app= express()
app.use bodyParser.json()
app.get '/',->
  req.status(404).end 'no such host'

app.use (req,res)->
  request
    method: 'POST'
    uri: (req.url.slice 1)
    json: req.body
  .pipe res

app.listen process.env.PORT

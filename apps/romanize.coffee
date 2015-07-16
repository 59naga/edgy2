# Dependencies
express= require 'express'
romanizer= require 'romanizer'

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
  res.end 'powerd by https://github.com/59naga/romanizer'

app.set 'json spaces',2
app.get '/:words',(req,res)->
  romanizer.romanize req.params.words
  .then (romaji)->
    res.json romaji

# Setup tokenizer
app.listen PORT
console.log 'listen to http://localhost:%s',PORT

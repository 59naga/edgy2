# Dependencies
express= require 'express'
path= require 'path'

# Setup routes
app= express()

app.use (req,res,next)->
  res.setHeader 'Access-Control-Allow-Origin','*'
  res.setHeader 'Access-Control-Allow-Headers','X-Requested-With'
  res.setHeader 'Access-Control-Allow-Headers','Content-Type'
  res.setHeader 'Access-Control-Allow-Methods','PUT, GET, POST, DELETE, OPTIONS'
  next()

app.use express.static path.join process.cwd(),'antle'

# Boot
app.listen process.env.PORT

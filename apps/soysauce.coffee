# Dependencies
express= require 'express'
soysauce= require 'soysauce'

# Setup routes
app= express()

app.use '/u/',soysauce.middleware()

app.use '/u/',(req,res)->
  res.redirect 'https://github.com/59naga/soysauce'

# Boot
app.listen process.env.PORT

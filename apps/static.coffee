# Dependencies
express= require 'express'
cors= require 'cors'
path= require 'path'

# Setup routes
app= express()

app.use cors()

app.use express.static path.join process.cwd(),'static'

# Boot
app.listen process.env.PORT

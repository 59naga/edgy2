# Dependencies
express= require 'express'
path= require 'path'

VoiceText= require 'voicetext'

# Environment
process.env.PORT?= 59798
availableParameters= [
  'speaker'
  'emotion'
  'format'
  'emotion_level'
  'pitch'
  'speed'
  'volume'
]

# Setup routes
app= express()

app.use (req,res,next)->
  res.setHeader 'Access-Control-Allow-Origin','*'
  res.setHeader 'Access-Control-Allow-Headers','X-Requested-With'
  res.setHeader 'Access-Control-Allow-Headers','Content-Type'
  res.setHeader 'Access-Control-Allow-Methods','PUT, GET, POST, DELETE, OPTIONS'
  next()

app.get '/',(req,res)->
  res.end 'powerd by https://github.com/pchw/node-voicetext'

app.get '/:words',(req,res)->
  return res.status(414).end '生成可能なボイスは200文字までです。' if req.params.words.length > 200

  voiceText= new VoiceText process.env.VOICETEXTAPIKEY
  for parameter in availableParameters when parameter isnt 'format'
    voiceText= voiceText[parameter] req.query[parameter] if req.query[parameter]?

  voiceText.speak req.params.words,(error,buffer)->
    return res.status(500).send error.message if error

    res.send buffer

# Boot
app.listen process.env.PORT
console.log 'listen to http://localhost:%s',process.env.PORT

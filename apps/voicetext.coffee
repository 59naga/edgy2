# Dependencies
express= require 'express'
cors= require 'cors'
nipper= require 'nipper'
VoiceText= (require 'voice-text').VoiceText

# Environment
process.env.PORT?= 59798
schema =
  text:
    max: 200,
    default: 'hello'
  speaker:
    valid: ['hikari', 'haruka', 'takeru', 'santa', 'bear', 'show']
  format:
    valid: ['ogg', 'wav', 'aac']
  emotion:
    valid: ['happiness', 'anger', 'sadness']
  emotion_level:
    type: 'number'
    min: 1
    max: 4
  pitch:
    type: 'number'
    min: 50
    max: 200
  speed:
    type: 'number'
    min: 50
    max: 400
  volume:
    type: 'number'
    min: 50
    max: 200

# Setup routes
app= express()

app.use cors()
app.get '/',(req,res)->
  res.end 'powerd by https://github.com/59naga/voice-text'

app.get '/:words',(req,res)->
  voiceText= new VoiceText process.env.VOICETEXTAPIKEY

  res.set 'Last-Modified',(new Date).toGMTString()
  req.query.text= req.params.words # todo
  voiceText.stream req.params.words, (nipper.enforceObject req.query, schema)
  .pipe res

# Boot
app.listen process.env.PORT
console.log 'listen to http://localhost:%s',process.env.PORT

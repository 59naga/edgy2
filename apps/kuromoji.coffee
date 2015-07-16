# Dependencies
express= require 'express'
kuromoji= require 'kuromoji'

path= require 'path'

# Environment
PORT= process.env.PORT ? 59798
kuromojiRoot= path.dirname require.resolve 'kuromoji/package'
dicPath= (path.join kuromojiRoot,'dist','dict')+path.sep
kuromojiTokenizer= null

# Setup routes
app= express()

app.use (req,res,next)->
  res.setHeader 'Access-Control-Allow-Origin','*'
  res.setHeader 'Access-Control-Allow-Headers','X-Requested-With'
  res.setHeader 'Access-Control-Allow-Headers','Content-Type'
  res.setHeader 'Access-Control-Allow-Methods','PUT, GET, POST, DELETE, OPTIONS'
  next()

app.get '/',(req,res)->
  res.end 'powerd by https://github.com/takuyaa/kuromoji.js'

app.set 'json spaces',2
app.get '/:words',(req,res)->
  res.json kuromojiTokenizer.tokenize req.params.words

# Setup tokenizer
builder= kuromoji.builder {dicPath}
builder.build (error,tokenizer)->
  throw error if error

  kuromojiTokenizer= tokenizer
  
  app.listen PORT
  console.log 'listen to http://localhost:%s',PORT

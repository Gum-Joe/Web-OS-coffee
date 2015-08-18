express = require 'express'   
 path = require 'path'   
 favicon = require 'serve-favicon'   
 logger = require 'morgan'   
 cookieParser = require 'cookie-parser'   
 bodyParser = require 'body-parser'   
 clicolour = require 'cli-color'   
 fs = require "fs"   
 morgan = require "morgan"   

 passport = require 'passport'   
 passportlocal = require 'passport-local'   
 passporthttp = require 'passport-http'   

 mongoose = require 'mongoose'   
 MongoClient = require 'mongodb' .MongoClient  
 assert = require 'assert'   
 ObjectId = require 'mongodb' .ObjectID  

 connect = require "./libs/connect.js"   
 passportconfig = require "./libs/passport.js"   
 # wlogger = require "./libs/wlogger.js"   
 #  debuge = require "./libs/debug.js"   
 wlogger = require "./libs/logger"   

 routes = require './routes/index'   
 users = require './routes/users'   

 #debug = require 'debug'   'Web-OS:server'   
 http = require 'http'   
 https = require 'https'   

 app = express     

 bcrypt = require 'bcryptjs'   
 salt = bcrypt.genSaltSync  10    

 logFile = fs.createWriteStream('./logs/wos.log', {flags: 'a'})    

 # view engine setup
app.set('views', path.join(__dirname, 'views'));
app.set('view engine', 'jade');
app.set('view engine', 'ejs');

 # uncomment after placing your favicon in /public
 #app.use(favicon(path.join(__dirname, 'public', 'favicon.ico')));
app.use(logger('dev'));
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: false }));
app.use(cookieParser());
app.use(express.static(path.join(__dirname, 'public')));
app.use(express.static(path.join(__dirname, 'bower_components')));
app.use(express.static(path.join(__dirname, 'views')));
app.use(logger({stream: logFile}));
app.use(logger('stream', wlogger.logger));
#app.use(require('morgan')({ "stream": wlogger.stream }));
wlogger.debug("Overriding 'Express' logger");
app.use(require("morgan")("combined", { "stream": wlogger.stream }));
  

 userSchema = new mongoose.Schema ->
  username: { type: String }
, email: String
, pwd: String
   
 exits = false  
 suser = mongoose.model('usersc', userSchema)   

app.use('/', routes)   
app.use('/users', users)  
app.use('passportconfig', passportconfig)   

# Setup HTTPS
# uncommitted after finding way to get certs
# options = {
  #key: fs.readFileSync  path.join  __dirname, 'cert/Web-OS-PRIVATE.key'  
  # This certificate should be a bundle containing your server certificate and any intermediates
  # cat certs/cert.pem certs/chain.pem > certs/server-bundle.pem
#, cert: fs.readFileSync  path.join  __dirname, 'cert/Web-OS-SIGNED.crt'  
  # ca only needs to be specified for peer-certificates
#, ca: [ fs.readFileSync  path.join  caCertsPath, 'my-root-ca.crt.pem'   ]
#, requestCert: false
#, rejectUnauthorized: true
#}  



 port = process.env.PORT || 8080  

app.listen(port, () ->
	clicolour.cyanBright  "webOS "  + clicolour.yellowBright  "startup "  + "Running on port " + port   
	clicolour.cyanBright  "webOS "  + clicolour.yellowBright  "startup "  + "The date and time is:", Date      
  clicolour.cyanBright  "webOS "  + clicolour.yellowBright  "startup "  + connect.connect  "Connect"    
  
)    
# HTTPS
httpsserver = https.createServer  options   
# Turn on HTTPS
# httpsserver.on  'request', app   
   # httpsserver.listen  6060, function     {
     #  console.log  clicolour.cyanBright  "webOS "  + clicolour.yellowBright  "HTTPS "  + "HTTPS Server Started " + port   
    #    console.log  clicolour.cyanBright  "webOS "  + clicolour.yellowBright  "HTTPS "  + "The date and time is:", Date      
	#onListening   
    #}    



app.on('error', onError())   
app.on('listening', onListening())   

normalizePort = (val) ->
   port = parseInt(val, 10)   

  if isNaN(port)
    # named pipe
    return val  

  if port >= 0  
    # port number
    return port  

  return false  

#
 # Event listener for HTTP server "error" event.
 #

onError = (error) ->
  if error.syscall !== 'listen'
    throw error  
  

   bind = typeof port === 'string'
    ? 'Pipe ' + port
    : 'Port ' + port  

  # handle specific listen errors with friendly messages
  switch error.code  ->
    when 'EACCES' then
      console.error(bind + ' requires elevated privileges')   
      process.exit(1)   
      break  
    when 'EADDRINUSE' then
      console.error(bind + ' is already in use')   
      process.exit(1)   
      break  
    else
      throw error  


 # Event listener for HTTP server "listening" event.

onListening = () ->
   addr = httpsserver.address     
   bind = typeof addr === 'string'
    ? 'pipe ' + addr
    : 'port ' + addr.port  
  wlogger.debug('Listening on ' + bind)   



# catch 404 and forward to error handler
app.use((req, res, next) ->
   err = new Error  'Not Found'   
  err.status = 404  
  next  err   
)   

app.post('/login', (req, res)  ->
   # passportlocal.authenticate  'local'   
  res.redirect('/')  
)   

# error handlers

# development error handler
# will print stacktrace
if app.get('env'  === 'development')
  app.use((err, req, res, next) ->
    res.status(err.status || 500)   
    res.render('error.jade', {
      message: err.message,
      error: err
    })   
  )   


# production error handler
# no stacktraces leaked to user
app.use((err, req, res, next) ->
  res.status(err.status || 500)   
  res.render('error.jade', {
    message: err.message,
    error: {}
  })   
)   

var express = require('express');
var path = require('path');
var favicon = require('serve-favicon');
var logger = require('morgan');
var cookieParser = require('cookie-parser');
var bodyParser = require('body-parser');
var clicolour = require('cli-color');
var fs = require("fs");
var morgan = require("morgan");

var passport = require('passport');
var passportlocal = require('passport-local');
var passporthttp = require('passport-http');

var mongoose = require('mongoose');
var MongoClient = require('mongodb').MongoClient;
var assert = require('assert');
var ObjectId = require('mongodb').ObjectID;

var connect = require("./libs/connect.js");
var passportconfig = require("./libs/passport.js");
//var wlogger = require("./libs/wlogger.js");
// var debuge = require("./libs/debug.js");
var wlogger = require("./libs/logger");

var routes = require('./routes/index');
var users = require('./routes/users');

var debug = require('debug')('Web-OS:server');
var http = require('http');
var https = require('https');

var app = express();

var bcrypt = require('bcryptjs');
var salt = bcrypt.genSaltSync(10); 

var logFile = fs.createWriteStream('./logs/wos.log', {flags: 'a'});


// view engine setup
app.set('views', path.join(__dirname, 'views'));
app.set('views', path.join(__dirname, 'boot'));
app.set('view engine', 'jade');
app.set('view engine', 'ejs');

// uncomment after placing your favicon in /public
//app.use(favicon(path.join(__dirname, 'public', 'favicon.ico')));
app.use(logger('dev'));
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: false }));
app.use(cookieParser());
app.use(express.static(path.join(__dirname, 'public')));
app.use(express.static(path.join(__dirname, 'bower_components')));
app.use(express.static(path.join(__dirname, 'views')));
app.use(logger({stream: logFile}));
app.use(logger('stream', wlogger.logger));
//app.use(require('morgan')({ "stream": wlogger.stream }));
wlogger.debug("Overriding 'Express' logger");
app.use(require("morgan")("combined", { "stream": wlogger.stream }));

var userSchema = new mongoose.Schema({
  username: { type: String }
, email: String
, pwd: String
});
var exits = false;
var suser = mongoose.model('usersc', userSchema);

app.use('/', routes);
app.use('/users', users);
app.use('passportconfig', passportconfig);

// Setup HTTPS
options = {
  key: fs.readFileSync(path.join(__dirname, 'cert/Web-OS-PRIVATE.key'))
  // This certificate should be a bundle containing your server certificate and any intermediates
  // cat certs/cert.pem certs/chain.pem > certs/server-bundle.pem
, cert: fs.readFileSync(path.join(__dirname, 'cert/Web-OS-SIGNED.crt'))
  // ca only needs to be specified for peer-certificates
//, ca: [ fs.readFileSync(path.join(caCertsPath, 'my-root-ca.crt.pem')) ]
, requestCert: false
, rejectUnauthorized: true
};



var port = process.env.PORT || 8080;

app.listen(port, function () {
	console.log(clicolour.cyanBright("webOS ") + clicolour.yellowBright("startup ") + "Running on port " + port);
	console.log(clicolour.cyanBright("webOS ") + clicolour.yellowBright("startup ") + "The date and time is:", Date());
  console.log(clicolour.cyanBright("webOS ") + clicolour.yellowBright("startup ") + connect.connect("Connect"));
  
} );
// HTTPS
httpsserver = https.createServer(options);
// Turn on HTTPS
httpsserver.on('request', app);
    httpsserver.listen(6060, function () {
       console.log(clicolour.cyanBright("webOS ") + clicolour.yellowBright("HTTPS ") + "HTTPS Server Started " + port);
        console.log(clicolour.cyanBright("webOS ") + clicolour.yellowBright("HTTPS ") + "The date and time is:", Date());
	onListening()
    });



app.on('error', onError);
app.on('listening', onListening);

function normalizePort(val) {
  var port = parseInt(val, 10);

  if (isNaN(port)) {
    // named pipe
    return val;
  }

  if (port >= 0) {
    // port number
    return port;
  }

  return false;
}

/**
 * Event listener for HTTP server "error" event.
 */

function onError(error) {
  if (error.syscall !== 'listen') {
    throw error;
  }

  var bind = typeof port === 'string'
    ? 'Pipe ' + port
    : 'Port ' + port;

  // handle specific listen errors with friendly messages
  switch (error.code) {
    case 'EACCES':
      console.error(bind + ' requires elevated privileges');
      process.exit(1);
      break;
    case 'EADDRINUSE':
      console.error(bind + ' is already in use');
      process.exit(1);
      break;
    default:
      throw error;
  }
}

/**
 * Event listener for HTTP server "listening" event.
 */

function onListening() {
  var addr = httpsserver.address();
  var bind = typeof addr === 'string'
    ? 'pipe ' + addr
    : 'port ' + addr.port;
  wlogger.debug('Listening on ' + bind);
}


// catch 404 and forward to error handler
app.use(function(req, res, next) {
  var err = new Error('Not Found');
  err.status = 404;
  next(err);
});

app.post('/login', function(req, res) {
   // passportlocal.authenticate('local');
  res.redirect('/');
});

// error handlers

// development error handler
// will print stacktrace
if (app.get('env') === 'development') {
  app.use(function(err, req, res, next) {
    res.status(err.status || 500);
    res.render('error.jade', {
      message: err.message,
      error: err
    });
  });
}

// production error handler
// no stacktraces leaked to user
app.use(function(err, req, res, next) {
  res.status(err.status || 500);
  res.render('error.jade', {
    message: err.message,
    error: {}
  });
});

var express = require('express');
var path = require('path');
var bodyParser = require('body-parser');
var path = require('path');
var cookieParser = require('cookie-parser');

// passport for login
var passport = require('passport');
var passportlocal = require('passport-local');
var passporthttp = require('passport-http');
var passportlocalmongoose = require('passport-local-mongoose');

// var routes = require('../routes/index');
// var users = require('../routes/users');

var mongoose = require('mongoose');
var MongoClient = require('mongodb').MongoClient;
var assert = require('assert');
var ObjectId = require('mongodb').ObjectID;
var clicolour = require('cli-color');
var expressSession = require('express-session');
var bcrypt = require('bcryptjs');

var salt = bcrypt.genSaltSync(10); 

var app = express();



/*var userSchema = new mongoose.Schema({
  username: { type: String }
, email: String
, pwd: String
});
var exits = false;
var suser = mongoose.model('user', userSchema);
var Suser = mongoose.model('user', userSchema);*/

app.use(cookieParser('$%£lWeBOS66$%£22'));
app.use(expressSession({ 
    secret: process.env.SESSION_SECRET || '$%£lWeBOS66$%£22',
    resave: true,
    saveUninitialized: true
    }));

app.use(express.static(path.join(__dirname, 'bower_components')));
app.use(express.static(path.join(__dirname, 'views')));
app.use(express.static(path.join(__dirname, 'public')));

//passport
app.use(passport.initialize());
app.use(passport.session());
// passport config
// awaiting solve
var isValidPassword = function(user, password){
    return bcrypt.compareSync(password, user.password);
    }

passport.use(new passportlocal.Strategy(function (username, password, done) {
    passReqToCallback : true;
  },
  function(req, username, password, done) { 
    // check in mongo if a user with username exists or not
    suser.findOne({ 'username' :  username }, 
      function(err, user) {
        // In case of any error, return using the done method
        if (err){
            return done(err);
            console.log(clicolour.cyanBright("connections ") + clicolour.redBright("error ") + 'User Not Found with username '+ username);
            }
        // Username does not exist, log error & redirect back
        if (!user){
          console.log(clicolour.cyanBright("connections ") + clicolour.redBright("error ") + 'User Not Found with username '+ username);
          return done(null, false, 
                req.flash('message', 'User Not found.'));                 
        }
        // User exists but wrong password, log the error 
        if (!isValidPassword(user, password)){
          console.log(clicolour.cyanBright("connections ") + clicolour.redBright("error ") + 'Invalid Password');
          return done(null, false, 
              req.flash('message', 'Invalid Password'));
        }
        // User and password both match, return user from 
        // done method which will be treated like success
        return done(null, {id: user, name: username, email: username});
      }
    );
})); 

// passport.use(new passportlocal.Strategy(suser.authenticate()));


var userSchema = new mongoose.Schema({
  username: { type: String }
, email: String
, pwd: String
});

userSchema.plugin(passportlocalmongoose);
var suser = mongoose.model('userspassport', userSchema);

passport.serializeUser(function(user, done) {
    done(null, user.id);
});

passport.deserializeUser(function(id, done) {
    suser.findById(id, function(err, user) {
        done(err, user);
    });
});

// passport.serializeUser(suser.serializeUser());

// passport.deserializeUser(suser.deserializeUser());


module.exports = app;
module.exports = mongoose.model('userspassportreal', userSchema);;

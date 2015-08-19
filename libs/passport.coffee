express = require 'express'
path = require 'path'
bodyParser = require 'body-parser'
path = require 'path'
cookieParser = require 'cookie-parser'

# passport for login
passport = require 'passport'
passportlocal = require 'passport-local'
passporthttp = require 'passport-http'
passportlocalmongoose = require 'passport-local-mongoose'

# routes = require('../routes/index')
# users = require('../routes/users')

mongoose = require 'mongoose'
#MongoClient = require('mongodb').MongoClient
assert = require 'assert'
#ObjectId = require('mongodb').ObjectID
clicolour = require 'cli-color'
expressSession = require 'express-session'
bcrypt = require 'bcryptjs'

salt = bcrypt.genSaltSync(10) 
 
app = express()



userSchema = new mongoose.Schema({
  username: { type: String }
, email: String
, pwd: String
})
exits = false
suser = mongoose.model('user', userSchema)
Suser = mongoose.model('user', userSchema)

app.use(cookieParser('lWeBOS6622'))
app.use(expressSession({ 
    secret: process.env.SESSION_SECRET || '$%£lWeBOS66$%£22',
    resave: false,
    saveUninitialized: false
    }))

app.use(express.static(path.join(__dirname, 'bower_components')))
app.use(express.static(path.join(__dirname, 'views')))
app.use(express.static(path.join(__dirname, 'public')))

#passport
app.use(passport.initialize())
app.use(passport.session())
# passport config
# awaiting solve
isValidPassword = (user, password) ->
  return bcrypt.compareSync(password, user.password)

passport.use(new passportlocal.Strategy(
  (username, password, done) ->
    passReqToCallback : true
  ,(req, username, password, done) -> 
    # check in mongo if a user with username exists or not
    suser.findOne({ 'username' :  username }, 
    (err, user) ->
      # In case of any error, return using the done method
      if err
        return done(err)
        console.log(clicolour.cyanBright("connections ") + clicolour.redBright("error ") + 'User Not Found with username '+ username)
      # Username does not exist, log error & redirect back
      if !user
          console.log(clicolour.cyanBright("connections ") + clicolour.redBright("error ") + 'User Not Found with username '+ username)
          return done(null, false, 
            req.flash('message', 'User Not found.'))                 
       # User exists but wrong password, log the error 
       if !isValidPassword(user, password)
         console.log(clicolour.cyanBright("connections ") + clicolour.redBright("error ") + 'Invalid Password')
         return done(null, false, 
           req.flash('message', 'Invalid Password'))
        
        # User and password both match, return user from 
        # done method which will be treated like success
        return done(null, {id: user, name: username, email: username})
          
)))

# passport.use(new passportlocal.Strategy(suser.authenticate()))


userSchema = new mongoose.Schema({
  username: { type: String }
, email: String
, pwd: String
})

userSchema.plugin(passportlocalmongoose)
suser = mongoose.model('userspassport', userSchema)

passport.serializeUser((user, done) ->
    done(null, user.id)
)

passport.deserializeUser((id, done) ->
    suser.findById(id, (err, user) ->
        done(err, user)
))

# passport.serializeUser(suser.serializeUser())

# passport.deserializeUser(suser.deserializeUser())


module.exports = app
module.exports = mongoose.model('userspassportreal', userSchema)

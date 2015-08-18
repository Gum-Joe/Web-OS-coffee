express = require('express')
path = require('path')
bodyParser = require('body-parser')
path = require('path')
favicon = require('serve-favicon')
logger = require('morgan')
cookieParser = require('cookie-parser')

# passport for login
passport = require('passport')
passportlocal = require('passport-local')
passporthttp = require('passport-http')

routes = require('../routes/index')
users = require('../routes/users')

mongoose = require('mongoose')
MongoClient = require('mongodb').MongoClient
assert = require('assert')
ObjectId = require('mongodb').ObjectID
clicolour = require('cli-color')
# awaiting solve
# bcrypt = require('bcrypt')

# connect
exports.stadaradconnect = (x) ->
  url = 'mongodb://localhost:27017/web-os'
  MongoClient.connect(url, (err, db) ->
    assert.equal(null, err)
    console.log(clicolour.cyanBright("webOS ") + clicolour.magentaBright("database ") + "Connected correctly to mongo server.")
    db.close()
)

exports.connect = () ->
  mongoose.connect('mongodb://localhost:27017/connections')
  db = mongoose.connection
  db.on('error', console.error.bind(console, 'connection error:'))
  db.once('open', (callback) ->
    # yay!
    console.log(clicolour.cyanBright("webOS ") + clicolour.magentaBright("database ") + "Yay! We succefully connected to the db"))











express = require 'express'
router = express.Router()
passportconfig = require "../libs/passport.js"
passport = require "passport"
passportLocal = require "passport-local"

#MongoClient = require 'mongodb').MongoClient
#cursor = require('mongodb')
assert = require 'assert'
#ObjectId = require('mongodb').ObjectID

mongoose = require('mongoose')

dbName = "web-os"
port = "27017"
host = "localhost"

userSchema = new mongoose.Schema({
  username: { type: String }
, email: String
, pwd: String
})

exits = false
Suser = mongoose.model('usersch', userSchema)
#counts = getdocs("ok")

getdocs = (x) ->
  Suser.count({}, (err, count) ->
    return count
    counts = count
)

#console.log(getdocs("ok"))

router.use('passportconfig', passportconfig)

# GET home page.
router.get('/', (req, res, next) ->
  res.render('index.html', { title: 'Sign in' })
)

router.get('/admin', (req, res, next) ->
  res.render('admin/index.ejs', {
    # url query (?x=y)
    user: req.param("user"),
    #users: Suser.count({}, function(err, count){
    #return count
    users: 1000,
    sessions: 500,
    plugins: 5
  })

)

router.post('/login', (req, res, next) ->
  #passport.authenticate('local')
  res.render('index.html', { title: 'Done' })
)

module.exports = router

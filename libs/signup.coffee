express = require 'express'
path = require 'path'
bodyParser = require 'body-parser'
path = require 'path'
favicon = require 'serve-favicon'
logger = require 'morgan'
cookieParser = require 'cookie-parser'

# passport for login
passport = require 'passport'
passportlocal = require 'passport-local'
passporthttp = require 'passport-http'

routes = require '../routes/index'
users = require '../routes/users'

mongoose = require 'mongoose'
MongoClient = require('mongodb').MongoClient
assert = require 'assert'
ObjectId = require('mongodb').ObjectID
# awaiting solve
bcrypt = require 'bcrypt'

connect = require "../libs/connect.js"

exports.signup = (username, email, pwd, salt) ->
  connect.connect("ok")

# connect
#hash the password
  susername = username
  semail = email
  #pass = req.body.pass

  bcrypt.genSalt(10, (err, salt) ->
    bcrypt.hash('pwd', salt, (err, hash) ->
      signupuser = new user({
        username: susername
      , email: semail
      , pwd: hash
      })
      signupuser.save((err, signupuser) ->
        if err
          return console.error("Errors storing DATA: " + err )
        else 
          console.log("Done")
          res.render('signin.ejs') 
        )
# Store hash in your password DB.
     
   )
)

#
 #user.findOne({ username: susername }, (err, signupuser) {
  #if (!err){
  #    console.log("User tried to signup taken username")
  #    exits = true
 #     res.render("signupREAL.ejs")
#  }
#})
#

    # later
    #/ bcrypt.genSalt(10, (err, salt) {
    # for later pass = bcrypt.hash(res.body.pass, salt, (err, hash) {
        # Store hash in your password DB. 
    # })
    # })
    # db.collection('users').insertOne({ "username": susername, "email": semail, "password": pass })

console.log("Sign Up succesful")
console.log("Storing...")
    
#}

    










var express = require('express');
var router = express.Router();
var passportconfig = require("../libs/passport.js");
var passport = require("passport");
var passportLocal = require("passport-local");

var MongoClient = require('mongodb').MongoClient;
var cursor = require('mongodb');
var assert = require('assert');
var ObjectId = require('mongodb').ObjectID;

var mongoose = require('mongoose');

var dbName = "web-os";
var port = "27017";
var host = "localhost";

var userSchema = new mongoose.Schema({
  username: { type: String }
, email: String
, pwd: String
});
var exits = false;
var Suser = mongoose.model('usersch', userSchema);
var counts = getdocs("ok");

function getdocs(x){
  Suser.count({}, function(err, count){
    return count;
    counts = count;
});

};

console.log(counts);

router.use('passportconfig', passportconfig);

/* GET home page. */
router.get('/', function(req, res, next) {
  res.render('index.html', { title: 'Sign in' });
});

router.get('/admin', function(req, res, next) {
  res.render('admin/index.ejs', {
    // url query (?x=y)
    user: req.param("user"),
    //users: Suser.count({}, function(err, count){
    //return count;
///})
    users: 1000,
    sessions: 500,
    plugins: 5
  });

  });

router.post('/login', function(req, res, next) {
    //passport.authenticate('local');
  // res.render('index.html', { title: 'Done' });
});

module.exports = router;

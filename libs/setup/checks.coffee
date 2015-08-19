instances = require './instances/index.js'
fs = require 'fs'
path = require 'path'
clicolour = require 'cli-color'

exports.checkInstances = (x) ->
  fs.stat('instances', (err, stat) ->
      if err == null 
          console.log('File exists');
      else if err.code == 'ENOENT'
        instances.instancescreateInstancesDir("ok")
      else 
        clicolour.yellowBright("Web-OS ran into a problem,",
          "To protect your data, we have shut down Web-OS",
          "                             ",
          "This error code may help:",
          "SETUP_DIR_INSTANCES_OTHER_" + err.code,
          "              ",
          "Here's the full error:",
          + err.code + err))

mkdirp = require 'mkdirp'
clicolour = require 'cli-color'
#errors = require '../error.js'

exports.createInstancesDir = (x) ->
    
  mkdirp('instances', (err) ->
    if err 
      errors.bsod.throwError("SETUP_CREATE_DIR_INSTANCES", err, err.code)
    else 
      console.log(clicolour.cyanBright("webOS ")  + clicolour.yellowBright("setup ")  + "Create Instances Dir")
)
      
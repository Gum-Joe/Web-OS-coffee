fs = require 'fs'

option '-o', '--output compiled', 'directory for compiled code'

task 'build:app.js', 'Build app.js', (options) ->
  #require 'jison'
  code = require('./app.coffee').parser.generate()
  dir  = options.output or 'compiled'
  fs.writeFile "#{dir}/app.js", code

task 'build:connect', "Build the connect module', (options) ->
  code = require(./libs/connect.coffee).parser.generate()
  dir = options.output or 'compiled/libs'
  fs.writeFile "#{dir}/libs/connect.js", code

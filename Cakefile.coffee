fs = require 'fs'

option '-o', '--output compiled', 'directory for compiled code'

task 'build:app.js', 'Build app.js', (options) ->
  //require 'jison'
  code = require('./app.coffee').parser.generate()
  dir  = options.output or 'compiled'
  fs.writeFile "#{dir}/app.js", code

fs = require 'fs'

{print} = require 'sys'
{spawn} = require 'child_process'

#Define builds
build = (callback) ->
  coffee = spawn 'coffee', ['-o', 'compiled', '-c', 'app.coffee']
  coffee.stderr.on 'data', (data) ->
    process.stderr.write data.toString()
  coffee.stdout.on 'data', (data) ->
    print data.toString()
  coffee.on 'exit', (code) ->
    callback?() if code is 0

build-libs = (callback) ->
  libs = spawn 'coffee', ['-o', 'compiled/libs', '-c', 'libs/connect.coffee', 'libs/logger.coffee', 'libs/passport.coffee']
  libs.stderr.on 'data', (data) ->
    process.stderr.write data.toString()
  libs.stdout.on 'data', (data) ->
    print data.toString()
  libs.on 'exit', (code) ->
    callback?() if code is 0

build-routes = (callback) ->
  routes = spawn 'coffee', ['-o', 'compiled/routes', '-c', 'routes/index.coffee']
  routes.stderr.on 'data', (data) ->
    process.stderr.write data.toString()
  routes.stdout.on 'data', (data) ->
    print data.toString()
  routes.on 'exit', (code) ->
    callback?() if code is 0

task 'build', 'Build all and place in ./compiled/', ->
  build(() ->
    "Succesfully compiled" + libs[5]
)
  build-libs(() ->
    "Succesfully compiled" + libs[5]
)
  build-routes(() ->
    "Succesfully compiled" + libs[5]
)

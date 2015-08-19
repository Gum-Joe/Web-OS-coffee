#The error script
clicolour = require 'cli-color'
#red = clicolour.redBright()

red = (text) ->
  console.error(clicolour.redBright(text))

yell = (text) ->
  console.error(clicolour.yellowBright(text))

blue = (text) ->
  console.error(clicolour.blueBright(text))

space = "                                                                 "

exports.throwError = (code, err, ercode) ->
  console.log("                                   ")
  blue(space+"             -- BEGIN ERROR --")
  red(space+"          Web-OS ran into a problem")
  yell(space+"To protect your data, we have shut down Web-OS")
  yell(space+"                          ")
  yell(space+"        This error code may help:")
  yell(space+"                    "+code)
  yell(space+"     ")
  yell(space+"          Here's the full error:")
  red(space+"        "+ercode + " - Web-OS error " + code)
  yell(space+"       "+err)
  blue(space+"             -- END OF ERROR --")
  console.log("                                   ")
  process.exit(1)
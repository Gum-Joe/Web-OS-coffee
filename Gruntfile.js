var cli = require("cli-color");
var sys = require('sys');
var execute = require('child_process').exec;
/*function exec(command){
  execute(command, function (error, stdout, stderr) {
  console.log(stdout);
  console.log(stderr);
  if (error !== null) {
    console.log('exec error: ' + error);
  }
});
};*/




module.exports = function(grunt) {

  // A very basic default task.
  grunt.registerTask('default', 'Log some stuff.', function() {
    grunt.log.write('Compileing apps...').ok();
    grunt.log.write(cli.cyanBright('Step 1...')).ok();
    grunt.util.spawn({
  cmd: ['echo'],
  args: ['t'],
}, function done() {
  grunt.log.ok('/tmp deleted');
});
  });

};

// Mocha test for generating
var exec = require('child_process').exec;
var cmd = 'gem';

     describe("Test ruby generating", function() {
          describe("Install gems", function() {
              it("Install rails and bundle", function(done){
                exec(cmd, function(error, stdout, stderr) {
                     // command output is in stdout
                     console.log(stdout);
                     console.log(stderr);
                     if(stderr){
                       throw err;
                       };
                    done()
                });
          });
     });
  });


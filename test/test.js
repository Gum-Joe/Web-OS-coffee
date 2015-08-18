describe('testing', function () {
it('First test', function(done) {
   process.env.TRAVIS_JOB_ID = -1;
    process.env.COVERALLS_GIT_COMMIT = "GIT_HASH";
    process.env.COVERALLS_GIT_BRANCH = "master";
    process.env.COVERALLS_SERVICE_NAME = "SERVICE_NAME";
    process.env.COVERALLS_SERVICE_JOB_ID = "SERVICE_JOB_ID";
    process.env.COVERALLS_REPO_TOKEN = "REPO_TOKEN";
   console.log("Pending...");
  done();
  });
});

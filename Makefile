# here is the makefile
tests:
	echo Runing tests; \
	echo Installing modules; \
	npm install; \
	npm install --dev; \
	npm install -g bower; \
	bower install; \
	echo Testing...; \
	echo Installing nyc...; \
	npm install -g nyc; \
	echo Testing....
	npm test; \
	echo ; \
	echo Done; \
	echo Now testing C#; \
	cd app && make run; \
	echo Done; \

install:
	echo Installing Modules; \
	npm install; \
	npm install bower; \        
	node node_modules/bower/bin/bower install; \
	echo Done;

test-coveralls:
	@NODE_ENV=test Web-OS_COVERAGE=1 ./node_modules/.bin/istanbul cover \
	./node_modules/mocha/bin/_mocha --report lcovonly -- -R spec && \
		cat ./coverage/lcov.info | ./node_modules/coveralls/bin/coveralls.js --verbose


ci:
	echo Installing Coffeescript
	npm install -g coffee-script
	echo compiling
	coffee -o compiled -c  app.coffee
	coffee -o compiled/libs -c libs/*.coffee
	coffee -o compiled/routes -c routes/*.coffee

pi:
	echo compiling
	coffee -o compiled -c  app.coffee
	coffee -o compiled/libs -c libs/*.coffee
	coffee -o compiled/routes -c routes/*.coffee
#.PHONY test

#.PHONY test

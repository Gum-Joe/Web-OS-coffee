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
	coffee -o ./ -c app.coffee
	coffee -o libs/setup libs/setup/instances/*.coffee
	coffee -o libs/setup libs/setup/*.coffee
	coffee -o libs/error libs/error/*.coffee
	coffee -o libs libs/*.coffee
	coffee -o routes routes/*.coffee
	#cake build


pi:
	echo compiling
	$(MAKE) clean
	coffee -o ./ -c app.coffee
	coffee -o libs/setup libs/setup/instances/*.coffee
	coffee -o libs/setup libs/setup/*.coffee
	coffee -o libs/error libs/error/*.coffee
	coffee -o libs libs/*.coffee
	coffee -o routes routes/*.coffee
	#cake build
	#Compile css
	
	

libs-in:
	coffee -w -o libs -c libs/*.coffee

set-in:
	coffee -w -o libs/setup -c libs/setup/*.coffee

set-ins-in:
	coffee -w -o libs/setup/instances -c libs/setup/instances/*.coffee

err-in:
	coffee -w -o libs/error -c libs/error/*.coffee

app-in:
	echo compiling
	coffee -w -o ./ -c  app.coffee

routes-in:
	echo compiling
	coffee -w -o routes -c routes/*.coffee

clean:
	rm -rfv libs/*.js routes/*.js app.js

#.PHONY test

#.PHONY test

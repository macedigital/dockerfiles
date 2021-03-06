# Node.js on CentOS

[![](https://images.microbadger.com/badges/image/macedigital/nodejs.svg)](https://microbadger.com/images/macedigital/nodejs "Get your own image badge on microbadger.com")
[![](https://img.shields.io/docker/automated/macedigital/nodejs.svg)](https://hub.docker.com/r/macedigital/nodejs/ "Docker Hub page")

Base image for nodejs-based apps in a CentOS:7 container.

## Usage

If you just want to play around with the node.js [REPL](https://en.wikipedia.org/wiki/REPL), create a new throw-away container:

````
docker run --rm -ti macedigital/nodejs
````

For testing in a CI environment you add just a few more options.

````
docker run --rm -e NODE_ENV=development -v /path/to/your/code:/path/inside/container -w /path/inside/container -ti macedigital/nodejs npm test
````

Above example assumes `/path/to/your/code` is the location of your project root on the host, `/path/inside/container` is your desired working directory inside the container, and you have a working `test` script in the `package.json` file. Remember to make liberal use of the npm scripts section, where you can also define `pretest` and `posttest` handlers (e.g. fresh install of dependencies, tear down after tests are run). 

The container will be discarded after it finished running so make sure build & coverage data is written to somewhere inside `/path/to/your/code` (on the host).

## Rebuild

At the moment, the following build arguments are supported:

`NODE_VERSION`: Specify which version to use (defaults to '6.5.0').

`NODE_ENV`: Set environment (defaults to 'production').

`NODE_HOME`: Working directory and path for exported volume (defaults to '/srv').

`NODE_USER`: Effective use when running a container (defaults to 'nobody').

`NPM_LOGLEVEL`: Verbosity of npm commands (defaults to 'warn').

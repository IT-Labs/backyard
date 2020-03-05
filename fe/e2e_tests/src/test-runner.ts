import * as yargs from "yargs";
import * as execa from "execa";
import * as waitOn from "wait-on";
import * as Promise from "bluebird";
import * as psTree from "ps-tree";
import * as fs from "fs";
import * as path from "path";
import { runTests } from "./cucumber-runner";

const argv = yargs
  .env("itlabs")
  .option("webUrl", {
    alias: "url",
    describe: "Web URL against which the tests will be run",
    type: "string",
    default: "localhost:3000"
  })
  .option("apiUrl", {
    alias: "url_api",
    describe: "Api URL against which swagger test will be run",
    type: "string",
    default: "localhost:5000"
  })  
  .option("smoke", {
    describe: "Should we run smoke tests only?",
    default: false,
    type: "boolean"
  })
  .option("tags", {
    describe: "Option to run only specified tagged test(s)",
    default: "",
    type: "string"
  })
  .option("feature", {
    describe:
      "Runs only the specified feature file. By default the runner will attempt to run all feature files. More info at: https://github.com/cucumber/cucumber-js/blob/master/docs/cli.md#running-specific-features",
    default: ""
  })
  .option("headless", {
    describe: "Run chrome in headless mode"
  })
  .option("verbose", {
    alias: "v",
    describe: "Output lots of debug messages",
    type: "boolean",
    default: false
  })
  .option("browserstack", {
    describe: "Use browserstack selenium grid",
    type: "boolean",
    default: false
  })
  .option("saucelabs", {
    describe: "Use saucelabs selenium grid",
    type: "boolean",
    default: false
  })
  .option("parallel", {
    describe: "Running tests in parallel. Specify how many workers to run.",
    type: "number"
  })
  .option("startSeleniumServer", {
    describe:
      "Starts Selenium Standalone server and uses that for driving tests. Otherwise expects running server defined using `seleniumHost` and `seleniumPort` options",
    type: "boolean",
    default: true
  })
  .option("seleniumHost", {
    describe: "Define IP address where selenium hub is running",
    default: "localhost"
  })
  .option("seleniumPort", {
    describe: "Define port on which the selenium hub is running",
    type: "number",
    default: "4444"
  }).argv;

process.env.test_environment = argv.environment;
process.env.test_runner_url = argv.webUrl;
process.env.test_runner_url_api = argv.apiUrl;
process.env.test_cucumber_parallel = argv.parallel;
process.env.test_nw_environment = argv.browserstack
  ? "browserstack"
  : argv.saucelabs
  ? "saucelabs"
  : "default";
const startServer =
  (argv.browserstack || argv.saucelabs) === false && argv.startSeleniumServer;

if (argv.verbose) {
  process.env.test_VERBOSE = "1";
  process.env.DEBUG = "*";
}

import { getNightwatchConfiguration } from "./nightwatch-conf";

let nwConfig = null;
nwConfig = getNightwatchConfiguration(argv.seleniumHost, argv.seleniumPort);
fs.writeFileSync(
  path.join(__dirname, "../nightwatch.json"),
  JSON.stringify(nwConfig, null, 2)
);

const isDebug = () =>
  process.env.DEBUG &&
  process.env.DEBUG.indexOf("start-server-and-test") !== -1;

const isInsecure = () => process.env.START_SERVER_AND_TEST_INSECURE;

function startAndTest({ start, url }) {
  const server = execa("npm", ["run", start], { stdio: "inherit" });
  let serverStopped = false;

  function stopServer() {
    if (!serverStopped) {
      serverStopped = true;
      return Promise.fromNode(cb => psTree(server.pid, cb))
        .then(children => {
          children.forEach(child => {
            process.kill(child.PID, "SIGKILL");
          });
        })
        .then(() => {
          server.kill();
        });
    }
  }

  const waited = new Promise((resolve, reject) => {
    waitOn(
      {
        resources: Array.isArray(url) ? url : [url],
        verbose: isDebug(),
        strictSSL: !isInsecure(),
        log: true
      },
      err => {
        if (err) {
          return reject(err);
        }
        resolve();
      }
    );
  });

  return waited
    .tapCatch(stopServer)
    .then(() => runTests(argv.feature, argv.tags, argv.parallel))
    .finally(stopServer);
}

if (!startServer) {
  runTests(argv.feature, argv.tags, argv.parallel);
} else {
  startAndTest({
    start: "selenium:local-standalone",
    url: "http-get://localhost:4444/status"
  }).catch(e => {
    console.error(e);
    process.exit(1);
  });
}

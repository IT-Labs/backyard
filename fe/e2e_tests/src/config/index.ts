import * as path from "path";
var mkdirp = require("mkdirp");

var environment = process.env.NODE_ENV || "development";

mkdirp("reports", function(err) {
  if (err) console.error(err);
});

console.info(`starting e2e tests for env on '${environment}'`);

process.env.NODE_ENV = environment;
process.env.NODE_CONFIG_DIR = path.join(__dirname);

import * as config from "config";
import rootDefaultConfig from "./default";
console.info("root config", rootDefaultConfig);
import { IAppConfig } from "./config-interface";
import { configSchema, schemaValidator } from "./config-schema";

// get all config for current customer|environment
var appConfig: IAppConfig = Object.assign(
  {},
  rootDefaultConfig,
  JSON.parse(JSON.stringify(config))
);

console.info("app config", appConfig);

appConfig.url = process.env.test_runner_url || appConfig.url;
appConfig.url_api = process.env.test_runner_url_api || appConfig.url_api;
// validate using json schema validator
const validationResult = schemaValidator.validate(appConfig, configSchema);
if (!validationResult.valid) {
  console.error(validationResult);
  throw new Error(validationResult.toString());
}

export { appConfig };

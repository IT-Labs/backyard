const chromedriver = require("chromedriver");
const seleniumServer = require("selenium-server");
import { appConfig } from "./config/index";

const silent = !!process.env.test_VERBOSE ? false : true;

export function getNightwatchConfiguration(
  seleniumHost: string = "localhost",
  seleniumPort: number = 4444
) {
  return {
    selenium: {
      start_process: false,
      server_path: seleniumServer.path,
      log_path: __dirname,
      port: seleniumPort,
      cli_args: {
        "webdriver.chrome.driver": chromedriver.path
      }
    },

    test_workers: {
      enabled: true,
      workers: "auto"
    },

    test_settings: {
      default: {
        launch_url: appConfig.url,
        selenium_port: seleniumPort,
        selenium_host: seleniumHost,
        silent: silent,
        screenshots: {
          enabled: false,
          on_failure: true,
          on_error: true,
          path: "reports"
        },
        desiredCapabilities: {
          browserName: "chrome",
          acceptSslCerts: true,
          javascriptEnabled: true
        }
      },
      saucelabs: {
        selenium_host: "ondemand.saucelabs.com",
        username: appConfig.saucelabs.username,
        access_key: appConfig.saucelabs.accessKey,
        desiredCapabilities: {
          name: "Nightwatch Skeleton - osx-chrome",
          platform: "macOS 10.12",
          browserName: "chrome",
          version: "61"
        },
        globals: {
          propertyData: {
            environment: "os_x_10_12-chrome61"
          }
        },
        selenium: {
          start_process: false
        }
      },
      browserstack: {
        host: "hub-cloud.browserstack.com",
        port: 80,
        selenium: {
          start_process: false
        },
        desiredCapabilities: {
          "browserstack.user": appConfig.browserstack.username,
          "browserstack.key": appConfig.browserstack.accessKey,
          browser: "chrome"
        }
      }
    }
  };
}

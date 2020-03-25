var reporter = require("cucumber-html-reporter");

export function generateReport() {
  console.log("generating report");
  var options = {
    theme: "bootstrap",
    jsonFile: "reports/cucumber.json",
    output:
      "reports/test_" +
      new Date()
        .toJSON()
        .split(":")
        .join("")
        .split("-")
        .join("")
        .split(".")
        .join("") +
      ".html",
    reportSuiteAsScenarios: true,
    launchReport: true,
    storeScreenShots: true
  };

  reporter.generate(options);

  return new Promise(resolve => {
    setTimeout(resolve, 0);
  });
}

//more info on `metadata` is available in `options` section below.

//to generate consodilated report from multi-cucumber JSON files, please use `jsonDir` option instead of `jsonFile`. More info is available in `options` section below.

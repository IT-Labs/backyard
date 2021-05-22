# Introduction

This repository contains e2e tests

# Development

1. Install Visual Studio Code
   https://code.visualstudio.com/download
   Open Visual Studio, go to extensions (Ctrl+Shift+x) and install TSLint

2. Node version
   https://nodejs.org/en/download/

3. Yarn version
   https://classic.yarnpkg.com/en/docs/install/#windows-stable

## Run tests locally

To run all tests and test the whole application
yarn test --tags "@all"

To execute specific tests-feature:

yarn test --feature [path of the feature]

Example: yarn test --feature src/features/home/home.feature

## Running tests on docker

Please follow the readme file

## Folder Structure

Features are defined in /features
Whereas steps are defined in /src/features
Whereas steps definitions are defined in /src/domain

# Gherkin

Gherkin uses steps Given, When, Then, And, But
`And` and `But` can be used in the Feature definition file, even though the cucumber npm package does NOT include either And or But. To use them repeat the verb used in the Step Definition file.

## Example

In the Feature file:
Given I navigate to Gmail
And I login to Gmail

In Steps Def File:

Given('I navigate to Gmail', function () {
return gmailSignIn.login(client)  
 });

Given('I login to Gmail', function () {
console.log('login to Gmail ');
}

### Command line options

```
 --env=chrome          Use environment settings specified for chrome
 --env=chrome,chrome   Run 2 tests simultaneous with the same chrome environment settlings from nightwatch.conf.js
```

#### Tags, Annotations with '@' symbol

Reference: https://github.com/mucsi96/nightwatch-cucumber/blob/master/site/data/running-tests/tags.md

Example of using a Tag to select tests to run (aka annotation or decorator)
Tag the feature def:

```
@search
Scenario: Searching Google

  Given I open Google's search page
  Then the title is "Google"
  And the Google search form exists
```

### Global Values

https://github.com/nightwatchjs/nightwatch/issues/483

### Reference

https://github.com/DonPage/Nightwatch-Typescript-example
https://github.com/kallaspriit/typescript-nightwatch-example

## Reports

### HTML report with the result from the automation tests

1. Execute tests (Instructions for executing tests can be found in this file) and an HTML report will be automatically generated.
2. If the report is not generated automatically then execute the following command: yarn generate-report and wait for the browser to be opened with the report.

### HTML Report Content contains

1. Number of failed and passed scenarios
2. Graph with percent of failed skipped and passed scenarios
3. Feature files with executed scenarios. When you click on a specific scenario you can review which steps are passed or failed.
4. If the step is failed you can review the error log by clicking on the "Show Error" button.

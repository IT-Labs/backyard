## Requirements

1. Install Visual Studio Code
   https://code.visualstudio.com/download
   Open Visual Studio, go to extenssions (Ctrl+Shift+x) and install TSLint

2. Node version 8.9
   https://nodejs.org/download/release/v8.9.2/

3. Yarn version 1.10
   https://yarnpkg.com/lang/en/docs/install
   https://github.com/yarnpkg/yarn/releases/tag/v1.10.0

## Run tests for the first time

First of all run the commands:
yarn install (run this on each pull from repository)
then:
npm run build

To run all tests and test the whole application: (must specify customer)
yarn test --customer [customer name] --tags "@all"

To execute specific tests-feature:

yarn test --customer [customer name] --feature [path of the feature]

Example: yarn test --customer hsbc --feature src/features/sign-in/sign-in.feature

### Running tests locally with selenium hub

Running `docker-compose up` will start a selenium hub with 2 nodes (chrome and firefox available only), more details [here](https://github.com/SeleniumHQ/docker-selenium). Tests can use that selenium hub instead of starting a new one each time by setting `startSeleniumServer` flag to false, ex: `yarn test -c hsbc --startSeleniumServer false`. 

## Running Tests on Local Environment

1. Set up the local environment on their own PC. Details are in the following document
   https://github.com/EnterpriseJungle/alumni/blob/develop/scripts/deployment/compose/Readme.md

2. Pull the last version from develop branch

3. If you have a local environment, step 1, download the last volume from the drive each time before running the tests
   https://entjungle.sharepoint.com/Shared%20Documents/Integration%20Testing/docker_integration_volumes.zip

4. Build all projects, open git bash and navigate to /alumni/scripts/deployment/compose run ./run.sh (restore existing volume)

5. Open http://localhost:8080 to verify that all projects are up and running

6. In Visual Studio Code in src > config > yourcorp > development.ts check the URL for tests execution

7. Run tests in Terminal:
   yarn test --customer yourcorp --tags "@[tag name]"
   yarn test --customer [customer name] --feature [path of the feature]
   yarn test --customer [customer name] --feature [path of the feature]:[row number]

## Configuring instance to run the tests

For every customer there is a development.ts file that contains the instance on which the test are to run. Running the tests for specific client on specific instance requires setting that instance in the development.ts file for that customer.

Example: Running tests for client HSBC on instance alumnitest9:
Navigate to: alumni/e2e_tests/src/config/hsbc/development.ts
Change url to: https://alumnitest9a1b2e58e3.hana.ondemand.com/
Run tests

## Test commands for End to End Tests with PhantomJS or Chrome Headles

Go to directory containing project with nightwatch and cucumber

```
cd alumni_app/EnterpriseJungleQA/e2e_tests
 yarn run test --  --customer=bechtel --environment=development  --smoke
```

### Features

Features are defined in /features
Whereas steps are defined in /src/features
Whereas steps definitions are defined in /src/domain
And page object and utilities are in /src/utilities

#### Gherkin syntax

Gherkin uses steps Given , When , Then , And , But
`And` and `But` can be used in the Feature definitiion file, even though the cucumber npm package does NOT include either And or But. To use either, repeat the verb used in the Step Definition file.

##### example:

In Feature file:
Given I navigate to Gmail
And I login to Gmail

In Steps Def File:

Given('I navigate to Gmail', function () {
return gmailSignIn.login(client)  
 });

Given('I login to Gmail', function () {
console.log('login to Gmail ');
}

#### Tags, Annotations with '@' symbol

See section below

### Command line options

```
 --env=chrome          Use environment settings specified for chrome
 --env=chrome,chrome   Run 2 tests simultaneous with the same chrome environment setttings from nightwatch.conf.js
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

Then use the --tag arg

```
npm run e2e-test -- --tag google
```

### Global Values

https://github.com/nightwatchjs/nightwatch/issues/483

### Configuration

Configs for clients and test users are in :

src/config/default.ts
src/config/<COMPANY-ID>/<NODE-PROCESS-ENVIRONMENT>.ts
src/config/custom-environment-variables.ts
src/config/<COMPANY-ID>/custom-environment-variables.ts

#### Secret Passwords

Secrets are read from process variables, to prevent saving password or other secrets into Git history.

The npm `config` package reads process variables from the runtime environment when specified in `src/config/{companyName}/custom-environment-variables.ts`, which imports default mappings from `src/config/custom-environment-variables.ts`. The `custom-environment-variables` files map the environment variable names into the configuration file used by the tests.

The npm config package has documentation at :
https://github.com/lorenwest/node-config
https://github.com/lorenwest/node-config/wiki/Configuration-Files
https://github.com/lorenwest/node-config/wiki/Configuration-Files#file-load-order

#### Configuration Hierarchy

see reference: https://github.com/lorenwest/node-config/wiki/Configuration-Files#file-load-order
The configuration hierarchy
goes from general config to specific config, but the custom-environment-variables override the previous values.

1. src/config/default.ts
2. src/config/<COMPANY-ID>/<NODE-PROCESS-ENVIRONMENT>.ts
3. src/config/<COMPANY-ID>/local.ts (\*optional)
4. src/config/custom-environment-variables.ts
5. src/config/<COMPANY-ID>/custom-environment-variables.ts

The `custom-environment-variables` files map the environment variable names into the configuration structure.

For example, `default.ts` has a field for hostIDP and users, `<COMPANY-ID>/default.ts` has the Company ID, `<COMPANY-ID>/development.ts` has a field for the dev url, and `custom-environment-variables` has the name of the process variable containing the user's email password. These will be combined and validated at run time, into one configuration to run tests.

These variables are then read into node process.env object, and then will be read by the npm config package to configure the tests.

###### Some reference applications on github that use Typescript compiler and .ts files with Nightwatch:

https://github.com/DonPage/Nightwatch-Typescript-example
https://github.com/kallaspriit/typescript-nightwatch-example

## HTML report with the result from the automation tests:

1. Execute tests ( Instructions for executing tests can be found in this file ) and HTML report will be automatically generated.
2. If report is not generated automatically then execute this command: yarn generate-report and wait for the browser to be open with the report.

### HTML Report Content:

1. Number of failed and passed scenarios
2. Graph with percent of failed, skipped and passed scenarios
3. Feature files with executed scenarios. When you click on a specific scenario you can review which steps are passed or failed.
4. If the step is failed you can review the error log by clicking on "Show Error" button.

#!/bin/sh
yarn install
yarn test --tags "@empty" --startSeleniumServer false --seleniumHost "selenium-hub-sample" --seleniumPort "4444" --url "http://fe-dev-empty:3000" --apiUrl "http://api-dev-empty:5000"
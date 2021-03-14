#!/bin/sh
yarn install
yarn test --tags "@basics" --startSeleniumServer false --seleniumHost "selenium-hub-sample" --seleniumPort "4444" --url "http://fe-dev:3000" --apiUrl "http://api-dev:5000"
import { startWebDriver, stopWebDriver } from 'nightwatch-api';

startWebDriver('default').catch(err => console.log(err));

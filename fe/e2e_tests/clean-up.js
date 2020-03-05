#!/usr/bin/env node

const fs = require('fs-extra');

//Replace    "clean": "rimraf build",
var fileToRm = './build';
fs.remove(fileToRm, err => {
  if (err) return console.error(err);
  console.log(`Clean up: successfully removed ${fileToRm}`);
});

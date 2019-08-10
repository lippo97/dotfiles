#!/bin/node

const { exec } = require('child_process');
const fs = require('fs');
const path = require('path');

exec('speedtest-cli --json', (err, stdout, stderr) => {
  const { download, upload, ping } = JSON.parse(stdout);
  const date = new Date();
  const object = {
    date: date.toJSON(),
    download,
    upload,
    ping
  };

  //fs.writeFile(`${path}/report/${date.toJSON()}`, JSON.stringify(object), err => {
  fs.writeFile(path.resolve(__dirname, 'report', date.toJSON()), JSON.stringify(object), err => {
    if (err) {
      console.log("Couldn't save!", err);
    }
  });
});

#!/bin/node

const fs = require('fs');
const path = require('path');
const Chart = require('chartjs');
const { createCanvas, loadImage } = require('canvas');

const canvas = createCanvas(400, 800);
const ctx = canvas.getContext('2d');


fs.readdir(path.resolve(__dirname, 'report'), (err, files) => {
  if (err) {
    console.log("Couldn't read files!", err);
  }

  const dataset = files
    //.filter(f => f.slice(0, 10) === "2019-02-21")
    .map(filename => {
      const obj = JSON.parse(fs.readFileSync(path.resolve(__dirname, 'report', filename), 'utf8'));
      return {
        x: filename,
        y: obj.download
      }
    })

  const config = {
    type: 'line',
    data: {
      datasets: [{
        label: 'Dataset with string point data',
        //backgroundColor: color(window.chartColors.red).alpha(0.5).rgbString(),
        //borderColor: window.chartColors.red,
        fill: false,
        data: dataset    
      }]
    },
    options: {
      responsive: true,
      title: {
        display: true,
        text: 'Chart.js Time Point Data'
      },
      scales: {
        xAxes: [{
          type: 'time',
          display: true,
          scaleLabel: {
            display: true,
            labelString: 'Date'
          },
          ticks: {
            major: {
              fontStyle: 'bold',
              fontColor: '#FF0000'
            }
          }
        }],
        yAxes: [{
          display: true,
          scaleLabel: {
            display: true,
            labelString: 'value'
          }
        }]
      }
    }
  }

  const chart = new Chart(ctx, config);

  const out = fs.createWriteStream(__dirname + '/test.png');
  const stream = canvas.createPNGStream();
  stream.pipe(out);
  out.on('finish', () =>  console.log('The PNG file was created.'));

})

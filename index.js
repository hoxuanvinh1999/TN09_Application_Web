const Mustache = require('mustache');
const fs = require('fs');
const MUSTACHE_MAIN_DIR = './main.mustache';

var date_begin = new Date("09/01/2021");
var date_now = new Date();
var Difference_In_Time = date_now.getTime() - date_begin.getTime();
var Difference_In_Days = Difference_In_Time / (1000 * 3600 * 24);

let DATA = {
  days : Math.round(Difference_In_Days),
  name: 'Ho Xuan Vinh',
  date: new Date().toLocaleDateString('en-GB', {
    weekday: 'long',
    month: 'long',
    day: 'numeric',
    hour: 'numeric',
    minute: 'numeric',
    timeZoneName: 'short',
    timeZone: 'Asia/Singapore',
  }),
};

async function generateReadMe() {
  await fs.readFile(MUSTACHE_MAIN_DIR, (err, data) => {
    if (err) throw err;
    const output = Mustache.render(data.toString(), DATA);
    fs.writeFileSync('README.md', output);
  });
}

async function action() {
  await generateReadMe();
}

action();
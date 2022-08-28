const jsdom = require("jsdom");
const { JSDOM } = jsdom;
const fetch = require('node-fetch');
fs = require('fs');
var Sequelize = require("sequelize");
const mssql = require('mssql');
const http = require('http');
const request = require('request');
// import {fetch, CookieJar} from "node-fetch-cookies";
const { exec } = require("child_process");
const { title } = require("process");

const config = {
  user: 'sa',
  password: 'arenacatupdatefreeze1!',
  server: 'prerelease.duckdns.org',
  database: 'obvious',
  name: 'default',
  trustServerCertificate: true,
  pool: {
    max: 100,
    min: 0,
    idleTimeoutMillis: 30000
  }
};


const pool = new mssql.ConnectionPool(config);
pool.connect();

function timeout(ms) {
  return new Promise(resolve => setTimeout(resolve, ms));
}
// t2();

// async function t2() {
//   var txt = fs.readFileSync('scienceorg.html');
//   const dom = new JSDOM(txt);
//   var c = dom.window.document.getElementsByClassName('card')
//   for (var cc = 0; cc < c.length; cc++) {
//     try{
//     await tt2(c[cc]);
//     console.log('Completed ' + cc + ' of ' + c.length)
//     }catch(e){
//       console.log(e);
//     }
//   }


// }

// async function tt2(c) {

//   var title = c.getElementsByClassName('article-title')[0].children[0].textContent.replaceAll('â€™', '\'').replaceAll('â€˜', '\'');
//   if (c.getElementsByClassName('authors').length == 0 || c.getElementsByClassName('card-body').length == 0)
//     return;
//   var url = c.getElementsByClassName('article-title')[0].children[0].href;
//   var author = c.getElementsByClassName('authors')[0].children[1].textContent.split('\n')[0];
//   var date = c.querySelector('time').textContent;
//   var desc = c.getElementsByClassName('card-body')[0].children[0].children[0].textContent;
//   // title = Buffer.from(title.replaceAll('â€˜', '\'').replaceAll('“', '"').replaceAll('”', '"'), 'ascii').toString();
//   console.log(url)

//   // var res = await fetch('https://science.org/' + url);
//   // res = await res.text();
//   // fs.writeFileSync('res.html', res, (err)=>{})
//   // // const dom2 = await new JSDOM(res);
//   // const resourceLoader = new jsdom.ResourceLoader({
//   //   strictSSL: false,
//   //   userAgent: "Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/73.0.3683.86 Safari/537.36",
//   // });

//   // const options = {
//   //   resources: resourceLoader,
//   //   runScripts: 'dangerously',
//   //   pretendToBeVisual: true,
//   //   virtualConsole: new jsdom.VirtualConsole(),
//   //   cookieJar: new jsdom.CookieJar(),
//   // }

//   // // const dom2 = new JSDOM(``, {
//   // //   url:,
//   // //   referrer: 'https://science.org/' + url,
//   // //   contentType: "text/html",
//   // //   includeNodeLocations: true,
//   // //   storageQuota: 10000000,
//   // //   options: options
//   // // });
//     const { stdout, stderr } = await exec('wget -O tst.html "https://science.org/' + url + '"');
//     await timeout(3000);

//     var eeee = fs.readFileSync('tst.html');
//     const dom2 = new JSDOM(eeee);


//     var e = dom2.window.document.getElementsByClassName('bodySection')[0];
//   if(e == null)
//   return;
//     // while (e == null)
//     // e = dom.window.document.getElementsByClassName('c-article-body')[0];
//     e = e.querySelectorAll('p');
//     // console.log(e);
//     var txte = '';
//     for (f in e) {
//       if (e[f].textContent != null)
//         txte += (e[f].textContent.toLowerCase().replace('/[^\w\s\']|_/g, ""').replace(/\s+/g, " ").replaceAll('“', '').replaceAll('”', ''));
//     }

//     await pool.connect();

//     var result = await pool.request()
//       .input('ArticleName', mssql.NVarChar(4000), title)
//       .input('ArticleURL', mssql.NVarChar(4000), url)
//       .input('Author', mssql.NVarChar(4000), author)
//       .input('ImageURL', mssql.NVarChar(4000), null)
//       .input('Description', mssql.NVarChar(4000), desc)
//       .input('Date', mssql.BigInt, (new Date(date).getTime()))
//       .output('ID', mssql.Int)
//       .execute('addArticle');

//     await fs.writeFile('outputs2/' + result.output.ID + '.txt', txte, function (err) {
//       if (err) return console.log(err);
//     });


//   // console.log(txte);

// }











// fuck(1);
// fuck(2);
// // let rawdata = fs.readFileSync('data/articles.json');
// // let articles = JSON.parse(rawdata);
// async function fuck(f) {


//   for (let i = f; i < 645; i+=2) { //645
//     await shitty(i);
//     console.log('finished thread ' + i)

//   }
// }

// async function shitty(i) {

//   let p = '/home/johns/sketchbook/nature/data/search?order=date_desc&article_type=news,+news-and-views,+editorial,+special-features&page=' + i;
//   var dom = await JSDOM.fromFile(p);
//   let list = [];
//   var es = dom.window.document.getElementsByClassName('app-article-list-row__item');
//   for (var e = 0; e < es.length; e++) {
//     var l = {};
//     try {
//       l.date = new Date(es[e].querySelector('time').textContent).getTime();
//       l.imgurl = es[e].querySelector('img').src.replace('file://', '');
//       l.author = es[e].querySelector('.c-author-list').children[0].children[0].textContent;
//       l.description = es[e].querySelector('.c-card__summary').children[0].textContent;
//       l.title = es[e].querySelector('.c-card__title').children[0].textContent;
//       l.url = es[e].querySelector('a').href.replace('file://', 'https://www.nature.com');
//       list.push(l);
//     } catch (e) {

//     }
//   }
//   await t(list);
// }

// // t();
// async function t(articles) {
//   for (var i = 0; i < articles.length; i++) {
//     await thing(articles[i]);
//     if (i % 10 == 0)
//       console.log('Completed ' + i + ' of ' + articles.length);
//   }
// }


// async function thing(entry) {
//   try {
//     console.log(entry.title);
//     var res = await fetch(entry.url);
//     res = await res.text();
//     const dom = new JSDOM(res);
//     var e = dom.window.document.getElementsByClassName('c-article-body')[0];
//     // while (e == null)
//     // e = dom.window.document.getElementsByClassName('c-article-body')[0];

//     e = e.getElementsByTagName('p');
//     // console.log(e);
//     var txt = '';
//     for (f in e) {
//       if (e[f].textContent != null)
//         txt += (e[f].textContent.toLowerCase().replace('/[^\w\s\']|_/g, ""').replace(/\s+/g, " ").replaceAll('“', '').replaceAll('”', ''));
//     }

//     await pool.connect();
//     var result = await pool.request()
//       .input('ArticleName', mssql.NVarChar(4000), entry.title)
//       .input('ArticleURL', mssql.NVarChar(4000), entry.url)
//       .input('Author', mssql.NVarChar(4000), entry.author)
//       .input('ImageURL', mssql.NVarChar(4000), entry.imgurl)
//       .input('Description', mssql.NVarChar(4000), entry.description)
//       .input('Date', mssql.BigInt, (new Date(entry.date).getTime()))
//       .output('ID', mssql.Int)
//       .execute('addArticle');

//     await fs.writeFile('outputs/' + result.output.ID + '.txt', txt, function (err) {
//       if (err) return console.log(err);
//     });


//     // const file = await fs.createWriteStream('outputs/' + result.output.ID + '.jpg');
//     // console.log('http://' + entry.imgurl);
//     // const request = await http.get('http://' + entry.imgurl, function(response) {
//     //    response.pipe(file);

//     //    // after download completed close filestream
//     //    file.on("finish", () => {
//     //        file.close();
//     //        console.log("image downloaded");
//     //    });
//     // });

//     download('http://' + entry.imgurl, 'outputs/' + result.output.ID + (entry.imgurl.indexOf('.jpg') != -1 ? '.jpg' : '.png'), (e) => {
//       if (e != null) {
//         console.log(e);
//         console.log("trying https")
//         download('https://' + entry.imgurl, 'outputs/' + result.output.ID + (entry.imgurl.indexOf('.jpg') != -1 ? '.jpg' : '.png'), (e) => {
//           if (e != null) {
//             console.log(e);
//             console.log('https failed aswell;')
//           }
//         });
//       }
//     });
//   } catch (e) {
//     console.log(e);
//   }



// }

// //

// async function download(url, dest, cb) {
//   const file = await fs.createWriteStream(dest);
//   const sendReq = await request.get(url);

//   // verify response code
//   sendReq.on('response', (response) => {
//     if (response.statusCode !== 200) {
//       return cb('Response status was ' + response.statusCode);
//     }

//     sendReq.pipe(file);
//   });

//   // close() is async, call cb after close completes
//   file.on('finish', () => file.close(cb));

//   // check for request errors
//   sendReq.on('error', (err) => {
//     fs.unlink(dest, () => cb(err.message)); // delete the (partial) file and then return the error
//   });

//   file.on('error', (err) => { // Handle errors
//     fs.unlink(dest, () => cb(err.message)); // delete the (partial) file and then return the error
//   });
// };


// ss();
// async function ss() {
//   var json = fs.readFileSync('/home/johns/sketchbook/natureCorrelation/updates.json');
//   json = await JSON.parse(json);

//   for (let i = 0; i < json.length; i++) {
//       await sss(json, i);
//   }
// }

// async function sss(json, i){
//   await pool.connect();
//   var result = await pool.request()
//     .query('UPDATE articles SET SociologyMatch = ' + json[i].val + ' WHERE ArticleID = ' + json[i].id + ';');
//   console.log('updated ' + json[i].id);
// }



ss();
async function ss() {
  var json = fs.readFileSync('/home/johns/sketchbook/nature/kws.json');
  json = await JSON.parse(json);

  for (let i = 0; i < json.length; i++) {
      await sss(json, i);
  }
}

async function sss(json, i){
  await pool.connect();
  var result = await pool.request()
    .query('UPDATE articles SET Keywords = \'' + json[i].content.replaceAll('\'','') + '\' WHERE ArticleID = ' + json[i].id + ';');
  console.log('updated ' + json[i].id);
}
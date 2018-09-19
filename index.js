#!/usr/bin/env node
const http  = require('http'),
      BDUSS = '<Your BDUSS>'; // Enter your BDUSS here

var request = function(appid, callback) {
    http.get({
            host    : 'pcs.baidu.com',
            port    : 80,
            path    : '/rest/2.0/pcs/file?app_id=' + appid + '&method=list&path=%2F',
            method  : 'GET',
            headers : {
                'Cookie': 'BDUSS=' + BDUSS,
                'User-Agent': 'netdisk;1.0'
            }
    }, function(res) {
        if (res.statusCode == 200) {
            callback(null, appid);
        } else {
            callback(null, null);
        }
    }).on('error', function(err) {
        callback(err, null);
    });
};

for (var i=266000; i<267000; i++) { // BUG: Too large span may cause timeout errors
    request(i, function(err, appid) {
        if (appid) {
            console.log('AppID ' + appid + ' is avalible.');
        }
    });
}

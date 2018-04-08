var jdata = require("../jdata.json");

exports.index = function(req, res){
  res.render('index', { title: jdata[0].name, jdata: jdata});
}; 
/*
var express = require('express');
var router = express.Router();


router.get('/', function(req, res, next){
	res.render('about',{title:'about', name:'ts'});
});

module.exports = router;
*/

exports.index = function(req, res){
	console.log("about >>>>>>>>>>>>>");
  res.render('about', { title: 'about' });
};

exports.list = function(req, res){
	console.log("aboutList >>>>>>>>>>>>>");
	res.render('aboutList', { title: 'aboutList' });
}; 
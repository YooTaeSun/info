var path = require('path');
var webpack = require('webpack');

module.exports = {
  entry: './app/index.js',
  output: {
    filename: 'bundle.js',
    path: path.resolve(__dirname, 'dist')
  },
  optimization: {
	  minimize: false,
	  //vendor.js 을 참조해서 main.js을 사용할 수 있게
	  splitChunks: {
	    name: 'vendor',
	    chunks: 'initial',
	  }
  },	

  // #2 - Using alias
   resolve: {
     alias: {
       Vendor: path.resolve(__dirname, './app/vendor/')
     }
   },
  // #3 - Provide Plugin
   plugins: [
     new webpack.ProvidePlugin({
       $: 'jquery',
       jqueryObj: 'jquery',
     })
   ]
};

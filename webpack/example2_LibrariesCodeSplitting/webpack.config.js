var webpack = require('webpack');
var path = require('path');
var ManifestPlugin = require('webpack-manifest-plugin');

module.exports = {
  entry: {
    main: './app/index.js',
    vendor: [
      'moment',
      'lodash'
    ]
  },
  output: {
    filename: '[name].js',
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
  plugins: [
/*	  
	// Error: webpack.optimize.CommonsChunkPlugin has been removed, please use config.optimization.splitChunks instead.
    new webpack.optimize.CommonsChunkPlugin({
      name: 'vendor' // Specify the common bundle's name.
    }),
*/    
	new ManifestPlugin({
	  fileName: 'manifest.json',
	  basePath: './dist/'
	})
	]
}



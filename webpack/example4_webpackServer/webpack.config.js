var path = require('path');

module.exports = {
  entry: './app/index.js',
  output: {
    filename: 'bundle.js',
    path: path.resolve(__dirname, 'dist'),
    publicPath: 'dist'
  },
  devtool: "cheap-eval-source-map",
  devServer: {
    publicPath: "/dist/",
    port: 9000
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
};
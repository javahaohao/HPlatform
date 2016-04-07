var fs = require('fs');
var arg = require('argh').argv;//read & parse arguements



var files = [
 'uncompressed/bootstrap.css',

 'uncompressed/ace.css',
 'uncompressed/ace-skins.css'
];

var content = '';
for(var f = 0; f < files.length; f++) {
	content += fs.readFileSync('../assets/css/' + files[f] , 'utf-8');
}

var rtl_func_file = 'files/ace-rtl.js';
var code = fs.readFileSync(rtl_func_file , 'utf-8');
var vm = require('vm');
vm.runInThisContext(code, rtl_func_file);

var rtl_output = makeRTL(content);


var less = require('less');
var parser = new(less.Parser)({
  paths: ['../assets/css/less'], // Specify search paths for @import directives
  //filename: '../assets/css/less/ace-rtl2.less' // Specify a filename, for better error messages
});

parser.parse(fs.readFileSync('../assets/css/less/ace-rtl.less' , 'utf-8'), function (e, tree) {
  rtl_output = rtl_output + "\n" + tree.toCSS();
  if(arg['strip-media']) {
	var strip_func_file = 'files/css-strip-media.js';
	var code = fs.readFileSync(strip_func_file , 'utf-8');
	var vm = require('vm');
	vm.runInThisContext(code, strip_func_file);

	rtl_output = remove_media_queries(rtl_output, 900);//keep `min-width` media queries which are >= 900px
  }
  fs.writeFileSync('../assets/css/uncompressed/ace-rtl.css' , rtl_output , 'utf-8');
  
  parser.parse(rtl_output, function (e, tree) {
	  rtl_output = tree.toCSS({
		// Minify CSS output
		compress: true
	  });
	  fs.writeFileSync('../assets/css/ace-rtl.min.css' , rtl_output , 'utf-8');	  
  });
});





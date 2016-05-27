/**
 * 将以base64的图片url数据转换为Blob
 * 
 * @param dataURI
 *            用url方式表示的base64图片数据
 */
function convertBase64UrlToBlob(dataURI) {
	var mimeString = dataURI.split(',')[0].split(':')[1].split(';')[0]; // mime类型
	var byteString = window.atob(dataURI.split(',')[1]); // base64 解码
	var arrayBuffer = new ArrayBuffer(byteString.length); // 创建缓冲数组
	var intArray = new Uint8Array(arrayBuffer); // 创建视图
	for (i = 0; i < byteString.length; i += 1) {
		intArray[i] = byteString.charCodeAt(i);
	}
	var blob = new Blob([intArray], {
		type : mimeString
	}); // 转成blob
	var reader = new FileReader(); // 通过 FileReader 读取blob类型r
	reader.onload = function() {
		this.result === dataURI; // base64编码}
		reader.readAsDataURL(blob);
	}
	return blob;
}





// 从扫描仪器获取图片
		scan.addImageFile = function(data) {
			debugger;

			var blob2 = convertBase64UrlToBlob("data:image/jpg;base64," + data);

			var blob = new WebUploader.Lib.Blob("asdfasasf", blob2);
			//blob2.name='111';
			
			var file=new WebUploader.File(blob);		
			
			uploader.addFiles(file);
		}

<%@ tag language="java" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/include/taglib.jsp"%>
<%@ attribute name="id" type="java.lang.String" required="true" description="上传控件的ID"%>
<%@ attribute name="name" type="java.lang.String" required="true" description="提交表单的name"%>
<%@ attribute name="value" type="java.lang.String" required="false" description="提交表单的value"%>
<%@ attribute name="fileInputName" type="java.lang.String" required="true" description="type file name"%>
<%@ attribute name="items" type="java.util.List" required="false" description="初始化上传的文件"%>
<%@ attribute name="maxFiles" type="java.lang.Integer" required="false" description="上传文件的最大数量"%>
<%@ attribute name="maxFilesize" type="java.lang.Double" required="false" description="上传文件的最大文件大小"%>
<%@ attribute name="autoQueue" type="java.lang.Boolean" required="false" description="是否自动上传"%>
<%@ attribute name="deleteType" type="java.lang.Boolean" required="false" description="删除方式（true:真删，flase：假删除）"%>
<%@ attribute name="successed" type="java.lang.String" required="false" description="上传之后的回调函数"%>
<%@ attribute name="completed" type="java.lang.String" required="false" description="所有上传成功或失败回调函数"%>
<%@ attribute name="change" type="java.lang.String" required="false" description="改变事件"%>
<p>
	<button class="btn btn-success btn-xs no-border" type="button" id="input-upload">
		<i class="ace-icon fa fa-plus-circle align-top bigger-125"></i>
		增加
	</button>
	<c:if test="${!(empty autoQueue?false:autoQueue)}">
	<button class="btn btn-primary btn-xs no-border" type="button" id="start-upload">
		<i class="ace-icon fa fa-cloud-upload align-top bigger-125"></i>
		上传
	</button>
	</c:if>
	<button class="btn btn-warning btn-xs no-border" type="button" id="cancle-upload">
		<i class="ace-icon fa fa-eraser align-top bigger-125"></i>
		取消
	</button>
</p>
<input type="hidden" name="${name}" id="${name}" value="${value}"/>
<ul class="ace-thumbnails clearfix dropzone" id="${id}">
</ul>
<script src="${contextPath}/static/aui-artTemplate/dist/template.js"></script>
<script id="template" type="text/html">
    <li class="dz-preview dz-file-preview">
    	<div class="dz-details">
    	  	<div class="dz-filename"><span data-dz-name></span></div>
    	  	<div class="dz-size" data-dz-size></div>
    	  	<img data-dz-thumbnail />
    	</div>
    	<div class="progress progress-small progress-striped active">
    		<div class="progress-bar progress-bar-success" data-dz-uploadprogress></div>
    	</div>
    	<div class="dz-success-mark"><span></span></div>
    		<div class="dz-error-mark"><span></span></div>
    		<div class="dz-error-message">
    		<span data-dz-errormessage></span>
    	</div>
    </li>
</script>
<script type="text/javascript">
	var myDropzone;
	//删除文件
	function deleteFile(file){
		if(!!file.xhr&&negatedParam('${empty deleteType?true:deleteType}')){
    		$.ajax({
				type: "POST",
				url: "${adminFullPath}/attachment/deleteAttachment",
				data: "id="+JSON.parse(file.xhr.responseText).id,
				success:function(data){
				}
			});
    	}
		resetFiles();
	}
	//重置文件ids
	function resetFiles(){
		var idArray = [],files = myDropzone.getAcceptedFiles(),attachment;
		if(!!!files||files.length<=0){
			$('#${name}').val('');
		}
		for(var index in files)
			if(!!files[index].xhr){
				attachment = files[index].xhr.responseText;
				idArray.push(!!attachment?JSON.parse(attachment).id:'');
				$('#${name}').val(idArray.join(','));
			}
	}
	//手动增加文件
	function addFile(attach){
		jsonAttach = JSON.parse(attach);
		// Create the mock file:
		var mockFile = {
				upload:{
			        progress: 100,
			        total: jsonAttach.size,
			        bytesSent: jsonAttach.size
			    },
				xhr:{
					responseText:attach
				},
				name:jsonAttach.name,
				processing: true,
				type:jsonAttach.type,
				accepted:true,
				size:jsonAttach.size,
				status:Dropzone.CODEADD
			};
		myDropzone.files.push(mockFile);
		
		// Call the default addedfile event handler
		myDropzone.emit("addedfile", mockFile);
		myDropzone.emit("processing", mockFile);
		myDropzone.emit("uploadprogress", mockFile, 100, mockFile.upload.bytesSent);
		myDropzone.emit("success", mockFile);

		// And optionally show the thumbnail of the file:
		myDropzone.emit("thumbnail", mockFile, platform.getImgMapingImg(jsonAttach));

		// Make sure that there is no progress bar, etc...
		myDropzone.emit("complete", mockFile);

		// If you use the maxFiles option, make sure you adjust it to the
		// correct amount:
		var existingFileCount = 1; // The number of files already uploaded
		myDropzone.options.maxFiles = myDropzone.options.maxFiles - existingFileCount;
	}
	$(function(){
		//http://www.dropzonejs.com/bootstrap.html
		//http://www.renfei.org/blog/dropzone-js-introduction.html
		Dropzone.autoDiscover = false;
		//代码添加的
		Dropzone.CODEADD="codeAdd";
		try {
		  myDropzone = new Dropzone(document.body , {
			url:'${adminFullPath}/attachment/uploadAttachment',
			thumbnailWidth: 200,
	        thumbnailHeight: 200,
			autoQueue:${empty autoQueue?false:autoQueue},
		    paramName: "${fileInputName}", // The name that will be used to transfer the file
		    maxFilesize: ${empty maxFilesize?1024:maxFilesize}, // MB
		    maxFiles:${empty maxFiles?99:maxFiles},
			addRemoveLinks : true,
			previewsContainer: "#${id}", // Define the container to display the previews
			clickable: "#input-upload",
			
			//change the previewTemplate to use Bootstrap progress bars
			previewTemplate: template('template', {}),
	        init: function() {
	            this.on("success", function(file) {
	            	if(!!"${successed}")eval("${successed}(file)");
	            });
	            this.on("removedfile", function(file) {
	            	deleteFile(file);
	            });
	            this.on("complete", function(file) {
	            	if(!!"${completed}")eval("${completed}(file)");
	            	if(file.status!==Dropzone.CODEADD)
	            		resetFiles();
	            });
	        },
			dictResponseError: '上传过程中出现异常！',
	        dictRemoveFile:'删除文件',
	        dictCancelUploadConfirmation:'文件正在上传，您确定要终止文件上传吗？',
	        dictCancelUpload:'终止上传',
	        dictInvalidInputType:'上传文件格式不符！',
	        dictFileTooBig:'上传文件超过指定大小！',
	        dictMaxFilesExceeded:'上传文件超过指定数量！',
	        dictRemoveFileConfirmation:'你确定要删除该文件吗？'
		  });
		} catch(e) {
		  alert('Dropzone.js does not support older browsers!');
		}
		//初始化上传文件信息
		<c:forEach items="${items}" var="attach" varStatus="stat">
			addFile('${elfn:toJSON(attach)}');
		</c:forEach>
		$('#start-upload').on('click',function(){
			myDropzone.enqueueFiles(myDropzone.getFilesWithStatus(Dropzone.ADDED));
		});
		$('#cancle-upload').on('click',function(){
			myDropzone.removeAllFiles(true);
		});
		$('#${name}').on('change',function(){
			eval("${change}()");
		});
	});
</script>
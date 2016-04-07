<%@ tag language="java" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/include/taglib.jsp"%>
<%@ attribute name="id" type="java.lang.String" required="true" description="控件ID"%>
<%@ attribute name="superId" type="java.lang.String" required="false" description="文件所属ID"%>
<%@ attribute name="name" type="java.lang.String" required="false" description="控件Name"%>
<%@ attribute name="formId" type="java.lang.String" required="false" description="form容器，将会把隐藏域的dom元素放到form里面"%>
<%@ attribute name="modeType" type="java.lang.String" required="false" description="上传模式"%>
<%@ attribute name="processType" type="java.lang.String" required="false" description="进度条类型"%>
<%@ attribute name="auto" type="java.lang.String" required="false" description="有文件立即上传"%>
<%@ attribute name="autoSelectServer" type="java.lang.String" required="false" description="是否开启智能上传（默认是true）"%>
<%@ attribute name="chunkedMaximumSize" type="java.lang.String" required="false" description="开启智能上传后分片上传文件大小底线(默认大小5M)"%>
<%@ attribute name="server" type="java.lang.String" required="false" description="上传服务URL"%>
<%@ attribute name="deleteServer" type="java.lang.String" required="false" description="删除文件URL"%>
<%@ attribute name="items" type="java.util.List" required="false" description="初始化上传的文件"%>
<%@ attribute name="chunked" type="java.lang.String" required="false" description="上传文件是否分片，默认分片"%>
<%@ attribute name="chunkSize" type="java.lang.String" required="false" description="如果要分片，分多大一片？ 默认大小为5M"%>
<%@ attribute name="chunkRetry" type="java.lang.String" required="false" description="如果某个分片由于网络问题出错，允许自动重传多少次？"%>
<%@ attribute name="threads" type="java.lang.String" required="false" description="上传并发数。允许同时最大上传进程数"%>
<%@ attribute name="overFormData" type="java.lang.String" required="false" description="文件上传请求的参数表，每次发送都会发送此对象中的参数。[key:value,key:value](js对象格式)"%>
<%@ attribute name="fileVal" type="java.lang.String" required="false" description="设置文件上传域的name"%>
<%@ attribute name="method" type="java.lang.String" required="false" description="文件上传方式，POST或者GET,默认post"%>
<%@ attribute name="sendAsBinary" type="java.lang.String" required="false" description="是否已二进制的流的方式发送文件，这样整个上传内容php://input都为文件内容， 其他参数在$_GET数组中"%>
<%@ attribute name="disableGlobalDnd" type="java.lang.String" required="false" description="是否禁用文件拖拽事件"%>
<%@ attribute name="fileNumLimit" type="java.lang.String" required="false" description="验证文件总数量, 超出则不允许加入队列,默认值50"%>
<%@ attribute name="fileSizeLimit" type="java.lang.String" required="false" description="验证文件总大小是否超出限制, 超出则不允许加入队列，默认大小2G"%>
<%@ attribute name="fileSingleSizeLimit" type="java.lang.String" required="false" description="验证单个文件大小是否超出限制, 超出则不允许加入队列,默认大小1G"%>
<%@ attribute name="duplicate" type="java.lang.String" required="false" description="去重， 根据文件名字、文件大小和最后修改时间来生成hash Key."%>
<%@ attribute name="prepareNextFile" type="java.lang.String" required="false" description="是否允许在文件传输时提前把下一个文件准备好。 对于一个文件的准备工作比较耗时，比如图片压缩，md5序列化。 如果能提前在当前文件传输期处理，可以节省总体耗时,默认为true"%>
<%@ attribute name="changeEvent" type="java.lang.String" required="false" description="change事件"%>
<link rel="stylesheet" type="text/css" href="${contextPath}/static/common/css/webuploader.extends.css" />
<div id="wrapper" style="margin: 0 auto;">
	<p id="btn_p">
		<button class="btn btn-primary btn-xs no-border uploadBtn" type="button" id="${id}-start-upload" style="${auto?'display:none':''}">
			<i class="ace-icon fa fa-cloud-upload align-top bigger-125"></i>
			<span id="upload-type">开始上传</span>
		</button>
		<button class="btn btn-warning btn-xs no-border" type="button" id="${id}-cancle-upload">
			<i class="ace-icon fa fa-eraser align-top bigger-125"></i>
			清空队列
		</button>
		<button class="btn btn-success btn-xs no-border" type="button" id="${id}-input-upload">
		</button>
	</p>
    <div id="container">
        <!--头部，文件选择-->
        <div id="uploader" class="${id}uploader-container">
            <div class="queueList">
                <div id="${id}dndArea" class="placeholder">
                    <div id="filePicker">
                    	<button class="btn btn-primary btn-xs no-border" type="button" id="single_pic_btn" style="display: none">
							<i class="ace-icon fa fa-plus-circle align-top bigger-125"></i>
							选择图片
						</button>
                    </div>
                </div>
            </div>
            <div class="statusBar" style="display:none;">
                <div class="progress progress-striped pos-rel" data-percent="0%">
					<div class="progress-bar progress-bar-success" style="width: 0%;"></div>
				</div>
                <div class="info"></div>
                <div class="btns">
                </div>
            </div>
        </div>
    </div>
</div>
<input name="${empty name?'attName':name}" type="hidden" id="${id}"/>
<script type="text/javascript" src="${contextPath}/static/common/js/md5.js"></script>
<script type="text/javascript" src="${contextPath}/static/webuploader/webuploader-0.1.5/dist/webuploader.js"></script>
<script type="text/javascript" src="${contextPath}/static/common/js/webuploader.extends.js"></script>
<script type="text/javascript">
$(function() {
	if(!!'${formId}'){
		$('#${id}').appendTo($('#${formId}'));
	}
	var ${id}webuploader = $('.${id}uploader-container').webuploader({
		//展现方式(类型有['thumbnails:缩略图模式','single_pic:单图片模式','process:进度条模式'])
		//当设置single_pic模式时，auto属性设置为true，否则无法自动触发上传操作
		modeType:'${empty modeType?"thumbnails":modeType}',
		//进度条类型,详细参数见js
		processType:'${processType}',
		//初始化或者上传完之后文件id隐藏容器(自定义)
		fileIdContainer:$("#${id}"),
        method:'${empty method?"post":method}',
        //设置的formData值都要覆盖默认的上传自带值
        overFormData:{${overFormData}},
        //文件上传过程中每次都提交的数据
        formData:{},
        //文件上传过程中文件所属ID(自定义)
        superId:'${superId}',
        auto:${empty auto?'false':auto},
        fileVal:'${empty fileVal?"fileInput":fileVal}',
        dnd: '#${id}dndArea',
        paste: document.body,
        chunked: ${empty chunked?"true":chunked},
        //默认分片大小
        chunkSize:${empty chunkSize?'5 * 1024 * 1024':chunkSize},
        //智能选择server上传(如果是上传文件有可能小于指定分片大小的话必须开启智能上传)(自定义)
        autoSelectServer:${empty autoSelectServer?'true':autoSelectServer},
        //大于指定文件大小之后才用分片进行上传(默认5M)(自定义)
        chunkedMaximumSize:${empty chunkedMaximumSize?'5 * 1024 * 1024':chunkedMaximumSize},
        //上传服务
        server: !!!'${server}'?(adminFullPath+"/attachment/uploadFile"):'${server}',
        //删除服务(自定义)
        deleteServer:!!!'${deleteServer}'?(adminFullPath+"/attachment/deleteAttachment"):'${deleteServer}',
        // 禁掉全局的拖拽功能。这样不会出现图片拖进页面的时候，把图片打开。
        disableGlobalDnd: ${empty disableGlobalDnd?"false":disableGlobalDnd},
        fileNumLimit: ${empty fileNumLimit?"50":fileNumLimit},
        fileSizeLimit: ${empty fileSizeLimit?"2*1024 * 1024 * 1024":fileSizeLimit},
        fileSingleSizeLimit: ${empty fileSingleSizeLimit?"1*1024 * 1024 * 1024":fileSingleSizeLimit},
        prepareNextFile: ${empty prepareNextFile?"true":prepareNextFile},
        threads: ${empty threads?"6":threads},
        duplicate: ${empty duplicate?"true":duplicate},
        thumb:{
        	// 是否允许放大，如果想要生成小图的时候不失真，此选项应该设置为false.
            allowMagnify: false,
            // 是否允许裁剪。
            crop: true
        },
        compress:false,
        pick: {
        	id:'#${id}-input-upload',
        	innerHTML: '<i class="ace-icon fa fa-plus-circle align-top bigger-125"></i>选择文件'
        }
	});

	//初始化上传文件信息列表
	${id}webuploader.loadingItems(eval('${elfn:toJSON(items)}')||[]);
	

	$('#${id}-cancle-upload').on('click',function(){
		${id}webuploader.queueReset();
	});
	

	$('#${id}').on('change',function(){
		eval("${changeEvent}()");
	});
}); 
</script>
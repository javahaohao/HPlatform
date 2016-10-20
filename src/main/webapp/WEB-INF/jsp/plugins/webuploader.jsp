<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/WEB-INF/include/taglib.jsp"%>
<html>
<head>
    <tags:header inplugins="${plugins.jqui}" title="上传webuploader插件"></tags:header>
</head>
<body>
	<div class="page-content-area">
		<div class="page-header">
			<h1>
				webuploader
				<small>
					<i class="ace-icon fa fa-angle-double-right"></i>
					上传
				</small>
			</h1>
		</div><!-- /.page-header -->
	
		<div class="row">
			<div class="col-xs-12">
				<!-- PAGE CONTENT BEGINS -->
					<tags:webuploader id="test" modeType="single_pic" chunked="true" duplicate="false" items="${attachmentList}" superId="112"></tags:webuploader> 
					<tags:webuploader id="test2" modeType="process" chunked="true" duplicate="false" items="${attachmentList}" superId="112"></tags:webuploader> 
				<!-- PAGE CONTENT ENDS -->
			</div><!-- /.col -->
		</div><!-- /.row -->
	</div><!-- /.page-content-area -->
</body>
</html>
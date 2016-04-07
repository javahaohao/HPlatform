<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/WEB-INF/include/taglib.jsp"%>
<html>
<head>
    <tags:header inplugins="${plugins.jqui},${plugins.validate}" title="${op}新闻"></tags:header>
</head>
<body>
	<div class="page-content-area">
		<div class="page-header">
			<h1>
				新闻
				<small>
					<i class="ace-icon fa fa-angle-double-right"></i>
					 ${op}
				</small>
			</h1>
		</div><!-- /.page-header -->
	
		<div class="row">
			<div class="col-xs-12">
				<!-- PAGE CONTENT BEGINS -->
				<form:form method="post" commandName="news" id="subForm" class="form-horizontal">
					<p>
						<shiro:hasPermission name="news:create">
							<button id="btnSave" type="submit" class="btn btn-info no-border">
								<i class="ace-icon fa fa-edit align-top bigger-125"></i>
								${op}
							</button>
						</shiro:hasPermission>
						<button id="btnBack"class="btn btn-danger no-border" type="button" onclick="javascript:history.go(-1);">
							<i class="ace-icon fa fa-undo align-top bigger-125"></i>
							返回
						</button>
					</p>
			        <form:hidden path="id"/>
			        <div class="form-group">
						<form:label path="newsType" cssClass="control-label col-xs-12 col-sm-2 no-padding-right" for="news">新闻类型：</form:label>
						<div class="col-xs-12 col-sm-5">
							<span class="block input-icon input-icon-right">
								<form:select path="newsType" itemLabel="name" itemValue="id" items="${typeList}" cssClass="select2 width-100 required input-xlarge" title="新闻类型必选"></form:select>
								<i class="ace-icon fa fa-info-circle"></i>
							</span>
						</div>
					</div>
					<div class="form-group">
						<form:label path="source" cssClass="control-label col-xs-12 col-sm-2 no-padding-right" for="news">来源：</form:label>
						<div class="col-xs-12 col-sm-5">
							<span class="block input-icon input-icon-right">
								<form:select path="source" itemLabel="name" itemValue="id" items="${sourceList}" cssClass="select2 width-100 required input-xlarge" title="新闻来源必选"></form:select>
								<i class="ace-icon fa fa-info-circle"></i>
							</span>
						</div>
					</div>
					<div class="form-group">
						<form:label path="title" cssClass="control-label col-xs-12 col-sm-2 no-padding-right" for="news">标题：</form:label>
						<div class="col-xs-12 col-sm-5">
							<span class="block input-icon input-icon-right">
								<form:input path="title" maxlength="50" cssClass="width-100 required input-xlarge" title="标题必填"/>
								<i class="ace-icon fa fa-info-circle"></i>
							</span>
						</div>
					</div>
			
					<div class="form-group">
						<form:label path="summary" cssClass="control-label col-xs-12 col-sm-2 no-padding-right" for="description">简介：</form:label>
						<div class="col-xs-12 col-sm-5">
							<span class="block input-icon input-icon-right">
								<form:textarea path="summary" cssClass="width-100 input-xlarge"/>
								<i class="ace-icon fa fa-info-circle"></i>
							</span>
						</div>
					</div>
					<div class="form-group">
						<form:label path="content" cssClass="control-label col-xs-12 col-sm-2 no-padding-right" for="description">内容：</form:label>
						<div class="col-xs-12 col-sm-7">
							<span class="block input-icon input-icon-right">
								<tags:editor name="content" id="editor1" formId="subForm" value="${news.content}"></tags:editor>
							</span>
						</div>
					</div>
			
			    </form:form>
				<!-- PAGE CONTENT ENDS -->
			</div><!-- /.col -->
		</div><!-- /.row -->
	</div><!-- /.page-content-area -->

    <script>
        $(function () {
			//添加表单验证
        	formValidate($("#subForm"), 'help-block inline error', 'div');
        });
    </script>


</body>
</html>
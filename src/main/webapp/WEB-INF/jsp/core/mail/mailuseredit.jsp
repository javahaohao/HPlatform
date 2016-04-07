<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/include/taglib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<tags:header inplugins="${plugins.jqui},${plugins.validate}" title="邮箱关联"></tags:header>
</head>
<body>
	<div class="page-content-area">
		<div class="page-header">
			<h1>
				邮箱设置
				<small>
					<i class="ace-icon fa fa-angle-double-right"></i>
					 ${op}
				</small>
			</h1>
		</div><!-- /.page-header -->
	
		<div class="row">
			<div class="col-xs-12">
				<!-- PAGE CONTENT BEGINS -->
				<form:form method="post" commandName="mailUser" id="subForm" class="form-horizontal">
					<p>
						<shiro:hasPermission name="mailUser:create">
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
			            <form:label path="user.id" cssClass="control-label col-xs-12 col-sm-3 no-padding-right">用户:</form:label>
			            <div class="col-xs-12 col-sm-5">
			            	<span class="block input-icon input-icon-right">
				            	<form:input path="user.id" maxlength="50" cssClass="width-100 required" title="用户必填"/>
								<i class="ace-icon fa fa-info-circle"></i>
							</span>
						</div>
			        </div>
			        <div class="form-group">
			            <form:label path="mailDict.id" cssClass="control-label col-xs-12 col-sm-3 no-padding-right">邮箱类型:</form:label>
			            <div class="col-xs-12 col-sm-5">
			            	<span class="block input-icon input-icon-right">
				            	<form:input path="mailDict.id" maxlength="50" cssClass="width-100 required" title="邮箱类型必填"/>
								<i class="ace-icon fa fa-info-circle"></i>
							</span>
						</div>
			        </div>
			        <div class="form-group">
			            <form:label path="mailAccount" cssClass="control-label col-xs-12 col-sm-3 no-padding-right">邮箱账号:</form:label>
			            <div class="col-xs-12 col-sm-5">
			            	<span class="block input-icon input-icon-right">
				            	<form:input path="mailAccount" maxlength="50" cssClass="width-100 required" title="邮箱账号必填"/>
								<i class="ace-icon fa fa-info-circle"></i>
							</span>
						</div>
			        </div>
			        <div class="form-group">
			            <form:label path="mailPassword" cssClass="control-label col-xs-12 col-sm-3 no-padding-right">邮箱密码:</form:label>
			            <div class="col-xs-12 col-sm-5">
			            	<span class="block input-icon input-icon-right">
				            	<form:input path="mailPassword" maxlength="50" cssClass="width-100 required" title="邮箱密码必填"/>
								<i class="ace-icon fa fa-info-circle"></i>
							</span>
						</div>
			        </div>
			        <div class="form-group">
			            <form:label path="backupFlag" cssClass="control-label col-xs-12 col-sm-3 no-padding-right">是否备份:</form:label>
			            <div class="col-xs-12 col-sm-5">
			            	<span class="block input-icon input-icon-right">
				            	<form:input path="backupFlag" maxlength="50" cssClass="width-100 required" title="是否备份必填"/>
								<i class="ace-icon fa fa-info-circle"></i>
							</span>
						</div>
			        </div>
			        <div class="form-group">
			            <form:label path="useAble" cssClass="control-label col-xs-12 col-sm-3 no-padding-right">状态:</form:label>
			            <div class="col-xs-12 col-sm-5">
			            	<span class="block input-icon input-icon-right">
				            	<form:input path="useAble" maxlength="50" cssClass="width-100 required" title="状态必填"/>
								<i class="ace-icon fa fa-info-circle"></i>
							</span>
						</div>
			        </div>
			    </form:form>
				<!-- PAGE CONTENT ENDS -->
			</div><!-- /.col -->
		</div><!-- /.row -->
	</div><!-- /.page-content-area -->
	<script type="text/javascript">
		$(function(){
			//添加表单验证
        	formValidate($("#subForm"), 'help-block inline error', 'div');
		});
	</script>
</body>
</html>
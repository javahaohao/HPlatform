<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/include/taglib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<tags:header inplugins="${plugins.jqui},${plugins.validate}" title="邮件服务"></tags:header>
</head>
<body>
	<div class="page-content-area">
		<div class="page-header">
			<h1>
				邮件服务
				<small>
					<i class="ace-icon fa fa-angle-double-right"></i>
					 ${op}
				</small>
			</h1>
		</div><!-- /.page-header -->
	
		<div class="row">
			<div class="col-xs-12">
				<!-- PAGE CONTENT BEGINS -->
				<form:form method="post" commandName="mailDict" id="subForm" class="form-horizontal">
					<p>
						<shiro:hasPermission name="mailDict:create">
							<button id="btnSave" type="submit" class="btn btn-info no-border btn-sm">
								<i class="ace-icon fa fa-edit align-top bigger-125"></i>
								${op}
							</button>
						</shiro:hasPermission>
						<button id="btnBack"class="btn btn-danger no-border btn-sm" type="button" onclick="javascript:history.go(-1);">
							<i class="ace-icon fa fa-undo align-top bigger-125"></i>
							返回
						</button>
					</p>
			        <form:hidden path="id"/>
			
		        	<div class="form-group">
			            <form:label path="type" cssClass="control-label col-xs-12 col-sm-3 no-padding-right">服务类型:</form:label>
			            <div class="col-xs-12 col-sm-5">
			            	<span class="block input-icon input-icon-right">
				            	<form:input path="type" maxlength="50" cssClass="width-100 required" title="服务类型必填"/>
								<i class="ace-icon fa fa-info-circle"></i>
							</span>
						</div>
			        </div>
					<div class="form-group">
			            <form:label path="smtp" cssClass="control-label col-xs-12 col-sm-3 no-padding-right" for="name">SMTP:</form:label>
			            <div class="col-xs-12 col-sm-5">
							<span class="block input-icon input-icon-right">
								<form:input path="smtp" maxlength="50" cssClass="width-100 required" title="SMTP必填"/>
								<i class="ace-icon fa fa-info-circle"></i>
							</span>
						</div>
			        </div>
			        <div class="form-group">
			            <form:label path="smtpPort" cssClass="control-label col-xs-12 col-sm-3 no-padding-right" for="type">SMTP端口号:</form:label>
			            <div class="col-xs-12 col-sm-5">
							<span class="block input-icon input-icon-right">
								<form:input path="smtpPort" maxlength="50" cssClass="width-100 required" title="SMTP端口号必填"/>
								<i class="ace-icon fa fa-info-circle"></i>
							</span>
						</div>
			        </div>
					<div class="form-group">
			            <form:label path="pop3" cssClass="control-label col-xs-12 col-sm-3 no-padding-right" for="url">POP3：</form:label>
			            <div class="col-xs-12 col-sm-5">
							<span class="block input-icon input-icon-right">
								<form:input path="pop3" maxlength="50" cssClass="width-100 required" title="POP3必填"/>
								<i class="ace-icon fa fa-info-circle"></i>
							</span>
						</div>
			        </div>
					<div class="form-group">
			            <form:label path="pop3Port" cssClass="control-label col-xs-12 col-sm-3 no-padding-right" for="permission">POP3端口：</form:label>
			            <div class="col-xs-12 col-sm-5">
							<span class="block input-icon input-icon-right">
								<form:input path="pop3Port" maxlength="50" cssClass="width-100 required" title="POP3端口必填"/>
								<i class="ace-icon fa fa-info-circle"></i>
							</span>
						</div>
			        </div>
			        <div class="form-group">
			            <form:label path="imap" cssClass="control-label col-xs-12 col-sm-3 no-padding-right" for="permission">IMAP：</form:label>
			            <div class="col-xs-12 col-sm-5">
							<span class="block input-icon input-icon-right">
								<form:input path="imap" maxlength="50" cssClass="width-100 required" title="IMAP端口必填"/>
								<i class="ace-icon fa fa-info-circle"></i>
							</span>
						</div>
			        </div>
			        <div class="form-group">
			            <form:label path="imapPort" cssClass="control-label col-xs-12 col-sm-3 no-padding-right" for="permission">IMAP端口：</form:label>
			            <div class="col-xs-12 col-sm-5">
							<span class="block input-icon input-icon-right">
								<form:input path="imapPort" maxlength="50" cssClass="width-100 required" title="IMAP端口必填"/>
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
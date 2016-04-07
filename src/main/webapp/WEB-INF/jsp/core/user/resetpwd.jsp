<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/include/taglib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<tags:header inplugins="${plugins.jqui},${plugins.validate}" title="重置密码"></tags:header>
</head>
<body>
	<div class="container">
	<form:form method="post" class="form-horizontal" modelAttribute="user" action="${adminFullPath}/user/register/resetPassword" id="subForm">
		<p>
			<button id="btnSave" type="submit" class="btn btn-info no-border">
				<i class="ace-icon fa fa-edit align-top bigger-125"></i>
				提交
			</button>
		</p>
		<form:hidden path="id"/>
		<form:hidden path="username"/>
		<div class="form-group">
            <form:label path="password" cssClass="control-label col-xs-12 col-sm-3 no-padding-right" for="name">新密码：</form:label>
            <div class="col-xs-12 col-sm-5">
				<span class="block input-icon input-icon-right">
					<input name="password" type="password" class="width-100" id="password">
					<i class="ace-icon fa fa-info-circle"></i>
				</span>
			</div>
        </div>
        <div class="form-group">
            <form:label path="" cssClass="control-label col-xs-12 col-sm-3 no-padding-right" for="name">确认密码：</form:label>
            <div class="col-xs-12 col-sm-5">
				<span class="block input-icon input-icon-right">
					<input name="confirmPassword" type="password" class="width-100" id="confirmPassword">
					<i class="ace-icon fa fa-info-circle"></i>
				</span>
			</div>
        </div>
	</form:form>
	</div>
	<script type="text/javascript">
		$(function(){
			//添加表单验证
        	formValidate($("#subForm"), 'help-block inline error', 'div',{
        		password:{
        			required:true,
					minlength: 6
        		},
        		confirmPassword:{
        			required:true,
					minlength: 6,
					equalTo: "#password"
        		}
        	},{
        		password:{
        			required:'新密码不能为空！',
					minlength: '最小长度不能小于6位！'
        		},
        		confirmPassword:{
        			required:'确认密码不能为空！',
					minlength: '最小长度不能小于6位！',
					equalTo: "确认密码与新密码输入不一致！"
        		}
        	});
		});
	</script>
</body>
</html>
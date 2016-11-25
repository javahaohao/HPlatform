<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/WEB-INF/include/taglib.jsp"%>
<form:form action="${adminFullPath}/user/changePassword" class="form-horizontal" method="post" modelAttribute="user" id="subForm">
	<form:hidden path="id" id="id"/>
	<input id="salt" type="hidden" value="${user.salt}">
	<input type="hidden" name="from" value="${from}">
	<form:hidden path="username"/>
	<div class="form-group">
          <form:label path="" cssClass="control-label col-xs-12 col-sm-3 no-padding-right" for="oldPwd">原密码：</form:label>
          <div class="col-xs-12 col-sm-5">
		<span class="block input-icon input-icon-right">
			<input name="oldPwd" type="password" class="width-100" id="oldPwd">
			<i class="ace-icon fa fa-info-circle"></i>
		</span>
	</div>
      </div>
		<div class="form-group">
			<form:label path="password" cssClass="control-label col-xs-12 col-sm-3 no-padding-right" for="password">新密码：</form:label>
			<div class="col-xs-12 col-sm-5">
				<span class="block input-icon input-icon-right">
					<input name="password" type="password" class="width-100" id="password">
					<i class="ace-icon fa fa-info-circle"></i>
				</span>
			</div>
      	</div>
      <div class="form-group">
          	<form:label path="" cssClass="control-label col-xs-12 col-sm-3 no-padding-right" for="confirmPassword">确认密码：</form:label>
			<div class="col-xs-12 col-sm-5">
				<span class="block input-icon input-icon-right">
					<input name="confirmPassword" type="password" class="width-100" id="confirmPassword">
					<i class="ace-icon fa fa-info-circle"></i>
				</span>
			</div>
      </div>
      <div class="clearfix form-actions">
		<div class="col-md-offset-3 col-md-9">
			<shiro:hasPermission name="user:info">
			<button class="btn btn-info" type="submit">
				<i class="ace-icon fa fa-check bigger-110"></i>
				提交
			</button>
			</shiro:hasPermission>
			
			<button class="btn btn-sm" type="reset">
				<i class="ace-icon fa fa-reply-all bigger-110"></i>
				重置
			</button>
			
			<button id="btnBack"class="btn btn-danger no-border btn-sm" type="button" onclick="javascript:history.go(-1);">
				<i class="ace-icon fa fa-undo align-top bigger-125"></i>
				返回
			</button>
			
		</div>
	</div>
</form:form>
<script type="text/javascript">
	$(function(){
		//添加表单验证
       	formValidate($("#subForm"), 'help-block inline error', 'div',{
       		oldPwd:{
       			required:true,
				minlength: 6,
				remote: {
				    url: "${adminFullPath}/user/confirmOldPwd",     //后台处理程序
				    type: "post",               //数据发送方式
				    dataType: "json",           //接受数据格式   
				    data: {                     //要传递的数据
				    	password: function() {
				            return $("#oldPwd").val();
				        },
				        id:function(){
				        	return $('#id').val();
				        },
				        salt:function(){
				        	return $('#salt').val();
				        },
				        username:function(){
				        	return $('#username').val();
				        }
				    }
				}
       		},
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
       		oldPwd:{
       			required:'原始密码不能为空！',
				minlength: '最小长度不能小于6位！',
				remote: '输入的原始密码不一致！'
       		},
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
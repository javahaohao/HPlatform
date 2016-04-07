<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/WEB-INF/include/taglib.jsp"%>
<html>
<head>
    <tags:header inplugins="${plugins.jqui},${plugins.validate}" title="编辑群组"></tags:header>
    <style type="text/css">
    	body {background-color: #fff;}
    </style>
</head>
<body>
	<div class="row">
		<div class="col-xs-12">
			<!-- PAGE CONTENT BEGINS -->
			<form:form method="post" commandName="messageGroup" id="groupform" cssClass="form-horizontal" action="${adminFullPath}/message/editGroup" target="_parent">
				<form:hidden path="id"/>
				<form:hidden path="userIds"/>
				<div class="form-group">
					<div class="col-xs-12">
						<span class="block input-icon input-icon-right">
							<tags:webuploader id="pic" name="pic" modeType="single_pic" auto="true"
								items="${elfn:getAttachList(messageGroup.pic)}"></tags:webuploader>
						</span>
					</div>
				</div>
				<div class="form-group">
					<form:label path="group" cssClass="control-label col-xs-3 no-padding-right">群组名：</form:label>
					<div class="col-xs-6">
						<span class="block input-icon input-icon-right">
							<form:input path="group" maxlength="50" cssClass="width-100 required input-xlarge" title="群组名称必填"/>
							<i class="ace-icon fa fa-info-circle"></i>
						</span>
					</div>
				</div>
				<div class="form-group">
					<form:label path="groupRemark" cssClass="control-label col-xs-3 no-padding-right">群签名：</form:label>
					<div class="col-xs-6">
						<span class="block input-icon input-icon-right">
							<form:input path="groupRemark" maxlength="100" cssClass="width-100 input-xlarge"/>
							<i class="ace-icon fa fa-info-circle"></i>
						</span>
					</div>
				</div>
				<div class="form-group">
					<form:label path="" cssClass="control-label col-xs-3 no-padding-right">群成员：</form:label>
					<div class="col-xs-6">
						<span class="block input-icon input-icon-right">
							<tags:multiselect id="users" pk="id" name="nick" excinclued="${elfn:getCurrentUser().id}" unselected="${unselectedusers}" selected="${selectedUsers}"></tags:multiselect>
						</span>
					</div>
				</div>
			</form:form>
			<!-- PAGE CONTENT ENDS -->
		</div><!-- /.col -->
	</div><!-- /.row -->
	<script type="text/javascript">
		var validForm;
		$(function(){
			//添加表单验证
        	validForm = formValidate($("#groupform"), 'help-block inline error', 'div',{
        		group:{
        			required:true,
        			maxlength:50
        		},
        		groupRemark:{
        			maxlength:100
        		}
        	},{
        		group:{
        			required:'群组名称必填！',
        			maxlength:'群组名最大长度为50字符！'
        		},
        		groupRemark:{
        			maxlength:'群组签名最大长度为100字符！'
        		}
        	});
		});
		function beforeSubmit(){
			var users = [];
			$('#users_to option').each(function(){
				users.push($(this).val());
			});
			$('#userIds').val(users.join(','));
		}
	</script>
</body>
</html>
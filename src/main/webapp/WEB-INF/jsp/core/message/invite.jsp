<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/WEB-INF/include/taglib.jsp"%>
<html>
<head>
    <tags:header inplugins="${plugins.jqui}" title="邀请用户"></tags:header>
    <style type="text/css">
    	body {background-color: #fff;}
    </style>
</head>
<body>
	<div class="row">
		<div class="col-xs-12">
			<!-- PAGE CONTENT BEGINS -->
			<form:form method="post" commandName="messageGroup" id="inviteform" cssClass="form-horizontal" action="${adminFullPath}/message/inviteUsers" target="_parent">
				<form:hidden path="id"/>
				<form:hidden path="userIds"/>
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
		function beforeSubmit(){
			var users = [];
			$('#users_to option').each(function(){
				users.push($(this).val());
			});
			if(users.length<=0){
				return false;
			}
			$('#userIds').val(users.join(','));
			return true;
		}
	</script>
</body>
</html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/WEB-INF/include/taglib.jsp"%>
<html>
<head>
    <tags:header inplugins="${plugins.jqui},${plugins.validate}" title="一对一测试${op}"></tags:header>
</head>
<body>
	<div class="page-content-area">
		<div class="page-header">
			<h1>
				一对一测试
				<small>
					<i class="ace-icon fa fa-angle-double-right"></i>
					 ${op}
				</small>
			</h1>
		</div><!-- /.page-header -->
	
		<div class="row">
			<div class="col-xs-12">
				<!-- PAGE CONTENT BEGINS -->
				<form:form method="post" commandName="member" id="subForm" class="form-horizontal">
					<p>
						<shiro:hasPermission name="member:create">
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
						<form:label path="memberName" cssClass="control-label col-xs-12 col-sm-3 no-padding-right" for="memberName">用户名：</form:label>
						<div class="col-xs-12 col-sm-5">
							<span class="block input-icon input-icon-right">
<input id="memberName" name="memberName" class="width-100" value="${member.memberName}" type="text"/>
                                <i class="ace-icon fa fa-info-circle"></i>
							</span>
						</div>
					</div>
					<div class="form-group">
						<form:label path="age" cssClass="control-label col-xs-12 col-sm-3 no-padding-right" for="age">年龄：</form:label>
						<div class="col-xs-12 col-sm-5">
							<span class="block input-icon input-icon-right">
<input id="age" name="age" class="width-100" value="${member.age}" type="text"/>
                                <i class="ace-icon fa fa-info-circle"></i>
							</span>
						</div>
					</div>
					<div class="form-group">
						<form:label path="height" cssClass="control-label col-xs-12 col-sm-3 no-padding-right" for="height">身高：</form:label>
						<div class="col-xs-12 col-sm-5">
							<span class="block input-icon input-icon-right">
<input id="height" name="height" class="width-100" value="${member.height}" type="text"/>
                                <i class="ace-icon fa fa-info-circle"></i>
							</span>
						</div>
					</div>
					<div class="form-group">
						<form:label path="sex" cssClass="control-label col-xs-12 col-sm-3 no-padding-right" for="sex">性别：</form:label>
						<div class="col-xs-12 col-sm-5">
							<span class="block input-icon input-icon-right">
<input id="sex" name="sex" class="width-100" value="${member.sex}" type="text"/>
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
        $(function () {
			//添加表单验证
			formValidate($("#subForm"), 'help-block inline error', 'div',{
				memberName:{
					required:true
				},
				age:{
					required:true
				}
			},{
				memberName:{
					required:'必填'
				},
				age:{
					required:'必填'
				}
			});
        });
    </script>
</body>
</html>
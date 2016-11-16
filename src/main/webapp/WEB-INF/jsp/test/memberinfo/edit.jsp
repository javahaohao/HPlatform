<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/WEB-INF/include/taglib.jsp"%>
<html>
<head>
    <tags:header inplugins="${plugins.jqui},${plugins.validate}" title="一对一测试表${op}"></tags:header>
</head>
<body>
	<div class="page-content-area">
		<div class="page-header">
			<h1>
				一对一测试表
				<small>
					<i class="ace-icon fa fa-angle-double-right"></i>
					 ${op}
				</small>
			</h1>
		</div><!-- /.page-header -->
	
		<div class="row">
			<div class="col-xs-12">
				<!-- PAGE CONTENT BEGINS -->
				<form:form method="post" commandName="memberInfo" id="subForm" class="form-horizontal">
					<p>
						<shiro:hasPermission name="memberInfo:create">
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
						<form:label path="memberId" cssClass="control-label col-xs-12 col-sm-3 no-padding-right" for="memberId">用户信息：</form:label>
						<div class="col-xs-12 col-sm-5">
							<span class="block input-icon input-icon-right">
<form:select path="memberId" itemLabel="memberName" itemValue="id" items="${parents}" cssClass="select2 width-100 input-xlarge"></form:select>
                                <i class="ace-icon fa fa-info-circle"></i>
							</span>
						</div>
					</div>
					<div class="form-group">
						<form:label path="level" cssClass="control-label col-xs-12 col-sm-3 no-padding-right" for="level">等级：</form:label>
						<div class="col-xs-12 col-sm-5">
							<span class="block input-icon input-icon-right">
<input id="level" name="level" class="width-100" value="${memberInfo.level}" type="text"/>
                                <i class="ace-icon fa fa-info-circle"></i>
							</span>
						</div>
					</div>
					<div class="form-group">
						<form:label path="phone" cssClass="control-label col-xs-12 col-sm-3 no-padding-right" for="phone">手机：</form:label>
						<div class="col-xs-12 col-sm-5">
							<span class="block input-icon input-icon-right">
<input id="phone" name="phone" class="width-100" value="${memberInfo.phone}" type="text"/>
                                <i class="ace-icon fa fa-info-circle"></i>
							</span>
						</div>
					</div>
					<div class="form-group">
						<form:label path="email" cssClass="control-label col-xs-12 col-sm-3 no-padding-right" for="email">邮箱：</form:label>
						<div class="col-xs-12 col-sm-5">
							<span class="block input-icon input-icon-right">
<input id="email" name="email" class="width-100" value="${memberInfo.email}" type="text"/>
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
				phone:{
					required:true
				}
			},{
				phone:{
					required:'必填'
				}
			});
        });
    </script>
</body>
</html>
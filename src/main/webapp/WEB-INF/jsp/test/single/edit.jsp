<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/WEB-INF/include/taglib.jsp"%>
<html>
<head>
    <tags:header inplugins="${plugins.jqui},${plugins.validate}" title="测试单表生成${op}"></tags:header>
</head>
<body>
	<div class="page-content-area">
		<div class="page-header">
			<h1>
				测试单表生成
				<small>
					<i class="ace-icon fa fa-angle-double-right"></i>
					 ${op}
				</small>
			</h1>
		</div><!-- /.page-header -->
	
		<div class="row">
			<div class="col-xs-12">
				<!-- PAGE CONTENT BEGINS -->
				<form:form method="post" commandName="single" id="subForm" class="form-horizontal">
					<p>
						<shiro:hasPermission name="single:create">
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
						<form:label path="testOne" cssClass="control-label col-xs-12 col-sm-3 no-padding-right" for="testOne">测试one：</form:label>
						<div class="col-xs-12 col-sm-5">
							<span class="block input-icon input-icon-right">
<input id="testOne" name="testOne" class="width-100" value="${single.testOne}" type="text"/>
                                <i class="ace-icon fa fa-info-circle"></i>
							</span>
						</div>
					</div>
					<div class="form-group">
						<form:label path="testTwo" cssClass="control-label col-xs-12 col-sm-3 no-padding-right" for="testTwo">测试two：</form:label>
						<div class="col-xs-12 col-sm-5">
							<span class="block input-icon input-icon-right">
<input id="testTwo" name="testTwo" class="width-100" value="${single.testTwo}" type="text"/>
                                <i class="ace-icon fa fa-info-circle"></i>
							</span>
						</div>
					</div>
					<div class="form-group">
						<form:label path="testThree" cssClass="control-label col-xs-12 col-sm-3 no-padding-right" for="testThree">测试three：</form:label>
						<div class="col-xs-12 col-sm-5">
							<span class="block input-icon input-icon-right">
<input id="testThree" name="testThree" class="width-100" value="${single.testThree}" type="text"/>
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
				testOne:{
					required:true
				},
				testTwo:{
					required:true
				},
				testThree:{
					required:true
				}
			},{
				testOne:{
					required:'必填'
				},
				testTwo:{
					required:'必填'
				},
				testThree:{
					required:'必填'
				}
			});
        });
    </script>
</body>
</html>
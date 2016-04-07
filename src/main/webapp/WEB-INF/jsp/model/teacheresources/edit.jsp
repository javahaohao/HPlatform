<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/WEB-INF/include/taglib.jsp"%>
<html>
<head>
    <tags:header inplugins="${plugins.jqui},${plugins.validate},${plugins.wysiwyg}" title="教师资源${op}"></tags:header>
</head>
<body>
	<div class="page-content-area">
		<div class="page-header">
			<h1>
				教师资源
				<small>
					<i class="ace-icon fa fa-angle-double-right"></i>
					 ${op}
				</small>
			</h1>
		</div><!-- /.page-header -->
	
		<div class="row">
			<div class="col-xs-12">
				<!-- PAGE CONTENT BEGINS -->
				<form:form method="post" commandName="teacheResources" id="subForm" class="form-horizontal">
					<p>
						<shiro:hasPermission name="teacheResources:create">
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
						<form:label path="frontCover" cssClass="control-label col-xs-12 col-sm-3 no-padding-right" for="frontCover">封面：</form:label>
						<div class="col-xs-12 col-sm-5">
							<span class="block input-icon input-icon-right">
								<div class="center">
										<tags:webuploader id="frontCover" fileVal="frontCover" name="frontCover" modeType="single_pic" 
												items="${elfn:getAttachList(teacheResources.frontCover)}" superId="${teacheResources.id}" 
												server="${adminFullPath}/teacheResources/uploadFrontCover"></tags:webuploader>
	
									<div class="space-4"></div>
	
									<div class="width-80 label label-info label-xlg arrowed-in arrowed-in-right">
										<div class="inline position-relative">
											<a href="#" class="user-title-label">
												<i class="icon-circle light-green middle"></i>
												&nbsp;
												<span class="white">封面</span>
											</a>
										</div>
									</div>
								</div>
							</span>
						</div>
					</div>
					<div class="form-group">
						<form:label path="title" cssClass="control-label col-xs-12 col-sm-3 no-padding-right" for="title">标题：</form:label>
						<div class="col-xs-12 col-sm-5">
							<span class="block input-icon input-icon-right">
								<form:input path="title" cssClass="width-100 input-xlarge"/>
								<i class="ace-icon fa fa-info-circle"></i>
							</span>
						</div>
					</div>
					<div class="form-group">
						<form:label path="classify" cssClass="control-label col-xs-12 col-sm-3 no-padding-right" for="classify">分类：</form:label>
						<div class="col-xs-12 col-sm-5">
							<span class="block input-icon input-icon-right">
								<form:select path="classify" items="${elfn:getChildDictById(constants.DICT_FRONTCOVER_PARENT_ID)}" itemLabel="name" itemValue="id" cssClass="select2 width-100"></form:select>
							</span>
						</div>
					</div>
					<div class="form-group">
						<form:label path="summary" cssClass="control-label col-xs-12 col-sm-3 no-padding-right" for="summary">摘要：</form:label>
						<div class="col-xs-12 col-sm-5">
							<span class="block input-icon input-icon-right">
								<form:textarea path="summary" cssClass="autosize-transition form-control"/>
								<i class="ace-icon fa fa-info-circle"></i>
							</span>
						</div>
					</div>
					<div class="form-group">
						<form:label path="description" cssClass="control-label col-xs-12 col-sm-3 no-padding-right" for="description">描述：</form:label>
						<div class="col-xs-12 col-sm-8">
							<span class="block input-icon input-icon-right">
								<div class="wysiwyg-editor" id="editor1">${teacheResources.description}</div>
								<form:hidden path="description" id="content"/>
							</span>
						</div>
					</div>
					<div class="form-group">
						<form:label path="resources" cssClass="control-label col-xs-12 col-sm-3 no-padding-right" for="resources">资源：</form:label>
						<div class="col-xs-12 col-sm-8">
							<span class="block input-icon input-icon-right">
								<tags:webuploader id="teachResources" auto="true" name="resources" modeType="process" chunked="true" duplicate="false" items="${elfn:getAttachList(teacheResources.resources)}" changeEvent="change"></tags:webuploader>
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
        	formValidate($("#subForm"), 'help-block inline error', 'div');
			//textarea autosize
        	$('textarea[class*=autosize]').autosize({append: "\n"});
    		
    		$('#subForm').on('submit', function() {
         		  var hidden_input =$('#content');

         		  var html_content = $('#editor1').html();
         		  hidden_input.val( html_content );
         		  //put the editor's HTML into hidden_input and it will be sent to server
         		});
          	$('#editor1').ace_wysiwyg();
          	
    		$('#frontCover').on('change',function(){
    			change();
    		});
        });
        function change(){
        	window.onbeforeunload = function(){
        		return "您确定要退出页面吗？"; 
    		}
        }
        
    </script>
</body>
</html>
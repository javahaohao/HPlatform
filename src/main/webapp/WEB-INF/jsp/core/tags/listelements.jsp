<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/WEB-INF/include/taglib.jsp"%>
<html>
<head>
    <tags:header inplugins="${plugins.jqui},${plugins.template}" title="标签元素"></tags:header>
</head>
<body>
	<div class="page-content-area">
		<div class="page-header">
			<h1>
				标签元素
				<small>
					<i class="ace-icon fa fa-angle-double-right"></i>
					 定义
				</small>
			</h1>
		</div><!-- /.page-header -->
		<form action="${adminFullPath}/tags/editElement" method="post">
		<input type="hidden" value="${tagId}" name="id">
		<div class="row">
			<div class="col-xs-12">
				<!-- PAGE CONTENT BEGINS -->
				<p>
					<shiro:hasPermission name="tags:create">
						<button id="btnSave" type="submit" class="btn btn-info no-border">
							<i class="ace-icon fa fa-pencil align-top bigger-125"></i>
							保存
						</button>
					</shiro:hasPermission>
					<shiro:hasPermission name="tags:create">
						<button id="btnAdd" type="button" class="btn btn-warning no-border">
							<i class="ace-icon fa fa-plus align-top bigger-125"></i>
							加行
						</button>
					</shiro:hasPermission>
					<button id="btnBack"class="btn btn-danger no-border" type="button" onclick="javascript:history.go(-1);">
						<i class="ace-icon fa fa-undo align-top bigger-125"></i>
						返回
					</button>
				</p>
				<div class="table-header">
					&nbsp;
				</div>
				<div class="modal-body no-padding">
					<table id="sortable" class="table table-striped table-bordered table-hover no-margin-bottom no-border-top">
					    <thead>
					        <tr>
					            <th>元素名称</th>
					            <th>默认值</th>
					            <th>元素举例</th>
					            <th>元素描述</th>
					            <th>必填项</th>
					            <th>元素排序</th>
					            <th>操作</th>
					        </tr>
					    </thead>
					    <tbody>
					        <c:forEach items="${elementList}" var="element" varStatus="stat">
					            <tr>
						            <td>
						            	<input type="hidden" value="${element.id}" name="elements[${stat.index}].id" class="width-100" id="elementId">
						            	<input type="text" value="${element.elementName}" name="elements[${stat.index}].elementName" class="width-100">
						            </td>
						            <td>
						            	<input type="text" value="${element.defaultVal}" name="elements[${stat.index}].defaultVal" class="width-100">
						            </td>
						            <td>
						            	<input type="text" value="${element.description}" name="elements[${stat.index}].description" class="width-100">
						            </td>
						            <td>
						            	<input type="text" value="${element.remark}" name="elements[${stat.index}].remark" class="width-100">
						            </td>
						            <td>
						            	<select name="elements[${stat.index}].required" class="select2" style="min-width: 110px;">
						            		<c:forEach items="${elfn:getChildDictById(constants.DICT_YES_NO_PARENT_ID)}" var="dict">
						            			<option value="${dict.id}" ${dict.id==element.required?'selected="selected"':''}>${dict.name}</option>
						            		</c:forEach>
						            	</select>
						            </td>
						            <td>
						            	<input type="text" value="${element.sequence}" name="elements[${stat.index}].sequence" class="width-100">
						            </td>
					                <td>
					                	<div class="visible-md visible-lg hidden-sm hidden-xs action-buttons">
						                    <shiro:hasPermission name="tags:delete">
						                    	<a class="deleteBtn red" href="#" title="删除">
													<i class="ace-icon fa fa-minus bigger-130"></i>
												</a>
						                    </shiro:hasPermission>
										</div>
					                </td>
					            </tr>
					        </c:forEach>
					    </tbody>
					</table>
				</div>
				<!-- PAGE CONTENT ENDS -->
			</div><!-- /.col -->
		</div><!-- /.row -->
		</form>
	</div><!-- /.page-content-area -->
	<script src="${contextPath}/static/aui-artTemplate/dist/template.js"></script>
	<script id="comment" type="text/html">
		<tr>
			<td>
				<input type="text" value="" name="elements[{{index}}].elementName" class="width-100">
			</td>
			<td>
				<input type="text" value="" name="elements[{{index}}].defaultVal" class="width-100">
			</td>
			<td>
				<input type="text" value="" name="elements[{{index}}].description" class="width-100">
			</td>
			<td>
				<input type="text" value="" name="elements[{{index}}].remark" class="width-100">
			</td>
			<td>
				<select name="elements[{{index}}].required" class="select2" style="min-width: 110px;">
					<c:forEach items="${elfn:getChildDictById(constants.DICT_YES_NO_PARENT_ID)}" var="dict">
						<option value="${dict.id}">${dict.name}</option>
					</c:forEach>
				</select>
			<td>
				<input type="text" name="elements[{{index}}].sequence" value="{{index*10}}" class="width-100">
			</td>
		    <td>
		    	<div class="visible-md visible-lg hidden-sm hidden-xs action-buttons">
			        <a class="deleteBtn red" href="#" title="删除">
						<i class="ace-icon fa fa-minus bigger-130"></i>
					</a>
				</div>
		    </td>
		</tr>
	</script>
	<script type="text/javascript">
		$(function(){
			var rowCount = $('tbody tr').size();
			$(document).on('click',".deleteBtn",function() {
				var self = this,tr = $(this).closest('tr');
				var element = $('#elementId',tr);
				if(!!element&&element.size()>0){
					platform.showDeleteDialog({
						beforDeleteHandler:function(dialog){
							$.ajax({
							   type: "POST",
							   url: "${adminFullPath}/tags/deleteElement",
							   data: 'id='+element.val(),
							   dataType:'text',
							   success: function(data){
								   tr.remove();
							   }
							});
						}
					});
				}else{
					tr.remove();
				}
	        });
			$('#btnAdd').on('click',function(){
				rowCount++;
				$(template('comment', {index:rowCount})).appendTo($('tbody'));
			});
		});
	</script>
</body>
</html>
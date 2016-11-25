<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/WEB-INF/include/taglib.jsp"%>
<html>
<head>
    <title>角色列表</title>
    <tags:header inplugins="${plugins.jqui},${plugins.validate}" title="角色列表"></tags:header>
</head>
<body>
	<div class="page-content-area">
		<div class="page-header">
			<h1>
				角色
				<small>
					<i class="ace-icon fa fa-angle-double-right"></i>
					 列表
				</small>
			</h1>
		</div><!-- /.page-header -->
	
		<div class="row">
			<div class="col-xs-12">
				<!-- PAGE CONTENT BEGINS -->
				<c:if test="${not empty msg}">
					<div class="alert alert-info">
						<button type="button" class="close" data-dismiss="alert">
							<i class="icon-remove"></i>
						</button>
						<strong>提示!</strong>
							${msg}
						<br />
					</div>
				</c:if>
				<p>
					<shiro:hasPermission name="role:create">
						<button id="btnAdd" class="btn btn-info no-border">
							<i class="ace-icon fa fa-pencil align-top bigger-125 btn-sm"></i>
							新增角色
						</button>
					</shiro:hasPermission>
					<shiro:hasPermission name="role:delete">
						<button id="btnDeleBatch"class="btn btn-danger no-border btn-sm">
							<i class="ace-icon fa fa-trash-o align-top bigger-125"></i>
							批量删除
						</button>
					</shiro:hasPermission>
				</p>
				<div class="table-header">
					&nbsp;
				</div>
				<div class="modal-body no-padding">
					<table id="sortable" class="table table-striped table-bordered table-hover no-margin-bottom no-border-top">
					    <thead>
					        <tr>
					        	<th class="center"><input type="checkbox" id="checkAll" class="ace"/><span class="lbl"></span></th>
					        	<th>#</th>
					            <th>角色名称</th>
					            <th>角色描述</th>
					            <th>拥有的资源</th>
					            <th>操作</th>
					        </tr>
					    </thead>
					    <tbody>
					        <c:forEach items="${roleList}" var="role" varStatus="stat">
					            <tr>
					            	<td class="center"><input name="idList" type="checkbox" class="ace"/><span class="lbl"></span></td>
					            	<td>${stat.index+1}</td>
					                <td>${role.role}</td>
					                <td>${role.description}</td>
					                <td>${elfn:resourceNames(role.resourceIds)}</td>
					                <td>
					                	<div class="visible-md visible-lg hidden-sm hidden-xs action-buttons">
											<shiro:hasPermission name="role:update">
												<a class="green" href="${adminFullPath}/role/${role.id}/update" title="修改">
													<i class="ace-icon fa fa-pencil bigger-130"></i>
												</a>
						                    </shiro:hasPermission>
						                    
						                    <shiro:hasPermission name="role:delete">
						                    	<a class="deleteBtn red" href="#" data-id="${role.id}" title="删除">
													<i class="ace-icon fa fa-trash-o bigger-130"></i>
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
	</div><!-- /.page-content-area -->
	<script type="text/javascript">
		$(function(){
			$('#btnAdd').on('click',function(){
				window.location="${adminFullPath}/role/create";
			});
			$(".deleteBtn").click(function() {
				var self = this;
	        	platform.showDeleteDialog({
					beforDeleteHandler:function(dialog){
						window.location="${adminFullPath}/role/delete?id="+$(self).attr("data-id");
					}
				});
	        });
			$('#btnDeleBatch').on('click',function(){
				var result = getTableChecked();
				if(!!!result)
					return false;
				platform.showDeleteDialog({
					beforDeleteHandler:function(dialog){
						window.location="${adminFullPath}/role/deleteBatch?id="+result;
					}
				});
			});
			//添加表格排序事件
			$('#sortable').dataTable({
				"aoColumns": [
			      { "bSortable": false },
			      { "bSortable": false }, null,null, null,
				  { "bSortable": false }
				],"aaSorting": []});
			//添加表格全选事件
			bindCheckAllEvent();
		});
	</script>
</body>
</html>
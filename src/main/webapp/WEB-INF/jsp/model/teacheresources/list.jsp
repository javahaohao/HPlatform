<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/WEB-INF/include/taglib.jsp"%>
<html>
<head>
    <tags:header inplugins="${plugins.jqui},${plugins.dataTables}" title="教师资源"></tags:header>
</head>
<body>
	<div class="page-content-area">
		<div class="page-header">
			<h1>
				教师资源
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
					<shiro:hasPermission name="teacheResources:create">
						<button id="btnAdd" class="btn btn-info no-border">
							<i class="ace-icon fa fa-pencil align-top bigger-125"></i>
							新增
						</button>
					</shiro:hasPermission>
					<shiro:hasPermission name="teacheResources:delete">
						<button id="btnDeleBatch"class="btn btn-danger no-border">
							<i class="ace-icon fa fa-trash-o align-top bigger-125"></i>
							删除
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
					            <th>封面</th>
					            <th>标题</th>
					            <th>分类</th>
					            <th>审核状态</th>
					            <th>状态</th>
					            <th>浏览次数</th>
					            <th>收藏次数</th>
					            <th>操作</th>
					        </tr>
					    </thead>
					    <tbody>
					        <c:forEach items="${teacheResourcesList}" var="teacheResources" varStatus="stat">
					            <tr>
					            	<td class="center"><input name="idList" type="checkbox" class="ace" value="${teacheResources.id}"/><span class="lbl"></span></td>
					            	<td>${stat.index+1}</td>
						            <td>
						            	<a href="${adminFullPath}/teacheResources/${teacheResources.id}/update" title="查看详情">
						            		<img alt="" src="${adminFullPath}/attachment/readImageStreamId?id=${teacheResources.frontCover}" height="50">
						            	</a>
						            </td>
						            <td>
						            	<a href="${adminFullPath}/teacheResources/${teacheResources.id}/update" title="查看详情">
						            	${teacheResources.title}
						            	</a>
						            </td>
						            <td>${elfn:getDictById(teacheResources.classify).name}</td>
						            <td><tags:status flable="未审核" value="${teacheResources.checkup==constants.DICT_YES_PARENT_ID}" tlable="通过" nullable="未通过"></tags:status></td>
						            <td><tags:status flable="未发布" value="${teacheResources.status==constants.DICT_YES_PARENT_ID}" tlable="已发布" nullable="未操作"></tags:status></td>
						            <td>${teacheResources.browsers}</td>
						            <td>${teacheResources.collect}</td>
					                <td>
					                	<div class="visible-md visible-lg hidden-sm hidden-xs action-buttons">
											<shiro:hasPermission name="teacheResources:update">
												<a class="green" href="${adminFullPath}/teacheResources/${teacheResources.id}/update" title="修改">
													<i class="ace-icon fa fa-pencil bigger-130"></i>
												</a>
						                    </shiro:hasPermission>
						                    
						                    <shiro:hasPermission name="teacheResources:delete">
						                    	<a class="deleteBtn red" href="#" data-id="${teacheResources.id}" title="删除">
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
				window.location="${adminFullPath}/teacheResources/add";
			});
			$(".deleteBtn").click(function() {
				var self = this;
	        	platform.showDeleteDialog({
					beforDeleteHandler:function(dialog){
						window.location="${adminFullPath}/teacheResources/"+$(self).attr("data-id")+"/delete";
					}
				});
	        });
			$('#btnDeleBatch').on('click',function(){
				var result = getTableChecked();
				if(!!!result)
					return false;
				platform.showDeleteDialog({
					beforDeleteHandler:function(dialog){
						window.location="${adminFullPath}/teacheResources/deleteBatch?id="+result;
					}
				});
			});
			//添加表格排序事件
			$('#sortable').dataTable({
				"aoColumns": [
			      { "bSortable": false },
			      { "bSortable": false }, null,null,null,null,null,null,null,
				  { "bSortable": false }
				],"aaSorting": []});
			//添加表格全选事件
			bindCheckAllEvent();
		});
	</script>
</body>
</html>
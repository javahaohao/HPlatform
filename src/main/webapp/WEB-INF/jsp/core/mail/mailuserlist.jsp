<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/include/taglib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<tags:header inplugins="${plugins.jqui},${plugins.dataTables}" title="用户邮件设置"></tags:header>
</head>
<body>
	<div class="page-content-area">
		<div class="page-header">
			<h1>
				组件
				<small>
					<i class="ace-icon fa fa-angle-double-right"></i>
					 用户邮件
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
					<shiro:hasPermission name="mailUser:create">
						<button id="btnAdd" class="btn btn-info no-border">
							<i class="ace-icon fa fa-pencil align-top bigger-125"></i>
							邮件关联
						</button>
					</shiro:hasPermission>
					<shiro:hasPermission name="mailUser:delete">
						<button id="btnDeleBatch"class="btn btn-danger no-border">
							<i class="ace-icon fa fa-trash-o align-top bigger-125"></i>
							批量删除
						</button>
					</shiro:hasPermission>
				</p>
				<div class="table-header">
					&nbsp;
				</div>
				<div class="table-responsive">
					<table id="sortable" class="table table-striped table-bordered table-hover">
					    <thead>
					        <tr>
					        	<th class="center"><input type="checkbox" id="checkAll" class="ace"/><span class="lbl"></span></th>
					        	<th>#</th>
					            <th>用户</th>
					            <th>邮箱类型</th>
					            <th>邮箱账号</th>
					            <th>邮箱密码</th>
					            <th>是否备份</th>
					            <th>状态</th>
					            <th>创建人</th>
					            <th>创建时间</th>
					            <th>修改人</th>
					            <th>修改时间</th>
					            <th>操作</th>
					        </tr>
					    </thead>
					    <tbody>
					        <c:forEach items="${mailUserList}" var="mailUser" varStatus="stat">
					            <tr>
					            	<td class="center"><input name="idList" type="checkbox" class="ace"/><span class="lbl"></span></td>
					            	<td>${stat.index+1}</td>
					                <td>${elfn:getUserById(mailUser.user.id).username}</td>
					                <td>${mailUser.mailDict.id}</td>
					                <td>${mailUser.mailAccount}</td>
					                <td>${mailUser.mailPassword}</td>
					                <td>${mailUser.backupFlag}</td>
					                <td>${mailUser.useAble}</td>
					                <td>${elfn:getUserById(mailUser.createUser).username}</td>
					                <td><fmt:formatDate value="${mailUser.createDate}" type="both"/></td>
					                <td>${elfn:getUserById(mailUser.updateUser).username}</td>
					                <td><fmt:formatDate value="${mailUser.updateDate}" type="both"/></td>
					                <td>
					                	<div class="visible-md visible-lg hidden-sm hidden-xs action-buttons">
											<shiro:hasPermission name="mailUser:update">
												<a class="green" href="${adminFullPath}/mailUser/${mailUser.id}/update" title="修改">
													<i class="ace-icon fa fa-pencil bigger-130"></i>
												</a>
						                    </shiro:hasPermission>
						                    
						                    <shiro:hasPermission name="mailUser:delete">
						                    	<a class="deleteBtn red" href="#" data-id="${mailUser.id}" title="删除">
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
				window.location="${adminFullPath}/mailUser/add";
			});
			$(".deleteBtn").click(function() {
				var self = this;
				platform.showDeleteDialog({
					beforDeleteHandler:function(dialog){
						window.location="${adminFullPath}/mailUser/delete?id="+$(self).attr("data-id");
					}
				});
	        });
			$('#btnDeleBatch').on('click',function(){
				var result = getTableChecked();
				if(!!!result)
					return false;
				platform.showDeleteDialog({
					beforDeleteHandler:function(dialog){
						window.location="${adminFullPath}/mailUser/deleteBatch?id="+result;
					}
				});
			});
			//添加表格排序事件
			$('#sortable').dataTable({
				"aoColumns": [
			      { "bSortable": false },
			      { "bSortable": false }, null,null, null,null,null, null,null,null, null,null,null,
				  { "bSortable": false }
				],"aaSorting": []});
			//添加表格全选事件
			bindCheckAllEvent();
		});
	</script>
</body>
</html>
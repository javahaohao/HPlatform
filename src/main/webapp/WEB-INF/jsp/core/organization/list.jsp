<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/include/taglib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<tags:header inplugins="${plugins.jqui}" title="组织机构"></tags:header>
    <link rel="stylesheet" href="${contextPath}/static/jquery-treetable/stylesheets/jquery.treetable.css">
    <link rel="stylesheet" href="${contextPath}/static/jquery-treetable/stylesheets/jquery.treetable.theme.default.css">
    <style>
        #table th, #table td {
            font-size: 14px;
            padding : 8px;
        }

    </style>
</head>
<body>
	<div class="page-content-area">
		<div class="page-header">
			<h1>
				组织机构
				<small>
					<i class="ace-icon fa fa-angle-double-right"></i>
					 树列表
				</small>
			</h1>
		</div><!-- /.page-header -->
	
		<div class="row">
			<div class="col-xs-12">
				<!-- PAGE CONTENT BEGINS -->
				<c:if test="${not empty msg}">
				    <div class="message">${msg}</div>
				</c:if>
				
				<table id="table">
				    <thead>
				        <tr>
				            <th>名称</th>
				            <th>是否启用</th>
				            <th>创建人</th>
				            <th>创建时间</th>
				            <th>修改人</th>
				            <th>修改时间</th>
				            <th>操作</th>
				        </tr>
				    </thead>
				    <tbody>
				        <c:forEach items="${organizationList}" var="organization">
				            <tr data-tt-id='${organization.id}' <c:if test="${not organization.rootNode}">data-tt-parent-id='${organization.parentId}'</c:if>>
				                <td>${organization.name}</td>
				                <td>${organization.available}</td>
				                 <td>${elfn:getUserById(organization.createUser).username}</td>
					                <td><fmt:formatDate value="${organization.createDate}" type="both"/></td>
					                <td>${elfn:getUserById(organization.updateUser).username}</td>
					                <td><fmt:formatDate value="${organization.updateDate}" type="both"/></td>
				                <td>
				                	<div class="visible-md visible-lg hidden-sm hidden-xs action-buttons">
					                    <shiro:hasPermission name="organization:create">
					                        <a href="${adminFullPath}/organization/${organization.id}/appendChild" title="添加子节点">
					                        	<i class="ace-icon fa fa-cogs bigger-130"></i>
					                        </a>
					                    </shiro:hasPermission>
					
					                    <shiro:hasPermission name="organization:update">
					                        <a class="green" href="${adminFullPath}/organization/${organization.id}/update" title="修改">
					                        	<i class="ace-icon fa fa-pencil bigger-130"></i>
					                        </a>
					                    </shiro:hasPermission>
					                    <c:if test="${not organization.rootNode}">
						                    <shiro:hasPermission name="organization:delete">
						                        <a class="deleteBtn red" href="#" data-id="${organization.id}" title="删除">
						                        	<i class="ace-icon fa fa-trash-o bigger-130"></i>
						                        </a>
						                    </shiro:hasPermission>
					                    </c:if>
									</div>
				                </td>
				            </tr>
				        </c:forEach>
				    </tbody>
				</table>
				<!-- PAGE CONTENT ENDS -->
			</div><!-- /.col -->
		</div><!-- /.row -->
	</div><!-- /.page-content-area -->

	<script src="${contextPath}/static/jquery-treetable/javascripts/src/jquery.treetable.js"></script>
	<script>
	    $(function() {
	        $("#table").treetable({ expandable: true }).treetable("expandNode", "1");
	        $(".deleteBtn").click(function() {
	        	platform.showDeleteDialog({
					beforDeleteHandler:function(dialog){
						location.href = "${adminFullPath}/organization/"+$(this).data("id")+"/delete";
					}
				});
	        });
	    });
	</script>
</body>
</html>
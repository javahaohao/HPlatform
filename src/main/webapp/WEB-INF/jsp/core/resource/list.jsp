<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/WEB-INF/include/taglib.jsp"%>
<html>
<head>
	<tags:header inplugins="${plugins.jqui}" title="资源列表"></tags:header>
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
				资源
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
				            <th>类型</th>
				            <th>URL路径</th>
				            <th>权限字符串</th>
				            <th>操作</th>
				        </tr>
				    </thead>
				    <tbody>
				        <c:forEach items="${resourceList}" var="resource">
				            <tr data-tt-id='${resource.id}' <c:if test="${not resource.rootNode}">data-tt-parent-id='${resource.parentId}'</c:if>>
				                <td>${resource.name}</td>
				                <td>${resource.type.info}</td>
				                <td>${resource.url}</td>
				                <td>${resource.permission}</td>
				                <td>
				                	<div class="visible-md visible-lg hidden-sm hidden-xs action-buttons">
					                    <shiro:hasPermission name="resource:create">
					                        <c:if test="${resource.type ne 'button'}">
						                        <a href="${adminFullPath}/resource/${resource.id}/appendChild" title="添加子节点">
						                        	<i class="ace-icon fa fa-cogs bigger-130"></i>
						                        </a>
					                        </c:if>
					                    </shiro:hasPermission>
					
					                    <shiro:hasPermission name="resource:update">
					                        <a class="green" href="${adminFullPath}/resource/${resource.id}/update" title="修改">
					                        	<i class="ace-icon fa fa-pencil bigger-130"></i>
					                        </a>
					                    </shiro:hasPermission>
					                    <c:if test="${not resource.rootNode}">
						                    <shiro:hasPermission name="resource:delete">
						                        <a class="deleteBtn red" href="#" data-id="${resource.id}" title="删除">
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
	        $("#table").treetable({ expandable: true}).treetable("expandNode", "1");
	        if(!!'${expandNodeId}'){
	        	var idArray = '${expandNodeId}'.split('/');
	        	for(var index in idArray)
	        		if(!!idArray[parseInt(index)+1])
	        			$("#table").treetable("expandNode", idArray[parseInt(index)+1]);
	        }
	        $(".deleteBtn").click(function() {
	        	var self =this;
	        	platform.showDeleteDialog({
					beforDeleteHandler:function(dialog){
						location.href = "${adminFullPath}/resource/"+$(self).attr("data-id")+"/delete";
					}
				});
	        });
	    });
	</script>
</body>
</html>
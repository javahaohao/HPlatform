<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/WEB-INF/include/taglib.jsp"%>
<html>
<head>
    <tags:header inplugins="${plugins.jqui}" title="字典信息"></tags:header>
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
				字典
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
				            <th>值</th>
				            <th>含义</th>
				            <th>父节点</th>
				            <th>创建人</th>
				            <th>创建时间</th>
				            <th>修改人</th>
				            <th>修改时间</th>
				            <th>操作</th>
				        </tr>
				    </thead>
				    <tbody>
				        <c:forEach items="${dictList}" var="dict">
				            <tr data-tt-id='${dict.id}' <c:if test="${not dict.rootNode}">data-tt-parent-id='${dict.parentId}'</c:if>>
				                <td>${dict.name}</td>
				                <td>${dict.value}</td>
				                <td>${dict.means}</td>
				                <td>${elfn:getDictById(dict.parentId).name}</td>
				                <td>${elfn:getUserById(dict.createUser).username}</td>
				                <td><fmt:formatDate value="${dict.createDate}" type="date"/></td>
				                <td>${elfn:getUserById(dict.updateUser).username}</td>
				                <td><fmt:formatDate value="${dict.updateDate}" type="date"/></td>
				                <td>
				                	<div class="visible-md visible-lg hidden-sm hidden-xs action-buttons">
					                    <shiro:hasPermission name="dict:create">
					                        <a href="${adminFullPath}/dict/${dict.id}/appendChild" title="添加子节点">
					                        	<i class="ace-icon fa fa-cogs bigger-130"></i>
					                        </a>
					                    </shiro:hasPermission>
					
					                    <shiro:hasPermission name="dict:update">
					                        <a class="green" href="${adminFullPath}/dict/${dict.id}/update" title="修改">
					                        	<i class="ace-icon fa fa-pencil bigger-130"></i>
					                        </a>
					                    </shiro:hasPermission>
					                    <c:if test="${not dict.rootNode}">
						                    <shiro:hasPermission name="dict:delete">
						                        <a class="deleteBtn red" href="#" data-id="${dict.id}" title="删除">
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
        $("#table").treetable({ expandable: true }).treetable("expandNode", 1);
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
					location.href = "${adminFullPath}/dict/"+$(self).attr("data-id")+"/delete";
				}
			});
        });
    });
</script>
</body>
</html>
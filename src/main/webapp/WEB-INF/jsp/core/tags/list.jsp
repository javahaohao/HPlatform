<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/WEB-INF/include/taglib.jsp"%>
<html>
<head>
    <tags:header inplugins="${plugins.jqui},${plugins.jqgrid},${plugins.template}" title="标签库"></tags:header>
</head>
<body>
	<div class="page-content-area">
		<div class="page-header">
			<h1>
				标签库
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
				
				<form action="${adminFullPath}/tags/updateSequence" method="post">
				<p>
					<shiro:hasPermission name="tags:create">
						<button id="btnAdd" class="btn btn-info no-border" type="button">
							<i class="ace-icon fa fa-pencil align-top bigger-125"></i>
							新增
						</button>
					</shiro:hasPermission>
					<shiro:hasPermission name="tags:delete">
						<button id="btnDeleBatch"class="btn btn-danger no-border" type="button">
							<i class="ace-icon fa fa-trash-o align-top bigger-125"></i>
							删除
						</button>
					</shiro:hasPermission>
					<shiro:hasPermission name="tags:update">
						<button class="btn btn-warning no-border" type="submit">
							<i class="ace-icon fa fa-sort-numeric-asc align-top bigger-125"></i>
							排序
						</button>
					</shiro:hasPermission>
				</p>
				<div class="modal-body no-padding">
					<table id="grid-table">
					</table>
					<div id="grid-page"></div>
				</div>
				</form>
				<!-- PAGE CONTENT ENDS -->
			</div><!-- /.col -->
		</div><!-- /.row -->
	</div><!-- /.page-content-area -->
	<script type="text/html" id="oper">
	<div class="visible-md visible-lg hidden-sm hidden-xs action-buttons">
		<shiro:hasPermission name="tags:update">
			<a class="green" href="${adminFullPath}/tags/{{id}}/update" title="修改">
				<i class="ace-icon fa fa-pencil bigger-130"></i>
			</a>
	    </shiro:hasPermission>
	    <shiro:hasPermission name="tags:create">
			<a class="blue" href="${adminFullPath}/tags/{{id}}/viewElement" title="元素">
				<i class="ace-icon fa fa-fire bigger-130"></i>
			</a>
	    </shiro:hasPermission>
	    <shiro:hasPermission name="tags:delete">
	    	<a class="deleteBtn red" href="#" data-id="{{id}}" title="删除">
				<i class="ace-icon fa fa-trash-o bigger-130"></i>
			</a>
	    </shiro:hasPermission>
	</div>
	</script>
	<script type="text/javascript">
		$(function(){
			$('#btnAdd').on('click',function(){
				window.location="${adminFullPath}/tags/add";
			});
			$(".deleteBtn").click(function() {
				var self = this;
	        	platform.showDeleteDialog({
					beforDeleteHandler:function(dialog){
						window.location="${adminFullPath}/tags/"+$(self).attr("data-id")+"/delete";
					}
				});
	        });
			$('#btnDeleBatch').on('click',function(){
				var result = getTableChecked();
				if(!!!result)
					return false;
				platform.showDeleteDialog({
					beforDeleteHandler:function(dialog){
						window.location="${adminFullPath}/tags/deleteBatch?id="+result;
					}
				});
			});
			//渲染表格
			$('#grid-table').jqDatagrid({
				caption: "列表",
				url:'${adminFullPath}/tags/list'
			},{
				columnModel:[
					{header:'标签名字',name:'tagName',index:'tag_name',sortable:true},
					{header:'说明',name:'remark',index:'remark',sortable:true},
					{header:'标签状态',name:'status',index:'status',sortable:true},
					{header:'排序',name:'',sortable:false,formatter:function(val,options,obj,oper){
						return '<input type="hidden" value="'+obj.id+'" name="tagList['+(this.rows.length-1)+'].id"/><input value="'+obj.sequence+'" name="tagList['+(this.rows.length-1)+'].sequence" style="width: 60px;"/>';
					}},
					{header:'创建人',name:'createUserName',index:'create_user',sortable:true},
					{header:'创建时间',name:'createDate',index:'create_date',sortable:true,formatter:function(val,options,obj,oper){
						return new Date(val).format('yyyy-MM-dd hh:mm:ss');
					}},
					{header:'修改人',name:'updateUserName',index:'update_user',sortable:true},
					{header:'修改时间',name:'updateDate',index:'update_date',sortable:true,formatter:function(val,options,obj,oper){
						return new Date(val).format('yyyy-MM-dd hh:mm:ss');
					}},
					{header:'操作',name:'',sortable:false,title:false,classes:'no-white-space',formatter:function(val,options,obj,oper){
						return template('oper',obj);
					}}
				]
			});
		});
	</script>
</body>
</html>
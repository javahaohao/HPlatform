<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/WEB-INF/include/taglib.jsp"%>
<html>
<head>
	<tags:header inplugins="${plugins.jqgrid},${plugins.template},${plugins.jqui}" title="用户信息"></tags:header>
</head>
<body>
	<div class="page-content-area">
		<div class="page-header">
			<h1>
				用户
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
					<shiro:hasPermission name="user:create">
						<button id="btnAdd" class="btn btn-info no-border btn-sm">
							<i class="ace-icon fa fa-pencil align-top bigger-125"></i>
							新增用户
						</button>
					</shiro:hasPermission>
					<shiro:hasPermission name="user:delete">
						<button id="btnDeleBatch"class="btn btn-danger no-border btn-sm">
							<i class="ace-icon fa fa-trash-o align-top bigger-125"></i>
							批量删除
						</button>
					</shiro:hasPermission>
				</p>
				<div class="table-responsive">
					<table id="grid-table">
					</table>
					<div id="grid-page"></div>
				</div>
				<!-- PAGE CONTENT ENDS -->
			</div><!-- /.col -->
		</div><!-- /.row -->
	</div><!-- /.page-content-area -->
	<script type="text/html" id="oper">
	<div class="visible-md visible-lg hidden-sm hidden-xs action-buttons">
		<shiro:hasPermission name="user:update">
			<a class="light-red" href="${adminFullPath}/user/{{id}}/initUserPwd" title="初始密码">
				<i class="ace-icon fa fa-leaf bigger-130"></i>
			</a>
	    </shiro:hasPermission>
		<shiro:hasPermission name="user:update">
			<a class="green" href="${adminFullPath}/user/{{id}}/update" title="修改">
				<i class="ace-icon fa fa-pencil bigger-130"></i>
			</a>
	    </shiro:hasPermission>
	    
	    <shiro:hasPermission name="user:delete">
	    	<a class="deleteBtn red" href="#" data-id="{{id}}" title="删除">
				<i class="ace-icon fa fa-trash-o bigger-130"></i>
			</a>
	    </shiro:hasPermission>
	    <shiro:hasPermission name="user:update">
	        <a class="blue" href="${adminFullPath}/user/{{id}}/changePassword" title="改密">
	        	<i class="ace-icon fa fa-key bigger-130"></i>
	        </a>
	        {{if !activation}}
	            <a class="blue" href="${adminFullPath}/user/{{id}}/true/activation" title="激活">
	            	<i class="ace-icon fa fa-unlock bigger-130"></i>
	            </a>
	        {{/if}}
	        {{if activation}}
	            <a class="blue" href="${adminFullPath}/user/{{id}}/false/activation" title="锁定">
	            	<i class="ace-icon fa fa-lock bigger-130"></i>
	            </a>
	        {{/if}}
	    </shiro:hasPermission>
	</div>
	</script>
	<script type="text/javascript">
		$(function(){
			$('#btnAdd').on('click',function(){
				window.location="${adminFullPath}/user/create";
			});
			$(".deleteBtn").click(function() {
				var dataId = $(this).attr("data-id");
	        	platform.showDeleteDialog({
					beforDeleteHandler:function(dialog){
						window.location="${adminFullPath}/user/delete?id="+dataId;
					}
				});
	        });
			$('#btnDeleBatch').on('click',function(){
				var result = getTableChecked();
				if(!!!result)
					return false;
				platform.showDeleteDialog({
					beforDeleteHandler:function(dialog){
						window.location="${adminFullPath}/user/deleteBatch?id="+result;
					}
				});
			});
			
			//渲染表格
			$('#grid-table').jqDatagrid({
				caption: "列表",
				url:'${adminFullPath}/user/list'
			},{
				columnModel:[
					{header:'头像',name:'headPic',sortable:false,width:'40px',formatter:function(val,obj,row,oper){
						return '<img alt="" src="${adminFullPath}/attachment/readImageStreamId?id='+val+'" height="50" onerror="this.src=\'${contextPath}/static/common/img/profile-pic.jpg\'">';
					}},
					{header:'姓名',name:'realName',index:'real_name',sortable:true},
					{header:'用户名',name:'username',index:'username',sortable:true},
					{header:'人员类型',name:'userTypeDict.name',index:'user_type',sortable:true},
					{header:'所属组织',name:'organizationName',index:'organization_id',sortable:true},
					{header:'角色列表',name:'roleNames',index:'role_ids',sortable:false},
					{header:'操作',name:'',sortable:false,title:false,classes:'no-white-space',formatter:function(val,obj,row,oper){
						return template('oper',row);
					}}
				]
			});
		});
	</script>
</body>
</html>
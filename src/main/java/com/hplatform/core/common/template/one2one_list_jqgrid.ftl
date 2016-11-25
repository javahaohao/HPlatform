<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/WEB-INF/include/taglib.jsp"%>
<html>
<head>
    <tags:header inplugins="${"$"}{plugins.jqgrid},${"$"}{plugins.jqui},${"$"}{plugins.template},${"$"}{plugins.jbox}" title="${table.comments}"></tags:header>
</head>
<body>
	<div class="page-content-area">
		<div class="page-header">
			<h1>
				${table.comments}
				<small>
					<i class="ace-icon fa fa-angle-double-right"></i>
					 列表
				</small>
			</h1>
		</div><!-- /.page-header -->
	
		<div class="row">
			<div class="col-xs-12">
				<!-- PAGE CONTENT BEGINS -->
				<c:if test="${"$"}{not empty msg}">
					<div class="alert alert-info">
						<button type="button" class="close" data-dismiss="alert">
							<i class="icon-remove"></i>
						</button>
						<strong>提示!</strong>
							${"$"}{msg}
						<br />
					</div>
				</c:if>
				<p>
					<shiro:hasPermission name="${table.domainName?uncap_first}:create">
						<button id="btnAdd" class="btn btn-info no-border btn-sm">
							<i class="ace-icon fa fa-pencil align-top bigger-125"></i>
							新增
						</button>
					</shiro:hasPermission>
					<shiro:hasPermission name="${table.domainName?uncap_first}:delete">
						<button id="btnDeleBatch"class="btn btn-danger no-border btn-sm">
							<i class="ace-icon fa fa-trash-o align-top bigger-125"></i>
							删除
						</button>
					</shiro:hasPermission>
				</p>
				<div class="modal-body no-padding">
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
			<shiro:hasPermission name="${table.domainName?uncap_first}:update">
				<a class="green" href="${"$"}{adminFullPath}/${table.domainName?uncap_first}/{{id}}/update" title="修改">
					<i class="ace-icon fa fa-pencil bigger-130"></i>
				</a>
            </shiro:hasPermission>
            
            <shiro:hasPermission name="${table.domainName?uncap_first}:delete">
            	<a class="deleteBtn red" href="#" data-id="{{id}}" title="删除">
					<i class="ace-icon fa fa-trash-o bigger-130"></i>
				</a>
            </shiro:hasPermission>
		</div>
	</script>
	<script type="text/javascript">
		$(function(){
			$('#btnAdd').on('click',function(){
				window.location="${"$"}{adminFullPath}/${table.domainName?uncap_first}/add";
			});
            $(document).on('click',".deleteBtn",function() {
				var self = this;
	        	platform.showDeleteDialog({
					beforDeleteHandler:function(dialog){
						window.location="${"$"}{adminFullPath}/${table.domainName?uncap_first}/"+$(self).attr("data-id")+"/delete";
					}
				});
	        });
			$('#btnDeleBatch').on('click',function(){
				var result = getTableChecked();
				if(!!!result)
					return false;
				platform.showDeleteDialog({
					beforDeleteHandler:function(dialog){
						window.location="${"$"}{adminFullPath}/${table.domainName?uncap_first}/deleteBatch?id="+result;
					}
				});
			});
			//jqgrid渲染表格配置
			$('#grid-table').jqDatagrid({
				caption: "列表",
				url:'${"$"}{adminFullPath}/${table.domainName?uncap_first}/list'
			},{
				columnModel:[
					<#list table.columnList as column> 
		        	<#if !column.hideFlag??||!column.hideFlag>
		        	{header:'${column.comments}',name:'${(column.propertiesName=='createUser'||column.propertiesName=='updateUser')?string((column.propertiesName+'Name'),column.propertiesName)}',index:'${table.tableAlias}.${column.columnName}',sortable:${column.sortFlag?string('true','false')}<#if column.propertiesType=='java.util.Date'>,formatter:function(val,options,obj,oper){
                        return new Date(val).format('yyyy-MM-dd hh:mm:ss');
                    }</#if>},
		            </#if>
		            </#list>
					{header:'操作',name:'',sortable:false,title:false,classes:'no-white-space',formatter:function(val,obj,row,oper){
						return template('oper',row);
					}}
				]
			});
		});
	</script>
</body>
</html>
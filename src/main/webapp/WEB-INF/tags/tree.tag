<%@ tag language="java" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/include/taglib.jsp"%>
<%@ attribute name="name" type="java.lang.String" required="false" description="form表单提交的tree的name"%>
<%@ attribute name="title" type="java.lang.String" required="false" description="验证错误提示信息"%>
<%@ attribute name="value" type="java.lang.Object" required="false" description="表单的value"%>
<%@ attribute name="checked" type="java.lang.Boolean" required="false" description="是否需要选中"%>
<%@ attribute name="labelName" type="java.lang.String" required="false" description="标签name"%>
<%@ attribute name="labelValue" type="java.lang.String" required="false" description="标签value"%>
<%@ attribute name="cssClass" type="java.lang.String" required="false" description="tree的id css样式"%>
<%@ attribute name="type" type="java.lang.String" required="false" description="tree类型"%>
<%@ attribute name="data" type="java.util.List" required="false" description="tree要展示的数据"%>
<%@ attribute name="readonly" type="java.lang.Boolean" required="false" description="只读标示"%>
<%@ attribute name="checkHandler" type="java.lang.String" required="false" description="选中回调事件"%>
<input type="hidden" id="${name}" class="${cssClass}" name="${name}" value="${value}">
<input type="text" id="${labelName}" class="${cssClass}" name="${labelName}" title="${title}" value="${labelValue}" ${!readonly?"lableinput='lableinput'":""} readonly for="menuContent">
<style>
    ul.ztree {margin-top: 10px;border: 1px solid #617775;background: #f0f6e4;width:220px;height:200px;overflow-y:scroll;overflow-x:auto;}
</style>
<script type="text/javascript">
	$(function () {
		$('body').append('<div id="menuContent" class="menuContent" style="display:none; position: absolute;z-index: 100;"><ul id="tree" class="ztree" style="margin-top:0;width:100%;"></ul></div>');
	    var setting = {
	        check: {
	            enable: true ,
	            chkboxType: { "Y": "", "N": "" }
	        },
	        view: {
	            dblClickExpand: false
	        },
	        data: {
	            simpleData: {
	                enable: true,
	                rootPId: "00"
	            }
	        },
	        callback: {
	            onCheck: onCheck
	        }
	    };
	    var zNodes =[];
	    zNodes.push({ id:"1", pId:"00", pIds:"0/", name:"根节点"});
	    <c:forEach items="${data}" var="r">
	        <c:if test="${not r.rootNode}">
	        zNodes.push({ id:"${r.id}", pId:"${r.parentId}", pIds:"${r.parentIds}", name:"${r.name}"<c:if test="${checked}">,checked:${elfn:in(value, r.id)}</c:if>});
	        </c:if>
        </c:forEach>
	    
	    $.fn.zTree.init($("#tree"), setting, zNodes).expandAll(true);
	    $("input[lableinput='lableinput']").click(showMenu);
	});
	function onCheck(e, treeId, treeNode) {
	    var zTree = $.fn.zTree.getZTreeObj("tree"),
	            nodes = zTree.getCheckedNodes(true),
	            id = "",
	            name = "";
	    nodes.sort(function compare(a,b){return a.id-b.id;});
	    for (var i=0, l=nodes.length; i<l; i++) {
	        id += nodes[i].id + ",";
	        name += nodes[i].name + ",";
	    }
	    if (id.length > 0 ) id = id.substring(0, id.length-1);
	    if (name.length > 0 ) name = name.substring(0, name.length-1);
	    $("#${name}").val(id);
	    $("#${labelName}").val(name);
	    <c:if test="${not empty checkHandler}">
	    	eval('${checkHandler}(treeNode)');
	    </c:if>
	//    hideMenu();
	}
	
	function showMenu() {
		var cityObj = $("#${labelName}");
        var cityOffset = $("#${labelName}").offset();
        $("#menuContent").css({left:cityOffset.left + "px", top:cityOffset.top + cityObj.outerHeight() + "px",width:($("input[for='menuContent']").outerWidth())+"px"}).slideDown("fast");
	
	    $("body").bind("mousedown", onBodyDown);
	}
	function hideMenu() {
	    $("#menuContent").fadeOut("fast");
	    $("body").unbind("mousedown", onBodyDown);
	}
	function onBodyDown(event) {
	    if (!(event.target.id == "menuContent" || $(event.target).parents("#menuContent").length>0)) {
	        hideMenu();
	    }
	}
</script>
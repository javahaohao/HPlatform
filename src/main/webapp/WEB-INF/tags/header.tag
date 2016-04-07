<%@ tag language="java" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/include/taglib.jsp"%>
<%@ attribute name="title" type="java.lang.String" required="true" description="标题"%>
<%@ attribute name="inplugins" type="java.lang.String" required="true" description="引入插件(jqui,fullcalendar,select2,editable,jqgrid,dropzone,jbox,ztree)"%>
<c:if test="${empty inplugins}">
	<c:set value="*" var="inplugins"></c:set>
</c:if>
<c:set value="${inplugins eq '*'}" var="all"></c:set>
<title>${empty title?"标题":title}</title>
<meta name="keywords" content="哈哈" />
<meta name="description" content="哈哈" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<link rel="icon" href="${contextPath}/static/common/img/favicon.ico" mce_href="/favicon.ico" type="image/x-icon">
<link rel="shortcut icon" href="${contextPath}/static/common/img/favicon.ico" mce_href="/favicon.ico" type="image/x-icon">
<!-- basic styles -->
<link href="${contextPath}/static/ace_admin1.3.1/assets/css/bootstrap.min.css" rel="stylesheet" type="text/css"/>
<link href="${contextPath}/static/font-awesome-4.3.0/css/font-awesome.min.css" rel="stylesheet" type="text/css"/>
<!--[if IE 7]>
  <link rel="stylesheet" href="${contextPath}/static/ace_admin1.3.1/assets/css/font-awesome-ie7.min.css" type="text/css"/>
<![endif]-->

<!-- page specific plugin styles -->
<c:if test="${fn:contains(inplugins,plugins.jqui)||all}">
<link rel="stylesheet" href="${contextPath}/static/ace_admin1.3.1/assets/css/jquery-ui.min.css" />
</c:if>
<c:if test="${fn:contains(inplugins,plugins.fullcalendar)||all}">
<link rel="stylesheet" href="${contextPath}/static/ace_admin1.3.1/assets/css/fullcalendar.css" />
</c:if>
<link rel="stylesheet" href="${contextPath}/static/ace_admin1.3.1/assets/css/jquery.gritter.css" />
<c:if test="${fn:contains(inplugins,plugins.select2)||all}">
<link rel="stylesheet" href="${contextPath}/static/ace_admin1.3.1/assets/css/select2.css" />
</c:if>
<c:if test="${fn:contains(inplugins,plugins.editable)||all}">
<link rel="stylesheet" href="${contextPath}/static/ace_admin1.3.1/assets/css/bootstrap-editable.css" />
</c:if>
<c:if test="${fn:contains(inplugins,plugins.jqgrid)||all}">
<link rel="stylesheet" href="${contextPath}/static/ace_admin1.3.1/assets/css/ui.jqgrid.css" />
</c:if>
<!-- fonts -->
<!-- page specific plugin styles -->
<c:if test="${fn:contains(inplugins,plugins.dropzone)||all}">
<link rel="stylesheet" href="${contextPath}/static/ace_admin1.3.1/assets/css/dropzone.css" />
</c:if>
<!-- ace styles -->

<link rel="stylesheet" href="${contextPath}/static/ace_admin1.3.1/assets/css/ace.min.css" type="text/css"/>
<link rel="stylesheet" href="${contextPath}/static/ace_admin1.3.1/assets/css/ace-rtl.min.css" type="text/css"/>
<link rel="stylesheet" href="${contextPath}/static/ace_admin1.3.1/assets/css/ace-skins.min.css" type="text/css"/>
<c:if test="${fn:contains(inplugins,plugins.jbox)||all}">
<link rel="stylesheet" href="${contextPath}/static/jBox/Skins/Blue/jbox.css" />
</c:if>

<!--[if lte IE 8]>
  <link rel="stylesheet" href="${contextPath}/static/ace_admin1.3.1/assets/css/ace-ie.min.css" type="text/css"/>
<![endif]-->

<c:if test="${fn:contains(inplugins,plugins.ztree)||all}">
<link rel="stylesheet" href="${contextPath}/static/JQuery zTree v3.5.15/css/zTreeStyle/zTreeStyle.css">
</c:if>
<!-- inline styles related to this page -->

<!-- ace settings handler -->

<script src="${contextPath}/static/ace_admin1.3.1/assets/js/ace-extra.min.js"></script>

<!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->

<!--[if lt IE 9]>
<script src="${contextPath}/static/ace_admin1.3.1/assets/js/html5shiv.js"></script>
<script src="${contextPath}/static/ace_admin1.3.1/assets/js/respond.min.js"></script>
<![endif]-->

<link rel="stylesheet" href="${contextPath}/static/common/css/common.css" />
<script type="text/javascript">
	contextPath = "${contextPath}";
	adminFullPath = "${adminFullPath}";
	siteFullPath = "${siteFullPath}";
</script>

<!--[if IE]>
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script>
<![endif]-->

<!--[if !IE]> -->

<script type="text/javascript">
	window.jQuery || document.write("<script src='${contextPath}/static/ace_admin1.3.1/assets/js/jquery.min.js'>"+"<"+"/script>");
</script>

<!-- <![endif]-->

<!--[if IE]>
<script type="text/javascript">
 window.jQuery || document.write("<script src='${contextPath}/static/ace_admin1.3.1/assets/js/jquery1x.min.js'>"+"<"+"/script>");
</script>
<![endif]-->
<script type="text/javascript" src="${contextPath}/static/jBox/jquery-migrate-1.1.1.js"></script>
<script type="text/javascript">
	if("ontouchend" in document) document.write("<script src='${contextPath}/static/ace_admin1.3.1/assets/js/jquery.mobile.custom.min.js'>"+"<"+"/script>");
</script>
<script src="${contextPath}/static/ace_admin1.3.1/assets/js/bootstrap.min.js"></script>

<c:if test="${fn:contains(inplugins,plugins.typeahead)||all}">
<script src="${contextPath}/static/ace_admin1.3.1/assets/js/typeahead.jquery.min.js"></script>
</c:if>

<!-- page specific plugin scripts -->
<!--[if lte IE 8]>
  <script src="${contextPath}/static/ace_admin1.3.1/assets/js/excanvas.min.js"></script>
<![endif]-->

<c:if test="${fn:contains(inplugins,plugins.jqui)||all}">
<script src="${contextPath}/static/ace_admin1.3.1/assets/js/jquery-ui.min.js"></script>
<script src="${contextPath}/static/ace_admin1.3.1/assets/js/jquery-ui.custom.min.js"></script>
<script src="${contextPath}/static/ace_admin1.3.1/assets/js/jquery.ui.touch-punch.min.js"></script>
</c:if>

<script src="${contextPath}/static/ace_admin1.3.1/assets/js/jquery.slimscroll.min.js"></script>

<c:if test="${fn:contains(inplugins,plugins.easypiechart)||all}">
<script src="${contextPath}/static/ace_admin1.3.1/assets/js/jquery.easy-pie-chart.min.js"></script>
</c:if>

<script src="${contextPath}/static/ace_admin1.3.1/assets/js/jquery.hotkeys.min.js"></script>

<c:if test="${fn:contains(inplugins,plugins.wysiwyg)||all}">
<script src="${contextPath}/static/ace_admin1.3.1/assets/js/bootstrap-wysiwyg.min.js"></script>
</c:if>

<c:if test="${fn:contains(inplugins,plugins.sparkline)||all}">
<script src="${contextPath}/static/ace_admin1.3.1/assets/js/jquery.sparkline.min.js"></script>
</c:if>

<c:if test="${fn:contains(inplugins,plugins.flot)||all}">
<script src="${contextPath}/static/ace_admin1.3.1/assets/js/flot/jquery.flot.min.js"></script>
<script src="${contextPath}/static/ace_admin1.3.1/assets/js/flot/jquery.flot.pie.min.js"></script>
<script src="${contextPath}/static/ace_admin1.3.1/assets/js/flot/jquery.flot.resize.min.js"></script>
</c:if>

<c:if test="${fn:contains(inplugins,plugins.dataTables)||all}">
<script src="${contextPath}/static/ace_admin1.3.1/assets/js/jquery.dataTables.min.js"></script>
<script src="${contextPath}/static/ace_admin1.3.1/assets/js/jquery.dataTables.bootstrap.js"></script>
</c:if>

<script src="${contextPath}/static/ace_admin1.3.1/assets/js/fuelux/fuelux.wizard.min.js"></script>
<script src="${contextPath}/static/ace_admin1.3.1/assets/js/fuelux/fuelux.spinner.min.js"></script>

<c:if test="${fn:contains(inplugins,plugins.validate)||all}">
<script src="${contextPath}/static/ace_admin1.3.1/assets/js/jquery.validate.min.js"></script>
<script src="${contextPath}/static/ace_admin1.3.1/assets/js/additional-methods.min.js"></script>
</c:if>

<script src="${contextPath}/static/ace_admin1.3.1/assets/js/jquery.gritter.min.js"></script>
<script src="${contextPath}/static/ace_admin1.3.1/assets/js/bootbox.min.js"></script>

<c:if test="${fn:contains(inplugins,plugins.select2)||all}">
<script src="${contextPath}/static/ace_admin1.3.1/assets/js/select2.min.js"></script>
<script src="${contextPath}/static/ace_admin1.3.1/assets/js/chosen.jquery.min.js"></script>
<script src="${contextPath}/static/ace_admin1.3.1/assets/js/bootstrap-tag.min.js"></script>
</c:if>

<c:if test="${fn:contains(inplugins,plugins.datetime)||all}">
<script src="${contextPath}/static/ace_admin1.3.1/assets/js/date-time/bootstrap-datepicker.min.js"></script>
<script src="${contextPath}/static/ace_admin1.3.1/assets/js/date-time/bootstrap-timepicker.min.js"></script>
<script src="${contextPath}/static/ace_admin1.3.1/assets/js/date-time/moment.min.js"></script>
<script src="${contextPath}/static/ace_admin1.3.1/assets/js/date-time/daterangepicker.min.js"></script>
<script src="${contextPath}/static/ace_admin1.3.1/assets/js/date-time/bootstrap-datetimepicker.min.js"></script>
</c:if>

<c:if test="${fn:contains(inplugins,plugins.fullcalendar)||all}">
<script src="${contextPath}/static/ace_admin1.3.1/assets/js/fullcalendar.min.js"></script>
</c:if>

<c:if test="${fn:contains(inplugins,plugins.colorpicker)||all}">
<script src="${contextPath}/static/ace_admin1.3.1/assets/js/bootstrap-colorpicker.min.js"></script>
</c:if>

<c:if test="${fn:contains(inplugins,plugins.knob)||all}">
<script src="${contextPath}/static/ace_admin1.3.1/assets/js/jquery.knob.min.js"></script>
</c:if>

<script src="${contextPath}/static/ace_admin1.3.1/assets/js/jquery.autosize.min.js"></script>
<script src="${contextPath}/static/ace_admin1.3.1/assets/js/jquery.inputlimiter.1.3.1.min.js"></script>

<c:if test="${fn:contains(inplugins,plugins.editable)||all}">
<script src="${contextPath}/static/ace_admin1.3.1/assets/js/x-editable/bootstrap-editable.min.js"></script>
<script src="${contextPath}/static/ace_admin1.3.1/assets/js/x-editable/ace-editable.min.js"></script>
</c:if>

<c:if test="${fn:contains(inplugins,plugins.maskedinput)||all}">
<script src="${contextPath}/static/ace_admin1.3.1/assets/js/jquery.maskedinput.min.js"></script>
</c:if>


<c:if test="${fn:contains(inplugins,plugins.jqgrid)||all}">
<script src="${contextPath}/static/ace_admin1.3.1/assets/js/jqGrid/jquery.jqGrid.min.js"></script>
<script src="${contextPath}/static/ace_admin1.3.1/assets/js/jqGrid/i18n/grid.locale-cn.js"></script>
</c:if>

<!-- page specific plugin scripts -->
<c:if test="${fn:contains(inplugins,plugins.dropzone)||all}">
<script src="${contextPath}/static/ace_admin1.3.1/assets/js/dropzone.min.js"></script>
</c:if>
<!-- ace scripts -->

<script src="${contextPath}/static/ace_admin1.3.1/assets/js/ace-elements.min.js"></script>
<script src="${contextPath}/static/ace_admin1.3.1/assets/js/ace.min.js"></script>

<c:if test="${fn:contains(inplugins,plugins.jbox)||all}">
<script type="text/javascript" src="${contextPath}/static/jBox/jquery.jBox-2.3.min.js"></script>
</c:if>

<c:if test="${fn:contains(inplugins,plugins.ztree)||all}">
<script src="${contextPath}/static/JQuery zTree v3.5.15/js/jquery.ztree.all-3.5.min.js"></script>
</c:if>

<c:if test="${fn:contains(inplugins,plugins.template)||all}">
<script src="${contextPath}/static/aui-artTemplate/dist/template.js"></script>
<script src="${contextPath}/static/common/js/template.js"></script>
</c:if>

<script src="${contextPath}/static/common/js/widget.js"></script>
<script src="${contextPath}/static/common/js/common.js"></script>
<script src="${contextPath}/static/common/js/lib.ui.menu.js"></script>
<c:if test="${fn:contains(inplugins,plugins.jqgrid)||all}">
<script src="${contextPath}/static/common/js/jqgrid.ext.js"></script>
</c:if>
<%-- <script src="${contextPath}/static/common/js/top.js"></script> --%>
<div style="display:none"></div>
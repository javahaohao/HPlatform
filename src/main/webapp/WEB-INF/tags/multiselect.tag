<%@ tag language="java" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/include/taglib.jsp"%>
<%@ attribute name="id" type="java.lang.String" required="true" description="控件ID"%>
<%@ attribute name="pk" type="java.lang.String" required="false" description="主键"%>
<%@ attribute name="excinclued" type="java.lang.String" required="false" description="排除元素"%>
<%@ attribute name="name" type="java.lang.String" required="false" description="显示字段"%>
<%@ attribute name="unselected" type="java.util.List" required="false" description="备选元素"%>
<%@ attribute name="selected" type="java.util.List" required="false" description="已元素"%>
<style type="text/css">
<!--
	.multiselect button{padding:0px;}
	.multiselect select[multiple]{height:200px;}
	.multiselect .col-xs-2{padding-top: 20px;}
-->
</style>
<div class="row multiselect">
    <div class="col-xs-5">
    	未选
        <select id="${id}" class="form-control" size="13" multiple="multiple">
        	<c:forEach var="un" items="${unselected}">
        		<c:if test="${!fn:contains(excinclued,un[pk])}">
        			<c:if test="${fn:length(selected)>0}">
	        			<c:forEach var="sel" items="${selected}" end="${exitId}">
		        			<c:if test="${sel[pk] ne un[pk]}">
		        				<option value="${un[pk]}">${un[name]}</option>
		        				<c:set var="exitId" value="0"></c:set>  
		        			</c:if>
		        		</c:forEach>
	        		</c:if>
	        		<c:if test="${fn:length(selected)<=0}">
	        			<option value="${un[pk]}">${un[name]}</option>
	        		</c:if>
        		</c:if>
        	</c:forEach>
        </select>
    </div>
    
    <div class="col-xs-2">
        <button type="button" id="undo_redo_undo" class="btn btn-primary btn-block">undo</button>
        <button type="button" id="undo_redo_rightAll" class="btn btn-default btn-block"><i class="glyphicon glyphicon-forward"></i></button>
        <button type="button" id="undo_redo_rightSelected" class="btn btn-default btn-block"><i class="glyphicon glyphicon-chevron-right"></i></button>
        <button type="button" id="undo_redo_leftSelected" class="btn btn-default btn-block"><i class="glyphicon glyphicon-chevron-left"></i></button>
        <button type="button" id="undo_redo_leftAll" class="btn btn-default btn-block"><i class="glyphicon glyphicon-backward"></i></button>
        <button type="button" id="undo_redo_redo" class="btn btn-warning btn-block">redo</button>
    </div>
    
    <div class="col-xs-5">
    	已选
        <select id="${id}_to" class="form-control" size="13" multiple="multiple">
        	<c:forEach var="sel" items="${selected}">
        		<c:if test="${!fn:contains(excinclued,sel[pk])}">
    				<option value="${sel[pk]}">${sel[name]}</option>
    			</c:if>
       		</c:forEach>
        </select>
    </div>
</div>
<script type="text/javascript" src="${contextPath}/static/multiselect-master/js/multiselect.min.js"></script>
<script type="text/javascript">
	$(function(){
		$('#${id}').multiselect();
	});
</script>
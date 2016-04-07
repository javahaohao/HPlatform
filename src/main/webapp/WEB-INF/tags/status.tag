<%@ tag language="java" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/include/taglib.jsp"%>
<%@ attribute name="id" type="java.lang.String" required="false" description="标签类型ID"%>
<%@ attribute name="title" type="java.lang.String" required="false" description="标签类型title"%>
<%@ attribute name="type" type="java.lang.String" required="false" description="标签类型样式"%>
<%@ attribute name="value" type="java.lang.String" required="true" description="标签判断标示"%>
<%@ attribute name="tlable" type="java.lang.String" required="true" description="true标签该显示的内容"%>
<%@ attribute name="flable" type="java.lang.String" required="true" description="false标签该显示的内容"%>
<%@ attribute name="nullable" type="java.lang.String" required="true" description="null标签该显示的内容"%>
<c:choose>
	<c:when test="${type eq 'top'}">
		<c:choose>
			<c:when test="${value}">
				<span class="label label-yellow" id="${id}" title="${title}" mark="${value}">
					<i class="ace-icon fa fa-heart red bigger-120"></i>
					${tlable}
				</span>
			</c:when>
			<c:when test="${!value}">
				<span class="label label-grey" id="${id}" title="${title}" mark="${value}">
					<i class="ace-icon fa fa-heart red bigger-120"></i>
					${flable}
				</span>
			</c:when>
			<c:otherwise>
				<span class="label label-grey" id="${id}" title="${title}" mark="${value}">
					<i class="ace-icon fa fa-heart bigger-120"></i>
					${nullable}
				</span>
			</c:otherwise>
		</c:choose>
	</c:when>
	<c:when test="${type eq 'hots'}">
		<c:choose>
			<c:when test="${value}">
				<span class="label label-pink" id="${id}" title="${title}" mark="${value}">
					<i class="ace-icon fa fa-star orange2 bigger-120"></i>
					${tlable}
				</span>
			</c:when>
			<c:when test="${!value}">
				<span class="label label-grey" id="${id}" title="${title}" mark="${value}">
					<i class="ace-icon fa fa-star orange2 bigger-120"></i>
					${flable}
				</span>
			</c:when>
			<c:otherwise>
				<span class="label label-grey" id="${id}" title="${title}" mark="${value}">
					<i class="ace-icon fa fa-star bigger-120"></i>
					${nullable}
				</span>
			</c:otherwise>
		</c:choose>
	</c:when>
	<c:otherwise>
		<c:choose>
			<c:when test="${value}">
				<span class="label label-success" id="${id}" title="${title}" mark="${value}">
					<i class="ace-icon fa fa-check-circle"></i>
					${tlable}
				</span>
			</c:when>
			<c:when test="${!value}">
				<span class="label label-warning" id="${id}" title="${title}" mark="${value}">
					<i class="ace-icon fa fa-times-circle"></i>
					${flable}
				</span>
			</c:when>
			<c:otherwise>
				<span class="label label-grey" id="${id}" title="${title}" mark="${value}">
					<i class="ace-icon fa fa-warning bigger-120"></i>
					${nullable}
				</span>
			</c:otherwise>
		</c:choose>
	</c:otherwise>
</c:choose>
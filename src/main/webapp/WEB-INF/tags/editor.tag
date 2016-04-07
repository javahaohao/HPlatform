<%@ tag language="java" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/include/taglib.jsp"%>
<%@ attribute name="id" type="java.lang.String" required="false" description="标签类型ID"%>
<%@ attribute name="name" type="java.lang.String" required="true" description="标签name"%>
<%@ attribute name="value" type="java.lang.String" required="false" description="标签value"%>
<%@ attribute name="formId" type="java.lang.String" required="false" description="form的id"%>
<div class="wysiwyg-editor" id="${id}">${value}</div>
<input type="hidden" name="${name}" id="${name}"/>
<script type="text/javascript">
	$(function () {
		$('#${formId}').on('submit', function() {
			  var hidden_input =$('#${name}');
	
			  var html_content = $('#${id}').html();
			  hidden_input.val( html_content );
			  //put the editor's HTML into hidden_input and it will be sent to server
			});
		$('#${id}').ace_wysiwyg();
	});
</script>

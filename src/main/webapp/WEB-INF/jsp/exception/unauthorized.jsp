<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/WEB-INF/include/taglib.jsp"%>
<html>
<head>
	<tags:header inplugins="normal" title="没有权限"></tags:header>
	<style>.error{color:red;}body{background-color: white;}</style>
</head>
<body>
	<div class="container-fluid">
		<div class="row">
			<div class="col-md-12 col-sm-12">
				<div class="col-md-3 col-sm-3"></div>
				<div class="col-md-6 col-sm-6">
					<img width="500" src="${contextPath}/static/common/img/unauthorized.jpg" alt="页面丢了" class="img-rounded">
				</div>
				<div class="col-md-3 col-sm-3"></div>
			</div>
		</div>
		<div class="row">
			<div class="col-md-12 col-sm-12">
				<div class="col-md-3 col-sm-3"></div>
				<div class="col-md-6 col-sm-6 font-center">
					<div class="error">您没有权限访问:[${exception.message}]<br/>页面将在<mark id="mark">10</mark>秒后跳转...</div>
				</div>
				<div class="col-md-3 col-sm-3"></div>
			</div>
		</div>
	</div>
	<script type="text/javascript">
		var intervalCode = setInterval(function(){
			if(time--==0){
				clearInterval(intervalCode);
				window.history.back(-1);
			}else
				$('#mark').text(time);
		},1000),time=10;
	</script>
</body>
</html>
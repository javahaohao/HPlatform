<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/WEB-INF/include/taglib.jsp"%>
<html>
<head>
	<tags:header inplugins="normal" title="页面跳转"></tags:header>
	<style>body{background-color: white;}</style>
</head>
<body>
	<div class="container-fluid">
		<div class="row">
			<div class="col-md-12 col-sm-12">
				<div class="col-md-3 col-sm-3"></div>
				<div class="col-md-6 col-sm-6">
					<img src="${contextPath}/static/common/img/404_500.png" alt="页面丢了" class="img-rounded">
				</div>
				<div class="col-md-3 col-sm-3"></div>
			</div>
		</div>
		<div class="row">
			<div class="col-md-12 col-sm-12">
				<div class="col-md-5 col-sm-5"></div>
				<div class="col-md-2 col-sm-2 font-center">
					页面将在<mark id="mark">10</mark>秒后跳转...
				</div>
				<div class="col-md-5 col-sm-5"></div>
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
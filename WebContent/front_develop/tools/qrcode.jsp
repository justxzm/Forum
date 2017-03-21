<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="db.ConnDb"%>
<%@ page import="java.sql.ResultSet"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	String url=new String(request.getParameter("url").getBytes("iso-8859-1"),"utf-8");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="shortcut icon" href="<%=basePath %>headImages/favicon.ico" type="image/x-icon"/>
<title>Try.Catch</title>
<link href="<%=basePath%>css/bootstrap.min.css" rel="stylesheet">

<!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
<!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
<!--[if lt IE 9]>
    <script src="http://cdn.bootcss.com/html5shiv/3.7.2/html5shiv.min.js"></script>
    <script src="http://cdn.bootcss.com/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
<script type="text/javascript" src="<%=basePath%>front_develop/tools/javascript/jquery.min.js"></script>
<script type="text/javascript" src="<%=basePath%>front_develop/tools/javascript/jquery.qrcode.min.js"></script>
</head>
<body>

	<article class="container" style="margin-top: 66px">
	<div class="row">
		<div class="col-md-9">
			<div class="alert alert-info alert-dismissible" role="alert">
				<button type="button" class="close" data-dismiss="alert">
					<span aria-hidden="true">&times;</span><span class="sr-only">Close</span>
				</button>
				<strong>欢迎使用二维码生成工具,格式如  (http://www.justxzm.cn)</strong>
			</div>
			<div class="input-group">
				<input type="text" class="form-control" id="codeUrl"
					placeholder="输入网址   |   文字内容"> <span
					class="input-group-btn">
					<button class="btn btn-default" onclick="createCode()">生成</button>
				</span>
			</div>
				<%
				if(url.equals("null")){
				
				}else{
					%>
					<div id="qrcode" class="well"></div>
					<%
				}
			%>
			<script type="text/javascript">
			var url;
			function createCode() {
				var urlGet = document.getElementById('codeUrl');
				var url2=urlGet.value;
				window.location.href='qrcode.jsp?url='+url2;
			}
			$('#qrcode').qrcode({
				text :"<%=url%>",
				width : 310,
				height : 310
			});
			</script>
		</div>
		<div class="col-md-3">
			<jsp:include page="../rightPart.jsp"></jsp:include>
		</div>
	</article>
	<jsp:include page="../header.jsp"></jsp:include>
	<footer class="container">
	<hr class="divider" />
	<p class="pull-right">
		<a href="#top">回到顶部</a>
	</p>

	<p class="foot">
		<a href="http://www.miitbeian.gov.cn" target="_blank">苏ICP备16050234号</a>
		Copyright © 2016-2026 All Rights Reserved
	</p>
	</footer>
	<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
	<script src="https://cdn.bootcss.com/jquery/1.11.1/jquery.min.js"></script>
	<!-- Include all compiled plugins (below), or include individual files as needed -->
	<script src="<%=basePath%>javascript/bootstrap.min.js"></script>
</body>
</html>
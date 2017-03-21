<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="db.ConnDb"%>
<%@ page import="java.sql.ResultSet"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
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
<script type="text/javascript" src="<%=basePath%>/front_develop/tools/javascript/jquery.min.js"></script>
<script type="text/javascript" src="<%=basePath%>/front_develop/tools/javascript/jquery.qrcode.min.js"></script>
</head>
<body>
	<jsp:include page="../header.jsp"></jsp:include>

	<article class="container" style="margin-top: 66px">
	<div class="row">
		<div class="col-md-9">
			<div class="alert alert-info alert-dismissible" role="alert">
				<button type="button" class="close" data-dismiss="alert">
					<span aria-hidden="true">&times;</span><span class="sr-only">Close</span>
				</button>
				<strong>欢迎使用图片加水印工具</strong> (只支持png/jpg/jpeg格式的图片且水印暂不支持中文)
			</div>
			<form action="${pageContext.request.contextPath}/watermark.just"
				method="post" enctype="multipart/form-data">
				<input type="file" name="image" required /><br>
				<input type="color" name="markColor" /> 默认颜色为黑<br>
				<br>
				<div class="container-fluid">
					<div class="row">
						<div class="col-md-6">
							<div class="form-group">
								<label for="inputEmail3" class="col-md-4 control-label" style="line-height:35px">水印文本:</label>
								<div class="col-md-8">
									<input type="text" class="form-control" id="inputEmail3"
										name="markContent" placeholder="（必填）" required="required">
								</div>
							</div>
						</div>
						<div class="col-md-6">
							<div class="form-group">
								<label for="inputEmail3" class="col-md-4 control-label" style="line-height:35px">文本大小:</label>
								<div class="col-md-8">
									<input type="number" min="1" max="200" value="100"
										class="form-control" id="inputEmail3" name="markSize"
										placeholder="（默认100）">
								</div>
							</div>
						</div>
					</div>
				</div><br>
				<button type="submit" class="btn btn-primary">上传图片</button>
			</form>

			<%
				String url = new String(request.getParameter("url").getBytes("iso-8859-1"), "utf-8");
				String oldUrl = new String(request.getParameter("oldUrl").getBytes("iso-8859-1"), "utf-8");
				String newUrl = new String(request.getParameter("newUrl").getBytes("iso-8859-1"), "utf-8");
				oldUrl = basePath.substring(0, basePath.length() - 1) + oldUrl;
				newUrl = basePath.substring(0, basePath.length() - 1) + newUrl;
				if (url.equals("null")) {

				} else {
			%>
			<div class="well">
				<table class="table table-hover table-striped" align="center">
					<thead>
						<tr>
							<th>原图片</th>
							<th>生成图</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td width="50%"><img src="<%=oldUrl%>" width="100%"
								alt="请选择正确格式的图片" /></td>
							<td width="50%"><img src="<%=newUrl%>" width="100%"
								alt="请选择正确格式的图片" /></td>
						</tr>
					</tbody>
				</table>
			</div>
			<%
				}
			%>

		</div>
		<div class="col-md-3">
			<jsp:include page="../rightPart.jsp"></jsp:include>
		</div>
	</article>

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
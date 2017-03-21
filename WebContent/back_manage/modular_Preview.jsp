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
<title></title>
<link href="../css/bootstrap.min.css" rel="stylesheet">
<!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
<!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
<!--[if lt IE 9]>
    <script src="http://cdn.bootcss.com/html5shiv/3.7.2/html5shiv.min.js"></script>
    <script src="http://cdn.bootcss.com/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
<script type="text/javascript"
	src="<%=basePath%>front_develop/tools/javascript/jquery.min.js"></script>
<script type="text/javascript"
	src="<%=basePath%>front_develop/tools/javascript/jquery.qrcode.min.js"></script>
	<script type="text/javascript">
		function goback(){
			document.location="modular_Manage.jsp";
		}
	</script>
</head>
<body style="margin-top: 10px">
	<div class="container" style="width: 66%">
		<div class="alert alert-warning alert-dismissible" role="alert">
			<button type="button" class="close" data-dismiss="alert">
				<span aria-hidden="true">&times;</span><span class="sr-only">Close</span>
			</button>
			<strong>板块信息预览</strong>
		</div>
		<%
			ConnDb con = new ConnDb();
			String id=new String(request.getParameter("id").getBytes("iso-8859-1"),"utf-8");
			ResultSet rs = con.getSelect("select * from modular where id='" + id + "'");
			if (rs.next()) {
		%>
		<div class="media">
			<a class="media-left"> <img
				src="../headImages/<%=rs.getString("briefImage")%>"
				style="height: 80px; width: 80px; border: 1px solid black; border-radius: 5px;">
			</a>
		</div>
		<br>
		<form class="form-horizontal" role="form"
			action=""
			method="post">
			<div class="form-group">

				<label for="inputEmail3" class="col-md-1 control-label">ModularName</label>
				<div class="col-md-1"></div>
				<div class="col-md-10">
					<input type="text" class="form-control" id="inputEmail3"
						name="userName" value="<%=rs.getString("modularName")%>" disabled
						placeholder="UserName">
				</div>
			</div>
			<div class="form-group">
				<label for="inputEmail3" class="col-md-1 control-label">BriefInfo</label>
				<div class="col-md-1"></div>
				<div class="col-md-10">
					<input type="text" class="form-control" id="inputEmail3"
						name="text" value="<%=rs.getString("briefInfo")%>" disabled
						placeholder="Password">
				</div>
			</div>
			<div class="form-group">
				<label for="inputPassword3" class="col-md-1 control-label">Creator</label>
				<div class="col-md-1"></div>
				<div class="col-md-10">
					<input type="text" class="form-control" id="inputPassword3"
						name="email" value="<%=rs.getString("creator")%>" disabled
						placeholder="Email">
				</div>
			</div>
			<div class="form-group">
				<div class="col-md-2"></div>
				<div class="col-md-10">
					<button type="button" class="btn btn-primary" onclick="goback()">返回</button>
				</div>
			</div>
		</form>
		<%
			}
			rs.close();
			con.closeAll();
		%>
	</div>
	<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
	<script src="https://cdn.bootcss.com/jquery/1.11.1/jquery.min.js"></script>
	<!-- Include all compiled plugins (below), or include individual files as needed -->
	<script src="../javascript/bootstrap.min.js"></script>
</body>
</html>
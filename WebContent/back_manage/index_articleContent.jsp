<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="db.ConnDb"%>
<%@ page import="java.sql.ResultSet"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Try.Catch</title>
<link href="../css/bootstrap.min.css" rel="stylesheet">

<!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
<!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
<!--[if lt IE 9]>
    <script src="http://cdn.bootcss.com/html5shiv/3.7.2/html5shiv.min.js"></script>
    <script src="http://cdn.bootcss.com/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
    <script type="text/javascript">
    	function returnIndex(){
    		document.location = 'index_articleList.jsp'
    	}
    </script>
</head>
<body>
	<article class="container" style="margin-top: 66px">
	<div class="alert alert-info alert-dismissible" role="alert">
				<button type="button" class="close" data-dismiss="alert">
					<span aria-hidden="true">&times;</span><span class="sr-only">Close</span>
				</button>
				<strong>个人中心
				</strong> 
			</div>
	<div class="media">
		<%
			String username = request.getSession().getAttribute("username").toString();
			ConnDb con = new ConnDb();
			ResultSet rs = con.getSelect("select * from admin where userName='" + username + "'");
			if (rs.next()) {
		%>

		<a class="media-left"> <img
			src="../headImages/<%=rs.getString("imageName")%>"
			style="height: 80px; width: 80px; border: 1px solid black; border-radius: 5px;">
		</a>
		<div class="media-body">
			<h4 class="media-heading" style="margin-left: 25px">
				用户名：<a style="text-decoration: none; color: #000000"
							href="index_articleList.jsp"><%=rs.getString("userName")%></a></h4>
			<%
				if (username.equals(request.getSession().getAttribute("username")) == false) {
			%>
			<button class="btn btn-info" style="margin-left: 25px">关注</button>
			<%
				}
			%>
		</div>
		<%
			}
		%>
	</div>
	<div class="panel panel-default">
		<%
			String id = new String(request.getParameter("id").getBytes("iso-8859-1"), "utf-8");

			rs = con.getSelect("select * from article where id='" + id + "'");
			if (rs.next()) {
		%>
		<div class="panel-heading" style="word-wrap: break-word;">
			<center>
				<strong><%=rs.getString("title")%></strong>
			</center>
		</div>
		<div class="panel-body">
			<%=rs.getString("content")%>
		</div>
		<%
			}
			rs.close();
			con.closeAll();
		%>
	</div>
	<button class="btn btn-primary" onclick="returnIndex()">返回</button>
	</article>

	<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
	<script src="https://cdn.bootcss.com/jquery/1.11.1/jquery.min.js"></script>
	<!-- Include all compiled plugins (below), or include individual files as needed -->
	<script src="../javascript/bootstrap.min.js"></script>
</body>
</html>
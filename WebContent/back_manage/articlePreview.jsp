<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="db.ConnDb"%>
<%@ page import="java.sql.ResultSet"%>
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
    <script type="text/javascript">
    	function goBack(){
    		document.location = 'articleList_Manage.jsp'
    	}
    </script>
</head>
<body style="margin-top: 10px">

	<div class="container">
		<div class="alert alert-info alert-dismissible" role="alert">
			<button type="button" class="close" data-dismiss="alert">
				<span aria-hidden="true">&times;</span><span class="sr-only">Close</span>
			</button>

			<strong>文章预览</strong>
		</div>

		<div class="panel panel-default">
			<%
				String id = request.getParameter("id");
				ConnDb con = new ConnDb();
				ResultSet rs = con.getSelect("select * from article where id='" + id + "'");
				if (rs.next()) {
			%>
			<div class="panel-heading">
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
		<button type="button" class="btn btn-primary" onclick="goBack()">返回</button>
	</div>

	<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
	<script src="https://cdn.bootcss.com/jquery/1.11.1/jquery.min.js"></script>
	<!-- Include all compiled plugins (below), or include individual files as needed -->
	<script src="../javascript/bootstrap.min.js"></script>
</body>
</html>
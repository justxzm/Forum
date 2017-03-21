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
				String username=request.getSession().getAttribute("username").toString();
				ConnDb con=new ConnDb();
				ResultSet rs=con.getSelect("select * from admin where userName='"+username+"'");
				if(rs.next()){
					%>
			
			<a class="media-left" href="index_articleList.jsp">
			<img src="../headImages/<%=rs.getString("imageName")%>"
				style="height: 80px; width: 80px; border: 1px solid black; border-radius: 5px;"> </a>
			<div class="media-body">
				<h4 class="media-heading" style="margin-left: 25px"> 用户名：<a style="text-decoration: none; color: #000000"
							href="index_articleList.jsp"><%=rs.getString("userName") %></a></h4>
				<%
					if(username.equals(request.getSession().getAttribute("username"))==false){
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
			<table class="table table-hover table-striped">
				<thead>
					<tr>
						<th>文章名</th>
						<th>作者</th>
						<th>所属板块</th>
						<th>日期</th>
					</tr>
				</thead>
				<tbody>
					<%
						rs = con.getSelect("select * from article where author='"+username+"' order by newDate desc");
						int mark=0;
					while (rs.next()) {
						mark++;
					%>
					<tr>
						<td><a style="text-decoration: none; color: #000000"
							href="index_articleContent.jsp?id=<%=rs.getInt("id")%>&&username=<%=username%>"><%=rs.getString("title")%></a></td>
						<td><a style="text-decoration: none; color: #000000"
							href="index_articleList.jsp"><%=rs.getString("author")%></a></td>
						<td><%=rs.getString("modularName")%></td>
						<td><%=rs.getString("newDate")%></td>
					</tr>
					<%
						}
					rs.close();
						con.closeAll();
						if(mark==0){
							%>
							<td><a href="#" style="text-decoration: none;color:#000000">暂无</a></td>
							<td><a href="#" style="text-decoration: none;color:#000000">暂无</a></td>
							<td><a href="#" style="text-decoration: none;color:#000000">暂无</a></td>
							<td><a href="#" style="text-decoration: none;color:#000000">暂无</a></td>
							<%
						}
					%>
				</tbody>

			</table>
	</article>


	<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
	<script src="https://cdn.bootcss.com/jquery/1.11.1/jquery.min.js"></script>
	<!-- Include all compiled plugins (below), or include individual files as needed -->
	<script src="../javascript/bootstrap.min.js"></script>
</body>
</html>
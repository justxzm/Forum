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
	function modularAdd() {
		window.location.href = "modular_Create.jsp";
	}
</script>
</head>
<body style="margin-top: 10px">

	<div class="container">
		<div class="alert alert-warning alert-dismissible" role="alert">
			<button type="button" class="close" data-dismiss="alert">
				<span aria-hidden="true">&times;</span><span class="sr-only">Close</span>
			</button>
			<strong>板块管理</strong>：发表1篇文章，并且文章总赞数不为0的用户才有权限
		</div>
		<table class="table table-hover table-striped">
			<thead>
				<tr>
					<th>板块名</th>
					<th>简介</th>
					<th>创建者</th>
					<th>操作</th>
				</tr>
			</thead>
			<tbody>
				<%
					String username = request.getSession().getAttribute("username").toString();
					ConnDb con = new ConnDb();
					ResultSet rs=null;
					if(username.equals("root")){
						rs = con.getSelect("select * from modular");
					}else{
						rs = con.getSelect("select * from modular where creator='" + username + "'");
					} 
					int mark = 0;
					while (rs.next()) {
						mark++;
				%>
				<tr>
					<td><%=rs.getString("modularName")%></td>
					<td><%=rs.getString("briefInfo")%></td>
					<td><%=rs.getString("creator")%></td>
					<td>
						<!-- Single button -->
						<div class="btn-group">
							<button type="button" class="btn btn-primary dropdown-toggle"
								data-toggle="dropdown">
								Manage <span class="caret"></span>
							</button>
							<ul class="dropdown-menu" role="menu">
								<li><a href="modular_Preview.jsp?id=<%=rs.getInt("id")%>">板块预览</a></li>
								<li><a href="modular_Edit.jsp?id=<%=rs.getInt("id")%>">板块编辑</a></li>
								<li><a
									href="modular_ArticleList.jsp?id=<%=rs.getInt("id")%>">板块文章</a></li>
								<li><a href="../modularDel?id=<%=rs.getInt("id")%>">板块删除</a></li>
							</ul>
						</div>

					</td>

				</tr>
				<%
					}
					if (mark == 0) {
				%>
				<tr>
				<td><a href="#" style="text-decoration: none; color: #000000">暂无</a></td>
				<td><a href="#" style="text-decoration: none; color: #000000">暂无</a></td>
				<td><a href="#" style="text-decoration: none; color: #000000">暂无</a></td>
				<td><a href="#" style="text-decoration: none; color: #000000">暂无</a></td>
				</tr>
				<%
					}
				%>
			</tbody>

		</table>
		<%				
			if(con.ifhaspower(username)!=0){			
		%>
		<button type="button" class="btn btn-primary" onclick="modularAdd()">创建板块</button>
		<%
			}else{
		%>
		<button type="button" class="btn btn-primary" onclick="modularAdd()" disabled>创建板块</button>
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
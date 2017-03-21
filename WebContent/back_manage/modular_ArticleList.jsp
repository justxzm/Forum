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
    	function goModularManage(){
    		document.location = 'modular_Manage.jsp'
    	}
    </script>
</head>
<body style="margin-top: 10px">

	<div class="container">
		<div class="alert alert-warning alert-dismissible" role="alert">
			<button type="button" class="close" data-dismiss="alert">
				<span aria-hidden="true">&times;</span><span class="sr-only">Close</span>
			</button>
			<strong>板块文章管理</strong>
		</div>
		<table class="table table-hover table-striped">
			<thead>
				<tr>
					<th>文章名</th>
					<th>作者</th>
					<th>所属板块</th>
					<th>日期</th>		
					<th>操作</th>
				</tr>
			</thead>
			<tbody>
				<%
					String id=new String(request.getParameter("id").getBytes("iso-8859-1"),"utf-8");
					ConnDb con = new ConnDb();
					ResultSet rs = con.getSelect("select * from modular where id='"+id+"'");
					rs.next();
					String modularName=rs.getString("modularName");
					rs=con.getSelect("select * from article where modularName='"+modularName+"'");
					int mark=0;
					while (rs.next()) {
						mark++;
				%>
				<tr>
					<td><%=rs.getString("title")%></td>
					<td><%=rs.getString("author")%></td>
					<td><%=rs.getString("modularName")%></td>
					<td><%=rs.getString("newDate")%></td>
					<td>
						<!-- Single button -->
						<div class="btn-group">
							<button type="button" class="btn btn-primary dropdown-toggle"
								data-toggle="dropdown">
								Manage <span class="caret"></span>
							</button>
							<ul class="dropdown-menu" role="menu">
								<li><a href="modular_ArticlePreview.jsp?id=<%=rs.getInt("id")%>">文章预览</a></li>
								<li><a href="modular_CommentList.jsp?id=<%=rs.getInt("id")%>">文章评论</a></li>
								<li><a href="../articleDel?id=<%=rs.getInt("id")%>&mark=2&modularId=<%=id%>">文章删除</a></li>
							</ul>
						</div>

					</td>

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
						<td><a href="#" style="text-decoration: none;color:#000000">暂无</a></td>
						<%
					}
				%>
			</tbody>

		</table>
		<button type="button" class="btn btn-primary" onclick="goModularManage()">返回</button>
	</div>

	<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
	<script src="https://cdn.bootcss.com/jquery/1.11.1/jquery.min.js"></script>
	<!-- Include all compiled plugins (below), or include individual files as needed -->
	<script src="../javascript/bootstrap.min.js"></script>
</body>
</html>
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
<link href="<%=basePath%>css/bootstrap.min.css" rel="stylesheet">

<!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
<!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
<!--[if lt IE 9]>
    <script src="http://cdn.bootcss.com/html5shiv/3.7.2/html5shiv.min.js"></script>
    <script src="http://cdn.bootcss.com/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
<script type="text/javascript"
	src="<%=basePath%>front_develop/tools/javascript/jquery.min.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		$("#tools_menu").click(function() {
			$("#tools").slideToggle("slow");
		});
	});
</script>
</head>
<body>
	<div class="panel panel-warning">
		<!-- Default panel contents -->
		<div class="panel-heading" id="tools_menu">小工具</div>
		<!-- List group -->
		<ul class="list-group" id="tools" style="display: none;">
			<li class="list-group-item"><a
				style="text-decoration: none; color: #000000;"
				href="<%=basePath%>front_develop/tools/qrcode.jsp?url=null">二维码生成</a></li>
			<li class="list-group-item"><a
				style="text-decoration: none; color: #000000;"
				href="<%=basePath%>front_develop/tools/watermark.jsp?url=null&oldUrl=null&newUrl=null">图片加水印</a></li>
			<li class="list-group-item"><a style="text-decoration: none; color: #000000;" href="#">待开发...</a></li>
			<li class="list-group-item"><a style="text-decoration: none; color: #000000;" href="#">待开发...</a></li>
			<li class="list-group-item"><a style="text-decoration: none; color: #000000;" href="#">待开发...</a></li>
		</ul>
	</div>
	<div class="panel panel-warning">
		<div class="panel-heading">关注的人</div>
		<div class="panel-body">
			<%
				ConnDb con = new ConnDb();
				ResultSet rs = null;
				String username = null;
				if (request.getSession().getAttribute("username") == null) {
			%>
			<div
				style="overflow: hidden; text-overflow: ellipsis; -o-text-overflow: ellipsis; white-space: nowrap;">
				<a style="text-decoration: none; color: #000000;" href="#"
					data-toggle="modal" data-target="#loginModal">请先登录</a>
			</div>
			<%
				} else {
					username = request.getSession().getAttribute("username").toString();
					rs = con.getSelect("select * from friend where ownName='" + username + "'");
					if (rs.next()) {
			%>
			<a
				href="<%=basePath%>front_develop/articleList.jsp?username=<%=rs.getString("friendName")%>"
				style="text-decoration: none"> <span class="label label-info"><%=rs.getString("friendName")%></span>
			</a>
			<%
				while (rs.next()) {
			%>
			<a
				href="<%=basePath%>front_develop/articleList.jsp?username=<%=rs.getString("friendName")%>"
				style="text-decoration: none"> <span class="label label-info"><%=rs.getString("friendName")%></span>
			</a>
			<%
				}
					} else {
			%>
			<div
				style="overflow: hidden; text-overflow: ellipsis; -o-text-overflow: ellipsis; white-space: nowrap;">
				<a style="text-decoration: none; color: #000000;" href="#">暂无关注</a>
			</div>
			<%
				}
				}
			%>
		</div>
	</div>

	<div class="panel panel-warning">
		<div class="panel-heading">关注的板块</div>
		<div class="panel-body">
			<%
				if (request.getSession().getAttribute("username") == null) {
			%>
			<div
				style="overflow: hidden; text-overflow: ellipsis; -o-text-overflow: ellipsis; white-space: nowrap;">
				<a style="text-decoration: none; color: #000000;" href="#"
					data-toggle="modal" data-target="#loginModal">请先登录</a>
			</div>
			<%
				} else {
					username = request.getSession().getAttribute("username").toString();
					rs = con.getSelect("select * from hobby where ownName='" + username + "'");
					
					int mark = 0;
					while (rs.next()) {
						mark++;
						String modularName = rs.getString("modularName");
						ResultSet rs2 = con.getSelect("select * from modular where modularName='" + modularName + "'");
						if (rs2.next()) {
			%>
			<a
				href="<%=basePath%>front_develop/modular_articleList.jsp?id=<%=rs2.getString("id")%>"
				style="text-decoration: none"> <span class="label label-info"><%=modularName%></span>
			</a>
			<%
				}
						rs2.close();
					}
					

					if (mark == 0) {
			%>
			<div
				style="overflow: hidden; text-overflow: ellipsis; -o-text-overflow: ellipsis; white-space: nowrap;">
				<a style="text-decoration: none; color: #000000;" href="#">暂无关注</a>
			</div>
			<%
				}
				}
			%>
		</div>
	</div>

	<div class="panel panel-warning">
		<!-- Default panel contents -->
		<div class="panel-heading" id="">最新评论</div>
		<!-- List group -->
		<ul class="list-group" id="">
			<%
				if (request.getSession().getAttribute("username") == null) {
			%>
			<li class="list-group-item"
				style="overflow: hidden; text-overflow: ellipsis; -o-text-overflow: ellipsis; white-space: nowrap;">
				<a style="text-decoration: none; color: #000000;" href="#"
				data-toggle="modal" data-target="#loginModal">请先登录</a>
			</li>

			<%
				} else {
					username = request.getSession().getAttribute("username").toString();
					rs = con.getSelect("select * from comment order by date desc");
					int mark2 = 0;
					int mark3 = 0;
					while (rs.next()) {				
						String articleId = rs.getString("articleId");
						ResultSet rs3 = con.getSelect(
								"select * from article where id='" + articleId + "' and author='" + username + "'");
						if (rs3.next()) {
							mark2++;
							mark3++;
			%>
			<li class="list-group-item"
				style="overflow: hidden; text-overflow: ellipsis; -o-text-overflow: ellipsis; white-space: nowrap;">
				<a style="text-decoration: none; color: #000000;"
				href="<%=basePath%>front_develop/articleContent.jsp?id=<%=articleId%>&&username=<%=rs3.getString("author")%>"><%=rs.getString("content")%></a>
			</li>

			<%
						}
						rs3.close();
						if (mark3 == 5) {
							break;
						}
					}
					if(mark2==0){
						%>
						<li class="list-group-item"
				style="overflow: hidden; text-overflow: ellipsis; -o-text-overflow: ellipsis; white-space: nowrap;">
				<a style="text-decoration: none; color: #000000;" href="#">暂无评论</a>
			</li>
						<%
					}
				}
			%>
		</ul>
	</div>

	<div class="panel panel-warning">

		<div class="panel-heading">推荐排行榜</div>
		<ul class="list-group" id="">		
			<%
				rs=con.getSelect("select * from article order by newDate desc");
				int mark4=0;
				int mark5=0;
				while(rs.next()){
					String id=rs.getInt("id")+"";
					ResultSet rs4=con.getSelect("select * from article where id='"+id+"'");
					rs4.next();
					int praiseNumber=rs4.getInt("praiseNumber");
					int critiNumber=rs4.getInt("criticizeNumber");
					if((praiseNumber-critiNumber)>0){
						mark4++;
						mark5++;
						%>
						<li class="list-group-item"
							style="overflow: hidden; text-overflow: ellipsis; -o-text-overflow: ellipsis; white-space: nowrap;">
				<a style="text-decoration: none; color: #000000;"
					href="<%=basePath%>front_develop/articleContent.jsp?id=<%=id%>&&username=<%=rs.getString("author")%>"><%=rs.getString("title")%></a>
			</li>
						<%
					}
					rs4.close();
					if(mark5==5){
						break;
					}
				}
				if(mark4==0){
					%>
					<li class="list-group-item"
				style="overflow: hidden; text-overflow: ellipsis; -o-text-overflow: ellipsis; white-space: nowrap;">
				<a style="text-decoration: none; color: #000000;" href="#">暂无博客</a>
			</li>
					<%
				}
			%>
		</ul>
		<%
			rs.close();
			con.closeAll();
		%>
	</div>
	<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
	<script src="https://cdn.bootcss.com/jquery/1.11.1/jquery.min.js"></script>
	<!-- Include all compiled plugins (below), or include individual files as needed -->
	<script src="<%=basePath%>javascript/bootstrap.min.js"></script>
</body>
</html>
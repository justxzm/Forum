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
<link href="../css/bootstrap.min.css" rel="stylesheet">

<!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
<!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
<!--[if lt IE 9]>
    <script src="http://cdn.bootcss.com/html5shiv/3.7.2/html5shiv.min.js"></script>
    <script src="http://cdn.bootcss.com/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
</head>
<body>

	<jsp:include page="header.jsp"></jsp:include>
	<article class="container" style="margin-top: 66px">
	<div class="row">
		<div class="col-md-9">
			<div class="row">
				<%
					ConnDb con = new ConnDb();
					ResultSet rs = con.getSelect("select * from modular");
					while (rs.next()) {
				%>
				<div class="col-sm-6 col-md-4">
					<div class="thumbnail">
						<a href="modular_articleList.jsp?id=<%=rs.getString("id")%>"><img src="../headImages/<%=rs.getString("briefImage")%>" alt="..."></a>
						<div class="caption">
							<h3><a href="modular_articleList.jsp?id=<%=rs.getString("id")%>" style="text-decoration: none;color:#000000"><%=rs.getString("modularName")%></a></h3>
							<p><%=rs.getString("briefInfo")%></p>
							<p>
							<a href="modular_articleList.jsp?id=<%=rs.getString("id")%>" class="btn btn-primary" role="button">进入</a>
							</p>
						</div>
					</div>
				</div>
				<%
					if (rs.next()) {
				%>
			<div class="col-sm-6 col-md-4">
					<div class="thumbnail">
						<a href="modular_articleList.jsp?id=<%=rs.getString("id")%>"><img src="../headImages/<%=rs.getString("briefImage")%>" alt="..."></a>
						<div class="caption">
							<h3><a href="modular_articleList.jsp?id=<%=rs.getString("id")%>" style="text-decoration: none;color:#000000"><%=rs.getString("modularName")%></a></h3>
							<p><%=rs.getString("briefInfo")%></p>
							<p>
							<a href="modular_articleList.jsp?id=<%=rs.getString("id")%>>" class="btn btn-primary" role="button">进入</a>
							</p>
						</div>
					</div>
				</div>
				<%
					}
				%>
				<%
					if (rs.next()) {
				%>
		<div class="col-sm-6 col-md-4">
					<div class="thumbnail">
						<a href="modular_articleList.jsp?id=<%=rs.getString("id")%>"><img src="../headImages/<%=rs.getString("briefImage")%>" alt="..."></a>
						<div class="caption">
							<h3><a href="modular_articleList.jsp?id=<%=rs.getString("id")%>" style="text-decoration: none;color:#000000"><%=rs.getString("modularName")%></a></h3>
							<p><%=rs.getString("briefInfo")%></p>
							<p>
							<a href="modular_articleList.jsp?id=<%=rs.getString("id")%>" class="btn btn-primary" role="button">进入</a>
							</p>
						</div>
					</div>
				</div>
				<%
					}
				%>
				<%
					}
				%>
			</div>
			<%
				rs = con.getSelect("select * from article order by newDate desc");
				int count = 0;
				while (rs.next()) {
			%>
			<div class="panel panel-info">
				<div class="input-group">
					<div class="panel-heading"
						style="width: 333px; overflow: hidden; text-overflow: ellipsis; -o-text-overflow: ellipsis; white-space: nowrap;">
						<a style="text-decoration: none; color: #000000"
							href="articleContent.jsp?id=<%=rs.getInt("id")%>&&username=<%=rs.getString("author")%>"><%=rs.getString("title")%></a>
					</div>

					<span class="input-group-btn" style="height: 100%">
						<button class="btn btn-default" type="button"
							style="border: none;"
							onclick="javascript:window.location.href='articleContent.jsp?id=<%=rs.getInt("id")%>&&username=<%=rs.getString("author")%>';">Go!</button>
					</span>
				</div>
				<!-- /input-group -->

			</div>
			<%
				++count;
					if (count == 8) {
						break;
					}
				}
				rs.close();
				con.closeAll();
			%>
		</div>
		<div class="col-md-3">
			<jsp:include page="rightPart.jsp"></jsp:include>
		</div>
	</div>
	</article>

	<jsp:include page="footer.jsp"></jsp:include>
	<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
	<script src="https://cdn.bootcss.com/jquery/1.11.1/jquery.min.js"></script>
	<!-- Include all compiled plugins (below), or include individual files as needed -->
	<script src="../javascript/bootstrap.min.js"></script>
</body>
</html>
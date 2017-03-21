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
<link rel="shortcut icon" href="<%=basePath%>headImages/favicon.ico"
	type="image/x-icon" />
<title>Try.Catch</title>
<link href="../css/bootstrap.min.css" rel="stylesheet">

<!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
<!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
<!--[if lt IE 9]>
    <script src="http://cdn.bootcss.com/html5shiv/3.7.2/html5shiv.min.js"></script>
    <script src="http://cdn.bootcss.com/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
<script type="text/javascript"
	src="<%=basePath%>front_develop/tools/javascript/jquery.min.js"></script>
<style type="text/css">
#reply:hover {
	cursor: pointer;
} 
</style>
</head>
<body>
	<jsp:include page="header.jsp"></jsp:include>

	<article class="container" style="margin-top: 66px">
	<div class="row">
		<div class="col-md-9">
			<div class="alert alert-warning alert-dismissible" role="alert">
				<button type="button" class="close" data-dismiss="alert">
					<span aria-hidden="true">&times;</span><span class="sr-only">Close</span>
				</button>
				<strong>欢迎加入<a href="http://218.4.212.4:8000/front_develop/index.jsp"
					class="alert-link" target="_blank">IT技术交流平台</a>!
				</strong>
			</div>
			<div class="media">
				<%
					String shareImage = null;
					String username = new String(request.getParameter("username").getBytes("iso-8859-1"), "utf-8");
					ConnDb con = new ConnDb();
					ResultSet rs = con.getSelect("select * from admin where userName='" + username + "'");
					if (rs.next()) {
						shareImage = rs.getString("imageName");
				%>

				<a class="media-left" href='articleList.jsp?username=<%=username%>'>
					<img src="../headImages/<%=rs.getString("imageName")%>"
					style="height: 80px; width: 80px; border: 1px solid black; border-radius: 5px;">
				</a>
				<div class="media-body">
					<h4 class="media-heading" style="margin-left: 25px">
						作者：<a href='articleList.jsp?username=<%=username%>'
							style="text-decoration: none; color: #000000"><%=rs.getString("userName")%></a>
					</h4>
					<%
						if (username.equals(request.getSession().getAttribute("username")) == false) {
								String ownName = request.getSession().getAttribute("username").toString();
								ResultSet rs2 = con.getSelect(
										"select * from friend where ownName='" + ownName + "' and friendName='" + username + "'");
								String id = new String(request.getParameter("id").getBytes("iso-8859-1"), "utf-8");
								if (rs2.next()) {
					%>
					<a href="../friendDel?friendName=<%=username%>&&mark=2&&id=<%=id%>"><button
							class="btn btn-warning" style="margin-left: 25px">取消关注</button></a>
					<%
						} else {
					%>
					<a href="../friendAdd?friendName=<%=username%>&&mark=2&&id=<%=id%>"><button
							class="btn btn-info" style="margin-left: 25px">关注</button></a>
					<%
						}
							}
					%>
				</div>
				<%
					}
				%>
			</div>
			<div class="panel panel-default">
				<%
					String shareTitle = null;
					String id = new String(request.getParameter("id").getBytes("iso-8859-1"), "utf-8");
					rs = con.getSelect("select * from article where id='" + id + "'");
					if (rs.next()) {
						shareTitle = rs.getString("title");
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
					String ownName = request.getSession().getAttribute("username").toString();
					rs = con.getSelect(
							"select * from praisearticle where praiser='" + ownName + "' and articleId='" + id + "'");
					ResultSet rs2 = con.getSelect("select * from article where id='" + id + "'");
					if (rs.next()) {
						if (rs2.next()) {
				%>
				<button class="btn btn-primary" disabled type="button">
					<lable class="glyphicon glyphicon-thumbs-up"></lable>
					<span class="badge"><%=rs2.getInt("praiseNumber")%></span>
				</button>
				<button class="btn btn-warning" disabled type="button">
					<lable class="glyphicon glyphicon-thumbs-down"></lable>
					<span class="badge"><%=rs2.getInt("criticizeNumber")%></span>
				</button>
				<%
					}
					} else {
						if (rs2.next()) {
				%>
				<a href="../praiseArticle?id=<%=id%>&&username=<%=username%>"><button
						class="btn btn-primary" type="button">
						<lable class="glyphicon glyphicon-thumbs-up"></lable>
						<span class="badge"><%=rs2.getInt("praiseNumber")%></span>
					</button></a> <a href="../criticizeArticle?id=<%=id%>&&username=<%=username%>"><button
						class="btn btn-warning" type="button">
						<lable class="glyphicon glyphicon-thumbs-down"></lable>
						<span class="badge"><%=rs2.getInt("criticizeNumber")%></span>
					</button></a>
				<%
					}
					}
				%>
				<span class="bdsharebuttonbox" style="float: right;"> <a
					href="#" class="bds_more" data-cmd="more"></a><a href="#"
					class="bds_qzone" data-cmd="qzone" title="分享到QQ空间"></a><a href="#"
					class="bds_tsina" data-cmd="tsina" title="分享到新浪微博"></a><a href="#"
					class="bds_tqq" data-cmd="tqq" title="分享到腾讯微博"></a><a href="#"
					class="bds_renren" data-cmd="renren" title="分享到人人网"></a><a href="#"
					class="bds_weixin" data-cmd="weixin" title="分享到微信"></a>
				</span>
				<script>
					window._bd_share_config = {
						"common" : {
							"bdSnsKey" : {},
							"bdText" : "<%=shareTitle%>",
							"bdDesc":"",
							"bdMini" : "2",
							"bdMiniList" : false,
							"bdPic" : "<%=basePath%>headImages/<%=shareImage%>",
							"bdUrl" : "<%=basePath%>front_develop/articleContent.jsp?id=<%=id%>&&username=<%=username%>",
							"bdStyle" : "0",
							"bdSize" : "24"
						},
						"share" : {},
						"image" : {
							"viewList" : [ "qzone", "tsina", "tqq", "renren",
									"weixin" ],
							"viewText" : "分享到：",
							"viewSize" : "16"
						},
						"selectShare" : {
							"bdContainerClass" : null,
							"bdSelectMiniList" : [ "qzone", "tsina", "tqq",
									"renren", "weixin" ]
						}
					};
					with (document)
						0[(getElementsByTagName('head')[0] || body)
								.appendChild(createElement('script')).src = 'http://bdimg.share.baidu.com/static/api/js/share.js?v=89860593.js?cdnversion='
								+ ~(-new Date() / 36e5)];
				</script>
			</div>

			<div class="alert alert-info alert-dismissible" role="alert">
				<button type="button" class="close" data-dismiss="alert">
					<span aria-hidden="true">&times;</span><span class="sr-only">Close</span>
				</button>
				<strong>Hello!</strong> 欢迎发表评论 <strong>↓</strong>
			</div>




			<%
				ResultSet rs3 = con.getSelect("select * from comment where articleId='" + id + "' order by date desc");
				while (rs3.next()) {
					String commentAuthor = rs3.getString("author");
					ResultSet rs4 = con.getSelect("select * from admin where userName='" + commentAuthor + "'");
					if (rs4.next()) {
			%>
			
			<div class="media well well-sm">

		
				<a class="media-left"
					href='articleList.jsp?username=<%=rs4.getString("userName")%>'>
					<img src="../headImages/<%=rs4.getString("imageName")%>"
					style="height: 50px; width: 50px; border: 1px solid black; border-radius: 5px;" />
				</a>
	
				<div class="media-body">
					<h4 class="media-heading" style="margin-left: 10px">
						<a href='articleList.jsp?username=<%=commentAuthor%>'
							style="text-decoration: none; color: #000000"><%=commentAuthor%></a>
						<span
							onclick="
							$('.replyCommentSelectMark').hide(666);
							$('.form-control.replyInputMark').val('');
							$('#<%=rs3.getInt("id")%><%=rs3.getString("author")%><%=id%>').show(666);
							" id="reply">(回复ta)</span>					
					</h4>
					<div style="margin-left: 10px">
						<p><%=rs3.getString("content")%></p>
					</div>

					<%
						String commentId=rs3.getInt("id")+"";
						ResultSet rs5=con.getSelect("select * from replycomment where commentId='"+commentId+"' order by date asc");
						while(rs5.next()){
							String replyAuthor=rs5.getString("replyAuthor");
							ResultSet rs6=con.getSelect("select * from admin where userName='"+replyAuthor+"'");
							if(rs6.next()){
					%>
					<div class="media">
						<a class="media-left"
							href='articleList.jsp?username=<%=rs6.getString("userName")%>'>
							<img src="../headImages/<%=rs6.getString("imageName")%>"
							style="height: 50px; width: 50px; border: 1px solid black; border-radius: 5px;">
						</a>
						<div class="media-body">
							<h4 class="media-heading" style="margin-left: 10px">
								<a
									href='articleList.jsp?username=<%=rs5.getString("replyAuthor")%>'
									style="text-decoration: none; color: #000000"><%=rs5.getString("replyAuthor")%></a>
								回复 <a
									href='articleList.jsp?username=<%=rs5.getString("commentAuthor")%>'
									style="text-decoration: none; color: #000000"><%=rs5.getString("commentAuthor")%></a>
							</h4>
							<div style="margin-left: 10px">
								<p><%=rs5.getString("replyContent")%></p>
							</div>
						</div>
					</div>
					<%
							}
							rs6.close();
						}
						rs5.close();			
					%>
					<form action="../replyAdd?commentId=<%=commentId %>&&commentAuthor=<%=commentAuthor %>&&id=<%=id%>&&username=<%=username%>"  class="replyCommentSelectMark"
				method="post" id="<%=rs3.getInt("id")%><%=rs3.getString("author")%><%=id%>" style="display:none">
				<div class="input-group">
					<input type="text" class="form-control replyInputMark" name="reply" required
						maxlength="25"> <span class="input-group-btn">
						<button class="btn btn-default" type="submit">回复</button>
					</span>
				</div>
			</form>
			</div>
		</div>
			<%
					}
					rs4.close();	
				}
				rs.close();
				rs2.close();
				rs3.close();
				con.closeAll();
			%>







			<form action="../commentAdd?id=<%=id%>&&username=<%=username%>"
				id="commentForm" method="post">
				<div class="input-group">
					<input type="text" class="form-control" name="comment" required 
					onFocus="
						$('.replyCommentSelectMark').hide(666);
						$('.form-control.replyInputMark').val('');
					"
						maxlength="66"> <span class="input-group-btn">
						<button class="btn btn-default" type="submit">发表评论</button>
					</span>
				</div>
			</form>
			
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
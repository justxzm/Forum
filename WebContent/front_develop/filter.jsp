<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
<title>拦截</title>
</head>
<body>
<h1>您还未登录，<span id="count">5</span>秒后返回首页~</h1>
<script type="text/javascript">
	var timeCount=4;
	window.onload=function(){
		setInterval(function(){
				document.getElementById("count").innerHTML=timeCount;
				timeCount--;
				if(timeCount==0){
					window.location.href="index.jsp";
				}
			},1000);
	}
</script>
</body>
</html>
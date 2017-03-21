<%@page import="com.opensymphony.xwork2.ActionContext"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Hello!</title>
<script type="text/javascript">
<%
	String source="";
	if(request.getParameter("source")!=null){
		source=request.getParameter("source");
	}
	if(source.equals("UpdateRoot")){
		%>
		window.onload=function(){
			document.getElementById("goIndex").click();
		}
		<%
	}else{
		%>
		window.onload=function(){
			document.getElementById("index").click();
		}
		<%
	}
%>
	
</script>
</head>
<body>
<a href="front_develop/index.jsp" target="_parent" id="index"></a>
<a href="front_develop/goIndex.jsp" target="_parent" id="goIndex"></a>
</body>
</html>
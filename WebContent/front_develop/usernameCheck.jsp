<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="db.ConnDb"%>
<%@ page import="java.sql.ResultSet"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title></title>
</head>
<body>
<%
	String username=new String(request.getParameter("username").getBytes("iso-8859-1"),"utf-8");
	ConnDb con=new ConnDb();
	ResultSet rs=con.getSelect("select * from admin where userName='"+username+"'");
	if(request.getSession().getAttribute("username")==null){
		if(rs.next()){
			out.println("已存在");
		}else{
			out.println("可用");
		}
	}else{
		String myname=request.getSession().getAttribute("username").toString();
		if(myname.equals(username)){
			out.println("可用");
		}else{
			if(rs.next()){
				out.println("已存在");
			}else{
				out.println("可用");
			}
		}
	}
%>
</body>
</html>
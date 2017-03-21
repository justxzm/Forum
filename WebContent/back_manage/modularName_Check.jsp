<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="db.ConnDb" %>
<%@ page import="java.sql.ResultSet" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title></title>
</head>
<body>
	<%
		String modularName = new String(request.getParameter("modularName").getBytes("iso-8859-1"), "utf-8");
		ConnDb con = new ConnDb();
		ResultSet rs = con.getSelect("select * from modular where modularName='" + modularName + "'");
			if (rs.next()) {
				out.println("已存在");
			} else {
				out.println("可用");
			}
			rs.close();
			con.closeAll();
	%>
</body>
</html>
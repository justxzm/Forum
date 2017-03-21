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
<link href="../css/bootstrap.min.css" rel="stylesheet">
<!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
<!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
<!--[if lt IE 9]>
    <script src="http://cdn.bootcss.com/html5shiv/3.7.2/html5shiv.min.js"></script>
    <script src="http://cdn.bootcss.com/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
<script type="text/javascript"
	src="<%=basePath%>front_develop/tools/javascript/jquery.min.js"></script>
<script type="text/javascript"
	src="<%=basePath%>front_develop/tools/javascript/jquery.qrcode.min.js"></script>
	<script type="text/javascript">
		var oldModularName
		window.onload=function(){
			oldModularName=document.getElementById("modularName").value;
		}
		function goback(){
			document.location="modular_Manage.jsp";
		}

		function checkModularName(modularName){
			if(oldModularName!=modularName.value){
				var value=modularName.value;
				value = value.replace(/\&/g, "%26");  
				value = value.replace(/\+/g, "%2B");  
				createRequest("modularName_Check.jsp?modularName="+value);
			}else{
				document.getElementById("errorInfo").innerHTML="";
				document.getElementById("form-group-errorInfo").style.display="none";
			}
	}
	function createRequest(url){
		http_request=null;
		if(window.XMLHttpRequest){
			http_request=new XMLHttpRequest();
		}else if(window.ActiveXObject){
			try{
				http_request=new ActiveXObject("Msxml2.XMLHTTP");
			}catch(e){
				try{
					http_request=new ActiveXObject("Microsoft.XMLHTTP");
				}catch(e){}
			}
		}
		if(!http_request){
			alert("不能创建对象");
		}
		http_request.onreadystatechange=getResult;
		http_request.open("GET",url,true);
		http_request.send(null);
	}
	function getResult(){
		if(http_request.readyState==4){
			if(http_request.status==200){
				backinfo=http_request.responseText;
				if(backinfo.indexOf("已存在")>-1){
					document.getElementById("errorInfo").innerHTML="板块名已存在，请重新输入";
					document.getElementById("form-group-errorInfo").style.display="block";
				}else if(backinfo.indexOf("可用")>-1){
					document.getElementById("errorInfo").innerHTML="";
					document.getElementById("form-group-errorInfo").style.display="none";
				}
			}else{
				alert("请求服务器出错");
			}
		}
	}
	function validate_form(thisform){
		errorInfo=$("#errorInfo").html();
		if(errorInfo==""){
			return true;
		}else{
			return false;
		}
	}
	</script>
</head>
<body style="margin-top: 10px">
	<div class="container" style="width: 66%">
		<div class="alert alert-warning alert-dismissible" role="alert">
			<button type="button" class="close" data-dismiss="alert">
				<span aria-hidden="true">&times;</span><span class="sr-only">Close</span>
			</button>
			<strong>板块信息编辑</strong>
		</div>
		<%
			ConnDb con = new ConnDb();
			String id=new String(request.getParameter("id").getBytes("iso-8859-1"),"utf-8");
			ResultSet rs = con.getSelect("select * from modular where id='" + id + "'");
			if (rs.next()) {
		%>
		<div class="media">
			<a class="media-left"> <img
				src="../headImages/<%=rs.getString("briefImage")%>"
				style="height: 80px; width: 80px; border: 1px solid black; border-radius: 5px;">
			</a>
				<div class="media-body">
				<h4 class="media-heading" style="margin-left: 25px">模块图片选择</h4>
				<form action="upload2.just?id=<%=id %>" enctype="multipart/form-data"
					style="margin-left: 25px" method="post">
					<input type="file" name="upload" required /> <input type="submit"
						value="更换" />
				</form>
			</div>
		</div>
		<br>
		<form class="form-horizontal" role="form" name="form1" onsubmit="validate_form(this)"
			action="../updateModular?id=<%=id %>"
			method="post">
			<div class="form-group">

				<label for="inputEmail3" class="col-md-1 control-label">ModularName</label>
				<div class="col-md-1"></div>
				<div class="col-md-10">
					<input type="text" class="form-control" id="modularName"
						name="modularName" value="<%=rs.getString("modularName")%>" onblur="checkModularName(form1.modularName)"
						placeholder="UserName" required>
				</div>
			</div>
			<div class="form-group">
				<label for="inputEmail3" class="col-md-1 control-label">BriefInfo</label>
				<div class="col-md-1"></div>
				<div class="col-md-10">
					<input type="text" class="form-control" id="inputEmail3"
						name="briefInfo" value="<%=rs.getString("briefInfo")%>"  onblur="checkModularName(form1.modularName)"
						placeholder="Password" required>
				</div>
			</div>
			<div class="form-group">
				<label for="inputPassword3" class="col-md-1 control-label">Creator</label>
				<div class="col-md-1"></div>
				<div class="col-md-10">
					<input type="text" class="form-control" id="inputPassword3"
						name="email" value="<%=rs.getString("creator")%>" disabled
						placeholder="Email">
				</div>
			</div>
			<div class="form-group" id="form-group-errorInfo" style="display:none">
				<div class="col-md-2"></div>
				<div class="col-md-10">
					<div class="checkbox">
						<span id="errorInfo" style="color:red;"></span>
					</div>
				</div>
			</div>
			<div class="form-group">
				<div class="col-md-2"></div>
				<div class="col-md-10">
					<button type="submit" class="btn btn-primary">Save</button>
					<button type="button" class="btn btn-primary" onclick="goback()">返回</button>
				</div>
			</div>
		</form>
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
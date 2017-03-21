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
<script>
	var tof = false;
	$(document).ready(function() {
		$("#showSetUp").click(function() {
			if (tof != true) {
				$("#deleteUser").show("slow");
				tof = true;
			} else {
				$("#deleteUser").hide("slow");
				tof = false;
			}
		});
	});
	<%
		ConnDb con = new ConnDb();
		String username = request.getSession().getAttribute("username").toString();
		ResultSet rs = con.getSelect("select * from admin where userName='" + username + "'");
		if (rs.next()) {
	%>
	function show_confirm() {
		  var password=prompt("请输入密码确认该操作","")
		  if (password=='<%=rs.getString("password")%>')
		    {
			  var tof=confirm("删除账号后将返回首页");
			  if(tof==true){
				  location.href = "../deleteUser";
			  }
		    }else{
		    	alert("密码错误,销号失败！");
		    }
	}
	function checkPasswd(password, confirm) {
		var passwd = password.value;
		var confirmPwd = confirm.value;
		if (passwd == "") {
			document.getElementById("errorInfo").innerHTML = "密码不能为空";
			document.getElementById("form-group-errorInfo").style.display = "block";
			return;
		} else{
			if (confirmPwd == passwd) {
				document.getElementById("errorInfo").innerHTML = "";
				document.getElementById("form-group-errorInfo").style.display = "none";
			} else {
				document.getElementById("errorInfo").innerHTML = "密码不一致";
				document.getElementById("form-group-errorInfo").style.display = "block";
			}
		}
		
	}
	function createRequest(url) {
		http_request = null;
		if (window.XMLHttpRequest) {
			http_request = new XMLHttpRequest();
		} else if (window.ActiveXObject) {
			try {
				http_request = new ActiveXObject("Msxml2.XMLHTTP");
			} catch (e) {
				try {
					http_request = new ActiveXObject("Microsoft.XMLHTTP");
				} catch (e) {
				}
			}
		}
		if (!http_request) {
			alert("不能创建对象");
		}
		http_request.onreadystatechange = getResult;
		http_request.open("POST", url, true);
		http_request.send(null);
	}
	function getResult() {
		if (http_request.readyState == 4) {
			if (http_request.status == 200) {
				backinfo = http_request.responseText;
				if (backinfo.indexOf("已存在") > -1) {
					document.getElementById("errorInfo").innerHTML = "用户名已存在，请重新输入";
					document.getElementById("form-group-errorInfo").style.display = "block";
				} else if (backinfo.indexOf("可用") > -1) {
					document.getElementById("errorInfo").innerHTML = "";
					document.getElementById("form-group-errorInfo").style.display = "none";
				}
			} else {
				alert("请求服务器出错");
			}
		}
	}
	function validate_form(thisform) {
		errorInfo = $("#errorInfo").html();
		if (errorInfo == "") {
			return true;
		} else {
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
			<strong>最高权限设置</strong>
		</div>
		<%
			
		%>
		<div class="media">
			<a class="media-left"> <img
				src="../headImages/<%=rs.getString("imageName")%>"
				style="height: 80px; width: 80px; border: 1px solid black; border-radius: 5px;">
			</a>
			<div class="media-body">
				<h4 class="media-heading" style="margin-left: 25px">头像选择</h4>
				<form action="upload.just" enctype="multipart/form-data"
					style="margin-left: 25px" method="post">
					<input type="file" name="upload" required /> <input type="submit"
						value="更换" />
				</form>
			</div>
		</div>
		<br>
		<form class="form-horizontal" role="form" name="form1"
			onsubmit="return validate_form(this)"
			action="../updateRoot?oldUserName=<%=rs.getString("userName")%>"
			method="post">
			<div class="form-group">

				<label for="inputEmail3" class="col-md-1 control-label">UserName</label>
				<div class="col-md-1"></div>
				<div class="col-md-10">
					<input type="text" class="form-control" id="inputEmail3"
						name="userName" value="<%=rs.getString("userName")%>"
						onblur="checkUser(form1.userName)" placeholder="UserName" required
						disabled>
				</div>
			</div>
			<div class="form-group">
				<label for="inputEmail3" class="col-md-1 control-label">Password</label>
				<div class="col-md-1"></div>
				<div class="col-md-10">
					<input type="password" class="form-control" id="inputEmail3"
						name="password" value="<%=rs.getString("password")%>"
						placeholder="Password" required>
				</div>
			</div>
			<div class="form-group">
				<label for="inputEmail3" class="col-md-1 control-label">Confirm</label>
				<div class="col-md-1"></div>
				<div class="col-md-10">
					<input type="password" class="form-control" id="inputEmail3"
						name="confirm" onblur="checkPasswd(form1.password,form1.confirm)"
						placeholder="Confirm Password" required>
				</div>
			</div>
			<div class="form-group">
				<label for="inputPassword3" class="col-md-1 control-label">Email</label>
				<div class="col-md-1"></div>
				<div class="col-md-10">
					<input type="email" class="form-control" id="inputPassword3"
						name="email" value="<%=rs.getString("email")%>"
						onblur="checkUser(form1.userName)" placeholder="Email" required>
				</div>
			</div>
			<div class="form-group" id="form-group-errorInfo"
				style="display: none">
				<div class="col-md-2"></div>
				<div class="col-md-10">
					<div class="checkbox">
						<span id="errorInfo" style="color: red;"></span>
					</div>
				</div>
			</div>
			<div class="form-group">
				<div class="col-md-2"></div>
				<div class="col-md-10">
					<div class="checkbox">
						<label> <input type="checkbox" id="showSetUp">隐藏设置
						</label>
					</div>
				</div>
			</div>
			<div class="form-group">
				<div class="col-md-2"></div>
				<div class="col-md-10">
					<button type="submit" class="btn btn-primary">Save</button>
					<button type="button" class="btn btn-danger" id="deleteUser"
						style="display: none" onclick="show_confirm()">DelUser</button>
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
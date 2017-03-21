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
<meta name="viewport" content="width=device-width, initial-scale=0.9 user-scalable=no">
<link href="<%=basePath%>css/bootstrap.min.css" rel="stylesheet">

<!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
<!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
<!--[if lt IE 9]>
    <script src="http://cdn.bootcss.com/html5shiv/3.7.2/html5shiv.min.js"></script>
    <script src="http://cdn.bootcss.com/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
<script type="text/javascript" src="<%=basePath%>front_develop/tools/javascript/jquery.min.js"></script>
<script type="text/javascript">
	function changeText() {
		document.getElementById("sendEmail").setAttribute('class',
				'btn btn-info disabled');
		document.getElementById("signInBtn").setAttribute('class',
				'btn btn-default disabled');	
		if(document.getElementById("userName").value==""){
			$("#sendEmail").removeClass("disabled");
			document.getElementById("sendEmail").setAttribute('class',
			'btn btn-warning');
			document.getElementById("sendEmail").innerHTML = "请输入用户名";
		}else{
			document.getElementById("sendEmail").innerHTML = "邮件正在发送...";
			setTimeout(sendEmail, 1500);
		}	
	}
	
	function sendEmail() {
		document.getElementById("sendEmail").setAttribute('class',
				'btn btn-success disabled');
		document.getElementById("sendEmail").innerHTML = "邮件已发送!";
		window.location.href = '../sendEmail?username='+document.getElementById("userName").value;
	}
	var tof = false;
	var tof2 = false;
	var tof3 = false;
	$(document).ready(function() {
		$("#menu").click(function() {
			$("#verticalLine").hide(0);
			if (tof != true) {
				$("#bs-example-navbar-collapse-1").show(0);
				tof = true;
			} else {
				$("#bs-example-navbar-collapse-1").hide("slow");
				tof = false;
			}
		});

		$("#admin").click(function() {
			if (tof2 != true) {
				$("#adminMenu").show(250);
				tof2 = true;
			} else {
				$("#adminMenu").hide(250);
				tof2 = false;
			}
		});
		$("#admin").blur(function() {
				$("#adminMenu").hide(500);
				tof2 = false;
		});
		$("#findPassword").click(function() {
				$("#specialModal").slideToggle("slow");
				if (tof3 != true) {
					$("#signInBtn").addClass("disabled");
					$("#sendEmail").removeClass("disabled");
					sendEmail
					tof3 = true;
				} else {
					$("#signInBtn").removeClass("disabled");
					document.getElementById("sendEmail").setAttribute('class',
					'btn btn-info');
					document.getElementById("sendEmail").innerHTML = "Forget?";
					$("#sendEmail").addClass("disabled");
					tof3 = false;
				}
		});
	});
	function checkUser(username){
			createRequest("usernameCheck.jsp?username="+username.value);
	}
	function codeCheck(code){
		createRequest("../checkCode?japtcha="+code.value);
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
		http_request.open("POST",url,true);
		http_request.send(null);
	}
	function getResult(){
		if(http_request.readyState==4){
			if(http_request.status==200){
				backinfo=http_request.responseText;
				if(backinfo.indexOf("已存在")>-1){
					document.getElementById("errorInfo2").innerHTML="用户名已存在，请重新输入";
				}else if(backinfo.indexOf("可用")>-1){
					document.getElementById("errorInfo2").innerHTML="";
				}else if(backinfo.indexOf("captcha failed")>-1){
					document.getElementById("errorInfo").innerHTML="验证码错误，请重新输入";
					reload();
				}else if(backinfo.indexOf("captcha passed")>-1){
					document.getElementById("errorInfo").innerHTML="";
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
	function validate_form2(thisform){
		errorInfo=$("#errorInfo2").html();
		if(errorInfo==""){
			return true;
		}else{
			return false;
		}
	}
	function reload(){
		document.getElementById("checkcode").value="";
		document.getElementById("checkcodeImage").src="<%=path%>/jcaptcha";
	}
</script>
</head>
<body>
	<nav class="navbar navbar-default navbar-inverse navbar-fixed-top"
		role="navigation">
	<div class="container">
		<!-- Brand and toggle get grouped for better mobile display -->
		<div class="navbar-header">
			<button type="button" class="navbar-toggle collapsed" id="menu"
				data-toggle="collapse" data-target="#bs-example-navbar-collapse-1">
				<span class="sr-only">Toggle navigation</span> <span
					class="icon-bar"></span> <span class="icon-bar"></span> <span
					class="icon-bar"></span>
			</button>
			<!-- <a class="navbar-brand" href="#" data-toggle="modal"
				data-target="#myModal">Try.Catch</a> -->
			<a class="navbar-brand" href="<%=basePath%>front_develop/index.jsp" id="test">Try.Catch</a>
		</div>


		<div class="modal fade" id="loginModal" tabindex="-1" role="dialog"
			aria-labelledby="myModalLabel" aria-hidden="false">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal">
							<span aria-hidden="true">&times;</span><span class="sr-only">Close</span>
						</button>
						<h4 class="modal-title" id="myModalLabel">登录</h4>
					</div>
					<div class="modal-body">

						<form class="form-horizontal" role="form" id="signIn" name="form1" onsubmit="return validate_form(this)"
							action="<%=basePath%>loginServlet" method="post">
							<div class="form-group">
								<label for="inputEmail3" class="col-sm-2 control-label">UserName</label>
								<div class="col-sm-10">
									<input type="text" class="form-control" id="userName"
										name="username" placeholder="UserName" required>
								</div>
							</div>
							<div id="specialModal">
								<div class="form-group">
									<label for="inputPassword3" class="col-sm-2 control-label">Password</label>
									<div class="col-sm-10">
										<input type="password" class="form-control"
											id="inputPassword3" name="password" placeholder="Password">
									</div>
								</div>
								<div class="form-group">
									<label for="inputEmail3" class="col-sm-2 control-label">CheckCode</label>
									<div class="col-sm-6">
										<input type="text" class="form-control" id="checkcode" onblur="codeCheck(form1.checkcode)"
											name="checkcode" required>
									</div>
									<div class="col-sm-4">
										<img src="<%=path%>/jcaptcha" onclick="reload()" width="100%" height="50px" id="checkcodeImage"/>
									</div>
								</div>
							</div>
							<div class="form-group">
								<div class="col-sm-offset-2 col-sm-10">
									<div class="checkbox">
										<label> <input type="checkbox" id="findPassword"> Find Password Model
										</label>
									</div>
								</div>
							</div>
						</form>


					</div>
					
					<div class="modal-footer">
						<span id="errorInfo" style="color:red"></span>
						<button type="submit" class="btn btn-default" form="signIn"
							id="signInBtn">Sign in</button>
						<button type="button" class="btn btn-primary disabled" id="sendEmail"
							onclick="changeText()">Forget?</button>
					</div>
				</div>
			</div>
		</div>

<div class="modal fade" id="registModal" tabindex="-1" role="dialog"
			aria-labelledby="myModalLabel" aria-hidden="false">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal">
							<span aria-hidden="true">&times;</span><span class="sr-only">Close</span>
						</button>
						<h4 class="modal-title" id="myModalLabel">注册</h4>
					</div>
					<div class="modal-body">

						<form class="form-horizontal" role="form" id="regist" name="form2" onsubmit="return validate_form2(this)"
							action="<%=basePath%>registServlet" method="post">
							<div class="form-group">
								<label for="inputEmail3" class="col-sm-2 control-label">UserName</label>
								<div class="col-sm-10">
									<input type="text" class="form-control" id="username2"
										name="username2" placeholder="UserName" required onblur="checkUser(form2.username2)">
								</div>
							</div>
							<div class="form-group">
								<label for="inputPassword3" class="col-sm-2 control-label">Password</label>
								<div class="col-sm-10">
									<input type="password" class="form-control" id="inputPassword3" onblur="checkUser(form2.username2)"
										name="password" placeholder="Password" required>
								</div>
							</div>
							<div class="form-group">
								<label for="inputPassword3" class="col-sm-2 control-label">Email</label>
								<div class="col-sm-10">
									<input type="email" class="form-control" id="inputPassword3" onblur="checkUser(form2.username2)"
										name="email" placeholder="Eamil" required>
								</div>
							</div>
						</form>
					</div>
					
					<div class="modal-footer">
						<span id="errorInfo2" style="color:red"></span>
						<button type="submit" class="btn btn-primary" form="regist"
							id="signInBtn">Regist</button>
					</div>
				</div>
			</div>
		</div>
		
		
		<!-- Collect the nav links, forms, and other content for toggling -->
		<div class="collapse navbar-collapse"
			id="bs-example-navbar-collapse-1">
		
			<%
				String username=null;
				if(request.getSession().getAttribute("username")!=null){
					username=request.getSession().getAttribute("username").toString();
				}
				if(username==null){
					%>
					  <ul class="nav navbar-nav navbar-right">
        <li><a href="#" data-toggle="modal"
				data-target="#loginModal">登录</a>
        <li id="verticalLine"><a href="#">|</a></li>
        <li><a href="#" data-toggle="modal"
				data-target="#registModal">注册</a></li>
        </ul>
					<%
				}else{
					%>
					<ul class="nav navbar-nav navbar-right">
						<li class="dropdown"><a href="#" class="dropdown-toggle"
					id="admin" data-toggle="dropdown"><%=username %><span class="caret"></span></a>
							<ul class="dropdown-menu" role="menu" id="adminMenu">
								<li><a href="<%=basePath%>back_manage/backManager_index.jsp">个人中心</a></li>
								<li class="divider"></li>
								<li><a href="<%=basePath%>signOut">退出登录</a></li>
							</ul>
						</li>
					</ul>
					<%
				}
			%>
			<form class="navbar-form navbar-right" role="search"
				action="<%=basePath%>front_develop/articleSearch.jsp">
				<div class="form-group">
					<input type="text" class="form-control" placeholder="Search"
						name="search">
				</div>
				<button type="submit" class="btn btn-primary">Submit</button>
			</form>
		</div>
		<!-- /.navbar-collapse -->
	</div>
	<!-- /.container-fluid --> </nav>
	<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
	<script src="https://cdn.bootcss.com/jquery/1.11.1/jquery.min.js"></script>
	<!-- Include all compiled plugins (below), or include individual files as needed -->
	<script src="<%=basePath%>javascript/bootstrap.min.js"></script>
</body>
</html>
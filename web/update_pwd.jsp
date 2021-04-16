<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
	<head>
		<meta charset="utf-8">
		<title></title>
		<link rel="stylesheet"  href="css/bootstrap.css"/>
		<link rel="stylesheet" href="css/index.css"/>
		<script type="text/javascript" src="js/jquery-3.1.1.min.js"></script>
		<script type="text/javascript" src="js/bootstrap.js"></script>
		<script type="text/javascript" src="js/include.js"></script>
	</head>
	<body>
		<!-- 头部 -->
		<%@include file="header.jsp" %>
		<!-- 头部面包屑导航 -->
		<nav aria-label="breadcrumb" style="width:60%;margin: auto;">
		  <ol class="breadcrumb" style="height: 40px;line-height: 20px;margin-top: 20px;background-color: white;border-bottom: 1px solid #000000;border-radius: 0px;">
		    <li class="breadcrumb-item"><a href="index.jsp">首页</a></li>
		    <li class="breadcrumb-item active" aria-current="page">修改密码</li>
		  </ol>
		</nav>
		<!-- 主体 -->
		<div class="content">
			<!-- 左边部分 -->
			<div class="left" style="margin-left: 350px;width: 150px;height: 300px;padding-top: 25px;margin-top: 25px;">
				<img src="images/head.jpg" style="border-radius: 50%;margin: auto;" />
				<span style="color: blue;font-size: 18pt;margin-left: 35px;padding-top: 10px;display: block;">admin</span>
				<div style="background: url(images/img03.png) 0px -46px no-repeat;width: 20px;margin-top: 10px;margin-left: 10px;">&nbsp;</div>
				<span style="position: absolute;margin-top: -19px;margin-left: 40px;font-size: 10pt;">我的资料</span>
				<div style="background: url(images/img03.png) -87px -25px no-repeat;width: 20px;margin-top: 10px;margin-left: 10px;">&nbsp;</div>
				<span style="position: absolute;margin-top: -19px;margin-left: 40px;font-size: 10pt;color: red;">修改密码</span>
			</div>
			<!-- 右边部分 -->
			<div class="right" style="position: absolute;top: 170px;">
				<div class="top_navigation">
					<ul class="" style="display: flex;margin-left: 600px;text-decoration: none;">
						<li><a href="update_info.jsp" style="border: 0px;text-decoration: none;">&nbsp;&nbsp;个人信息&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</a></li>
						<li><a href="update_pwd.jsp" style="margin-right: 25px; text-decoration: none;color:#FA8932;border-bottom: 1px solid #FA8932;padding-bottom: 15px;">&nbsp;&nbsp;修改密码&nbsp;&nbsp;</a></li>
					</ul>
					<hr style=" margin-top: 14px;width: 500px;margin-left: 600px;padding-top: 25px;"/>
					<div style="margin-left: 620px;">
						<form id="editUserpwdForm">
							<span>旧&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;密&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;码:</span>
							<input id="oldpassword" type="password" style="height: 30px;border: #B2B2B2 1px solid;margin-bottom: 20px;"/>
							<sapn style="color:#dee2e6" id="oldPasswordTip">4到16位（字母，数字，下划线，减号）组成</sapn><br />
							<span>新&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;密&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;码:</span>
							<input id="newpassword" type="password" style="height: 30px;border: #B2B2B2 1px solid;"/>
							<sapn style="color:#dee2e6" id="newPasswordTip">4到16位（字母，数字，下划线，减号）组成</sapn><br />
							<input type="submit" value="提交" style="font-size: 12pt;width: 60px;margin-top: 20px;margin-left: 50px;background-color:#FA8932 ;border: 0px;" id="editUserPwdSubmitBtn"/>
						</form>
					</div>
				</div>
			</div>
		</div>
	</body>
<script>
	$(function () {
		var username=$.session.get("username");

		//阻止表单自动提交
		$("#editUserpwdForm")[0].addEventListener("submit",function (ev) {
			ev.preventDefault();
		});

		$("#editUserPwdSubmitBtn").click(function () {//提交表单事件
			var oldpassword=$("#oldpassword").val();
			var newpassword=$("#newpassword").val();
			var passWorduPattern = /^[a-zA-Z0-9_-]{4,16}$/;//密码正则表达式,4到16位（字母，数字，下划线，减号）
			if (passWorduPattern.test(oldpassword)) {
				if(passWorduPattern.test(newpassword)){
					$.post("user/editUserPassword.do",{"username":username,"oldpassword":oldpassword,"newpassword":newpassword},function (result) {
						alert(result)
						if(result==1){
							alert("密码修改成功")
						}else{
							alert("密码修改失败")
						}
					},"json")
				}else{
					$("#newPasswordTip").html(密码格式错误)
					$("#newPasswordTip").css("color","red")
				}
			}else{
				$("#oldPasswordTip").html(密码格式错误)
				$("#oldPasswordTip").css("color","red")
			}

		})

	})

</script>
</html>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
	<head>
		<meta charset="utf-8">
		<title></title>
		<link rel="stylesheet"  href="css/bootstrap.css"/>
		<link rel="stylesheet" href="css/index.css"/>
		<script type="text/javascript" src="js/jquery-3.1.1.min.js"></script>
		<script type="text/javascript" src="js/bootstrap.js"></script>
	</head>
	<body>
		<!-- 头部 -->
		<%@include file="header.jsp" %>
		<!-- 头部面包屑导航 -->
		<nav aria-label="breadcrumb" style="width: 60%;margin: auto;">
		  <ol class="breadcrumb" style="height: 40px;line-height: 20px;margin-top: 20px;background-color: white;border-bottom: 1px solid #000000;border-radius: 0px;">
		    <li class="breadcrumb-item"><a href="index.jsp">首页</a></li>
		    <li class="breadcrumb-item active" aria-current="page">修改信息</li>
		  </ol>
		</nav>
		<!-- 主体 -->
		<div class="content">
			<!-- 左边部分 -->
			<div class="left" style="margin-left: 350px;width: 150px;height: 300px;padding-top: 25px;margin-top: 25px;">
				<img src="images/head.jpg" style="border-radius: 50%;margin: auto;" />
				<span style="color: blue;font-size: 18pt;margin-left: 35px;padding-top: 10px;display: block;">admin</span>
				<div style="background: url(images/img03.png) 0 -25px no-repeat;width: 20px;margin-top: 10px;margin-left: 10px;">&nbsp;</div>
				<span style="position: absolute;margin-top: -19px;margin-left: 40px;color: red;font-size: 10pt;">我的资料</span>
				<div style="background: url(images/img03.png) -87px -46px no-repeat;width: 20px;margin-top: 10px;margin-left: 10px;">&nbsp;</div>
				<span style="position: absolute;margin-top: -19px;margin-left: 40px;font-size: 10pt;">修改密码</span>
			</div>
			<!-- 右边部分 -->
			<div class="right" style="position: absolute;top: 170px;">
				<div class="top_navigation">
					<ul class="" style="display: flex;margin-left: 600px;">
						<li class="cur"><a href="update_info.jsp" style="margin-right: 25px; text-decoration: none;color:#FA8932;border-bottom: 1px solid #FA8932;padding-bottom: 15px;">&nbsp;&nbsp;个人信息&nbsp;&nbsp;</a></li>
						<li><a href="update_pwd.jsp" style="text-decoration: none;">修改密码</a></li>
					</ul>
					<hr style=" margin-top: 14px;width: 500px;margin-left: 600px;padding-top: 25px;"/>
					<div style="margin-left: 620px;">
						<form id="editUserInfoForm">
							<span >用&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;户&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;名:</span>
							<input name="newname" id="newname" type="text" style="height: 30px;border: #B2B2B2 1px solid;margin-bottom: 20px;" />
							<span  id="nameFormatTip" style="color:#dee2e6">4到16位（字母，数字）组成</span><br />
							<span >我的记忆方式:</span>
							<input name="newmemory" id="newmemory" type="text" style="height: 30px;border: #B2B2B2 1px solid;"/>
							<span  id="memoryFormatTip" style="color:#dee2e6">请输入0-20的数字</span><br />
							<input id="editUserInfoSubmitBtn" type="submit" value="提交" style="font-size: 12pt;width: 60px;margin-top: 20px;margin-left: 50px;background-color:#FA8932 ;border: 0px;"  />
							<input name="newmemory" id="oldmemory" type="hidden" style="height: 30px;border: #B2B2B2 1px solid;"/><br />
						</form>
					</div>
				</div>
			</div>
		</div>
	</body>
<script>
	$(function () {
		//获取用户名和记忆模式赋值到页面
		var username=$.session.get("username");
		$("#newname").val(username)
		$.post("user/getUserDetailMemory.do",{"username":username},function (result) {
			$("#newmemory").val(result.memory)
			$("#oldmemory").val(result.memory)
		},"json")

		//阻止表单自动提交
		$("#editUserInfoForm")[0].addEventListener("submit",function (ev) {
			ev.preventDefault();
		});
	//	点击提交按钮提交表单
		var dataForm=$("#editUserInfoForm").serialize();
		$("#editUserInfoSubmitBtn").click(function () {
			var userNameuPattern = /^[a-zA-Z0-9]{4,16}$/;//用户名正则，4到16位（字母，数字）
			var intuPattern=/^[1-9]\d*$/;//整数的正则
			//判断账号和记忆模式格式
			if(userNameuPattern.test($("#newname").val()) && 20>$("#newmemory").val()>0 && intuPattern.test($("#newmemory").val())){
				if($("#newname").val()!=""&&$("#newmemory").val()!=""){//判断输入值不为空
					if($("#newname").val()!=username && $("#newmemory").val()==$("#oldmemory").val()){//修改账号
						$.post("user/editUserUsername.do",{"newname":$("#newname").val(),"username":username},function (result) {
							$.session.set("username",$("#newname").val())//将session修改
							if(result==0){
								alert("账号修改失败")
							}else {
								alert("账号修改成功")
							}
						},"json")
					}else if($("#newname").val()==username && $("#newmemory").val()!=$("#oldmemory").val()){//修改记忆模式
						$.post("user/editUserMemory.do",{"newmemory":$("#newmemory").val(),"username":username},function (result) {
							if(result==0){
								alert("记忆模式修改失败")
							}else {
								alert("记忆模式修改成功")
							}
						},"json")
					}else if($("#newname").val()!=username && $("#newmemory").val()!=$("#oldmemory").val()){//修改记忆模式和账号
						$.post("user/editUserUsername.do",{"newname":$("#newname").val(),"username":username},function (result) {
							$.session.set("username",$("#newname").val())//将session修改
						},"json")
						$.post("user/editUserMemory.do",{"newmemory":$("#newmemory").val(),"username":username},function (result) {
						},"json")
						alert("修改成功")
					}
				}
			}
			if(!userNameuPattern.test($("#newname").val())){
				$("#nameFormatTip").html("账号格式错误")
				$("#nameFormatTip").css("color","red")
			}
			if(!intuPattern.test($("#newmemory").val()) || $("#newmemory").val()>20 || $("#newmemory").val()<0){
				$("#nameFormatTip").html("记忆模式格式错误")
				$("#nameFormatTip").css("color","red")
			}
			window.location.reload()
		})
	})
</script>
</html>

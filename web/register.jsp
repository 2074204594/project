<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8"/>
    <title>注册页面</title>
    <link rel="stylesheet" href="css/register.css"/>
	<script type="text/javascript" src="js/jquery-3.1.1.min.js"></script>
	<script type="text/javascript" src="js/JquerySession.js"></script>
</head>
<body style="background-image: url('/images/beijin.jpg');background-repeat: no-repeat;background-size:100% 100%;">
		<div class="register" style="background-color: white">
			<span class="text">用户注册</span>
			<div class="form">
				<form id="registerForm">
					<div>
						&nbsp;用&nbsp;户&nbsp;名:<input type="text" name="username" id="username">
						<span class="userNameTip Tip" style="font-size: 10pt;color: #6c757d">4-16位字母，数字</span>
					</div>
					<div>
						&nbsp;密&nbsp; &nbsp;&nbsp; &nbsp;码:<input type="password" name="password" id="password">
						<span class="userPasswordTip Tip" style="font-size: 10pt;color: #6c757d">4-16位字母，数字，下划线，减号</span>
					</div>
					<div>
						确认密码:<input type="password" id="repassword">
						<span class="userRepasswordTip Tip" style="font-size: 10pt;color: #6c757d"></span>
					</div>
					<div>
						&nbsp;验&nbsp;证&nbsp;码:<input type="text" name="code" id="codeText">
						<img src="/register/generateCode.do" style="position: absolute;" >
						<span class="userCodeTip Tip" style="margin-left: 80px;font-size: 10pt;display: none;">验证码错误</span>
					</div>
					<input type="button" value="返回主页" onclick="location='index.jsp'">
					<input type="submit" value="注册" style="width: 50px;height: 25px;font-size: 12pt;margin-left: 40%;margin-top: 20px;" id="formSubmit"/>
				</form>
			</div>
		</div>
<script>
	$(function () {
		var userflag=false;
		var passwordflag=false;
		var passflag=false;
		//关闭表格提交
		$("#registerForm")[0].addEventListener("submit",function (ev) {
			ev.preventDefault();
		});

		//检查用户名是否存在
		$("#username").blur(function () {
			var username=$("#username").val();
			var uPattern = /^[a-zA-Z0-9]{4,16}$/;//用户名正则，4到16位（字母，数字）
			if(uPattern.test(username)){
				$.post("/register/registerCheckUername.do",{"username":username},function (result) {
					if(result==0){
						$(".userNameTip").html("账号已存在")
						$(".userNameTip").css("color","red")
						userflag=false;
					}else{
						$(".userNameTip").html("账号可以使用")
						$(".userNameTip").css("color","green")
						userflag=true;
					}
				},"json");
			}else {
				$(".userNameTip").html("账号格式错误")
				$(".userNameTip").css("color","red")
				userflag=false;
			}

		});

		$("#password").blur(function () {
			var uPattern = /^[a-zA-Z0-9_-]{4,16}$/;//密码正则表达式,4到16位（字母，数字，下划线，减号）
			var password=$("#password").val();
			if(uPattern.test(password)){
				$(".userPasswordTip").html("");
				passflag=true;
			}else {
				$(".userPasswordTip").html("密码格式错误")
				$(".userPasswordTip").css("color","red")
				passflag=false;
			}
		})

		//检查两次密码
		$("#repassword").blur(function () {
			if(passflag){
				if($("#password").val()==$("#repassword").val()){
					passwordflag=true;
					$(".userRepasswordTip").html("密码正确");
					$(".userRepasswordTip").css("color","green")
				}else{
					$(".userRepasswordTip").html("两次输入的密码不同");
					$(".userPasswordTip").css("color","red")
					passwordflag=false;
				}
			}else{
				$(".userRepasswordTip").html("密码格式错误");
				$(".userPasswordTip").css("color","red")
				passwordflag=false;
			}
		})

		//提交表单，进行注册
		$("#formSubmit").click(function () {
			var formData=$("#registerForm").serialize();
			if(passwordflag&&userflag&&passwordflag){
				$.post("/register/register.do",formData,function (result) {
					if(result){
						$(".userCodeTip").css("display","none");
						$.session.set('username', $("#username").val())//生成session传递到主页
						window.location.href="index.jsp";//注册成功跳转到主页面
						alert("登录成功，点击跳转到主页")
					}else{
						$(".userCodeTip").css("display","inline");
					}
				},"json")
			}
		});
	//	点击图片验证码更换
		$("img").click(function () {
			$("img")[0].src="/register/generateCode.do?time=" + new Date().getTime();
		})
		
	});
</script>
</body>
</html>
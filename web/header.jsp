<%--
  Created by IntelliJ IDEA.
  User: 陈建伟chan
  Date: 2020/12/2
  Time: 14:48
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <link rel="stylesheet" href="css/header.css"/>
   <script type="text/javascript" src="js/jquery-3.1.1.min.js"></script>
    <script type="text/javascript" src="js/JquerySession.js"></script>


</head>
<body>
<!-- 头部 -->
<div class="top-nav">
    <div class="inner">
        <div class="inner-l" style="position: absolute;margin-left: 25px;padding-top: 8px">
            <a href="index.jsp">首页</a>
            <div style="margin-top: -27px;margin-left: 100px;font-size: 8pt;color: black" id="everyday">
                <span style="font-size: 14pt">每日一句：</span>
                <span>I could hear a dog barking.</span>
                <span>我听到犬吠声。</span>
            </div>
        </div>
        <div class="inner-r">
            <div class="box">
                <a href="javascript:;" id="login" class="to-login" style="margin-right: 20px;text-decoration: none">登录</a>
                <span id="welcome">欢迎光临</span>
                <a href="javascript:;" style="text-decoration: none;padding-top: 0px;color: blue" id="name">

                </a>

                <a href="register.jsp" style="padding-left: 25px;text-decoration: none" id="userRegister">【新用户注册】</a>
                <input id="exitUser" type="button" value="注销" style="color:red ;height:30px;line-height: 30px;background-color:transparent;border: 0px;">
                <div id="dialogBg"></div>
                <div id="dialog" class="animated" style="height: 270px">
                    <div class="dialogTop" style="height:25px;padding-top: 25px">
                        <a href="javascript:;" class="closeDialogBtn" style="text-decoration: none;">关闭</a>
                    </div>
                    <form action="" method="post" id="loginForm">
                        <ul class="editInfos">
                            <li>用户名：<input type="text" id="userName" name="username" class="ipt" style="height: 30px" placeholder="4到16位字母或数字组成"/></li>
                            <li>密&nbsp;&nbsp;&nbsp;码：<input type="password" id="userPass" name="password" class="ipt" style="height: 30px" placeholder="4到16位字母，数字，下划线，减号组成"/></li>
                            <li><span id="loginTip"></span></li>
                            <li><input type="submit" value="登录" class="submitBtn"/></li>
                        </ul>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
        $(function () {
            //阻止点击提交按钮就自动提交
            $("#loginForm")[0].addEventListener("submit",function (ev) {
                ev.preventDefault();
            });
            //显示弹框
            $('.box #login').click(function () {
                var className = $(this).attr('class');
                $('#dialogBg').fadeIn(300);
                $('#dialog').removeAttr('class').addClass('animated ' + className + '').fadeIn();
                $('#userName').focus();
                $("#j_fixedBar").hide();
            });

            //关闭弹窗
            $('.closeDialogBtn').click(function () {
                $('#dialogBg').fadeOut(300, function () {
                    $('#dialog').addClass('bounceOutUp').fadeOut();
                    $("#j_fixedBar").show();
                });
            });
            var username= $.session.get('username')//获取session,判断是否登录了
            if(username!=null){
                $("#login").html("")
                $("#name").html(username)
                $("#welcome").html("欢迎光临");
                $("#userRegister").html("")
            }else{
                $("#login").html("用户登录")
                $("#welcome").html("");
                $("#exitUser").val("")
            }
            //点击退出登录，即消除session
            $("#exitUser").click(function () {
                $.session.remove("username")
                window.location.href="index.jsp";
            })

        //    点击登陆
            $(".submitBtn").click(function () {
                var username=$("#userName").val();
                var password=$("#userPass").val();
                if(username==""||password==""){
                    $("#loginTip").html("账号和密码都不能为空")
                    $("#loginTip").css("color","red")
                }else{
                    $("#loginTip").html("")
                    var dataForm=$("#loginForm").serialize();
                    $.post("/login/login.do",dataForm,function (result) {
                        if(result){
                            $.session.set('username', $("#userName").val())//生成session
                            window.location.reload();//刷新页面
                        }else{
                            $("#loginTip").html("用户名或者密码不正确")
                            $("#loginTip").css("color","red")
                        }
                    },"json")
                }
            })
        //点击姓名跳转到修改界面
            $("#name").click(function () {
                window.location.href="update_info.jsp";
            })

        })


</script>
</body>
</html>

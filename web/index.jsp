<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
	<head>
		<meta charset="utf-8">
		<title>主页</title>
		<link rel="stylesheet"  href="css/bootstrap.css"/>
		<link rel="stylesheet" href="css/index.css"/>
		<script type="text/javascript" src="js/jquery-3.1.1.min.js"></script>
		<script type="text/javascript" src="js/bootstrap.js"></script>
		<style>

			#loading{
				animation:dongHua 2s linear infinite;
				margin-left: 200px;
				margin-top: -20px;
				display: none;
			}
			@keyframes dongHua {
				0% {
					transform: rotate(0deg);
				}
				100% {
					transform: rotate(360deg);
				}
			}
		</style>


	</head>
	<body style="background-image: url('/images/beijin.jpg');background-repeat: no-repeat;background-size:100% 100%;">
	<%@include file="header.jsp" %>
		<!-- 主体 -->
		<div class="main">
			<!-- 翻译 -->
			<div class="main_translate">
				<input type="text" id="search_txt" style="height: 25px;" placeholder="请输入您要查询的单词"/>
				<input type="button" id="search_btn" value="搜索" />
				<span style="margin-left: 50px;" id="search_result"></span>
				<img src="images/play.jpg" style="display: none;" id="playImg"/>
				<img src="images/b.jpg" width="20px" style="border-radius: 50%" id="loading">
			</div>
			<!-- 导航 -->
			 <div class="main_nav">
				  <ul class="nav nav-tabs" id="myTab" role="tablist" style="padding-left: 40%;">
				   <li class="nav-item" role="presentation">
				 	<a class="nav-link active" id="home-tab" data-toggle="tab" href="#home" role="tab" aria-controls="home" aria-selected="true">全部词库</a>
				   </li>
				   <li class="nav-item" role="presentation">
				 	<a class="nav-link" id="profile-tab" data-toggle="tab" href="#profile" role="tab" aria-controls="profile" aria-selected="false">我的词库</a>
				   </li>
				   <li class="nav-item" role="presentation">
				 	<a class="nav-link" id="contact-tab" data-toggle="tab" href="#contact" role="tab" aria-controls="contact" aria-selected="false">热门词库</a>
				   </li>
				 </ul>
				 <!-- 导航主体 -->
				 <div class="tab-content" id="myTabContent">
					 <!-- 全部词库 -->
				   <div class="tab-pane fade show active" id="home" role="tabpanel" aria-labelledby="home-tab">

				   </div>
						
						<!-- 我的词库 -->
				   <div class="tab-pane fade" id="profile" role="tabpanel" aria-labelledby="profile-tab" style="background: url(images/c.jpg) -40px -40px no-repeat;background-size: 112% 115%;padding: 50px;height: 550px">
					   <div class="my_content">
						   <div class="my_word">
							   <div class="my_word_top" style="width: 100%;height: 40%;">
								   <div class="top_title" style="padding-top: 25px;padding-left: 10px;">
									   <div style="width: 5px;background-color: blue;display: inline;padding-top: 0px;">&nbsp;</div>
									   <span style="font-size: 16pt;">今天需要学习的单词:</span>
									</div>
									<div class="top_content" id="my_today_word">
										今日已经背诵
									</div>
							   </div>
							   <hr />
							   <div class="my_word_bottom">
								   <div class="bottom_title" style="padding-top: 25px;padding-left: 10px;">
									   <div style="width: 5px;background-color: blue;display: inline;padding-top: 0px;">&nbsp;</div>
									   <span style="font-size: 16pt;">正在背诵的词表:<span style="color: #0000FF;" id="my_book">英语四级</span></span>
									</div>
									<div class="bottom_content">
										<div style="width: 100%;height: 100px;margin-top: 20px;">
											<input id="studyBtn" type="button" value="开始学习" style="color:blue ;background-color: white;margin-left: 15px;margin-top: 10px;" />
											<div class="progress" style="margin-top: 20px;background-color: transparent;width: 400px">
												<span style="margin-top: 10px;font-size: 10pt;width: 80px;margin-left: 10px">我的进度:</span>
												<div style="width: 300px;background-color: #0000FF;height: 25px;" id="my_progress_out">
													<div style="background-color: red;height: 25px;" id="my_progress_int"></div>
												</div>
												<span style="margin-top: 8px;" id="my_progress_ratio">50%</span>
											</div>
											<span style="margin-left: 200px;" id="my_recitation">2000</span>/<span id="my_total">1000</span>
										</div>
										
									</div>
							   </div>
						   </div>
						   <div class="my_detail" >
							   <img src="images/head.jpg" style="border-radius: 50%;margin-top: 10px;margin-left: 30px;"/>
							   <span style="color: red;font-size: 15pt;margin-left:40px;" id="my_username">admin</span>
							   <div style="font-size: 12pt;margin-top: 10px;text-align: center;">
								   <span>每天记忆</span><span style="color: red;" id="my_memory">10</span><span>个单词</span>
							   </div>
							   <input type="button" value="点击修改" style="width: 60px;height: 30px;margin-top: 20px;margin-left: 40px;" class="alterDetail"/>
						   </div>
						   <button  style="padding: 0px;border: 0px;;border-radius: 20px" onclick="window.open('game.jsp')"><img src="images/game.jpg"  style="width: 100px;"></button>
					   </div>
				   </div>
				   
				   <!-- 热门词库 -->
				   <div class="tab-pane fade" id="contact" role="tabpanel" aria-labelledby="contact-tab">
					   <!-- 模态框 -->

						 </button>
					   </div>
				   </div>
				 </div>
			<div style="width: 200px;height: 420px;position: absolute;top: 150px;right: 50px;border: 3px #b3d7ff solid" >
				<div style="background-color: #b3d7ff;width: 196px;height: 40px;margin-left: -1px;font-size: 15pt;line-height: 40px;text-align: center">
					最新动态
				</div>
				<div id="showusername" style="margin-top: 10px">
					<ul>
						<li style="margin-top: 20px">
							无人完成任务
						</li>
					</ul>
				</div>
			</div>
		</div>
			
			<!-- Modal -->
			<div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
			  <div class="modal-dialog">
			    <div class="modal-content">
			      <div class="modal-header">
			        <h5 class="modal-title" id="exampleModalLabel">是否修改当前的学习词表</h5>
			        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
			          <span aria-hidden="true">&times;</span>
			        </button>
			      </div>
			      <div class="modal-body">

			      </div>
			      <div class="modal-footer">
			        <button type="button" class="btn btn-secondary" data-dismiss="modal">取消</button>
			        <button type="button" class="btn btn-primary" data-dismiss="modal" id="editmybook">修改</button>
			      </div>
			    </div>
			  </div>
			</div>
		</div>
	</body>
</html>
		<script type="text/javascript">
		  $(function () {
		  	var flag=false;
			  //如果登录了，就获取username并将将今天未背诵的单词的语音获取到
			  var username= $.session.get('username')//获取session,判断是否登录了
			  if(username!=null){
			  	$.post("study/getVoice.do",{"username":username},function () {
				})
			  }

			  //点击跳转到学习界面
			  $("#studyBtn").click(function () {
				  if(username!=null&&username!=""){
					  window.location.href="study.jsp";
				  }else{
					  alert("请先登录")
				  }
			  })

			  $.post("/book/findHotBook.do",function (result) {
				  var html="";
				  for(var book of result){
					  html+="<button type=\"button\" class=\"btn btn-primary btn_book\" data-toggle=\"modal\" data-target=\"#exampleModal\" id=\""+book.bookname+"\">\n" +
							  "<span class=\"bookname\">"+book.bookname+"</span><br />\n" +
							  "<span class=\"bookword\">"+book.word+"</span>词汇<br />\n" +
							  "<span class=\"bookhot\">"+book.bookhot+"</span>人使用\n" +
							  "</button>"
				  }
				  $("#contact").html(html)
				  $('button').click(function(e){
					  var bookname=$(e.target).attr("id");
					  $(".modal-body").html(bookname)
					  $(".modal-body").css("font-size","15pt")
					  $(".btn-primary").click(function () {
						  var username= $.session.get('username')//获取session,判断是否登录了
						  if (username!=undefined&&username!=""){
							  flag=true;
						  } else {
							  alert("请先登录")
							  $("#login").click()
						  }
					  })
				  })
			  },"json")
			  $.post("/book/findAllBook.do",function (result) {
				  var html="";
				  for(var book of result){
						html+="<button type=\"button\" class=\"btn btn-primary btn_book\" data-toggle=\"modal\" data-target=\"#exampleModal\" id=\""+book.bookname+"\">\n" +
								"<span class=\"bookname\">"+book.bookname+"</span><br />\n" +
								"<span class=\"bookword\">"+book.word+"</span>词汇<br />\n" +
								"<span class=\"bookhot\">"+book.bookhot+"</span>人使用\n" +
								"</button>"
				  }
				  $("#home").html(html);
				  //获取当前点击的对象,不放在这里会产生点了也获取不了id
				  $('button').click(function(e){
					  var bookname=$(e.target).attr("id");
					  $(".modal-body").html(bookname)
					  $(".modal-body").css("font-size","15pt")
					  $(".btn-primary").click(function () {
						  var username= $.session.get('username')//获取session,判断是否登录了
						  if (username!=undefined&&username!=""){
							   flag=true;
						  } else {
							alert("请先登录")
							$("#login").click()
						  }
					  })
				  })

			  },"json")

			//  点击到修改页面
			$(".alterDetail").click(function(){
				if(username!=null&&username!=""){
					location.href="update_info.jsp"
				}else{
					alert("请先登录")
				}

			})
			  //点击查询
			  $("#search_btn").click(function () {
                  var word=$("#search_txt").val();
				  if(word==null||word==""){
					  alert("查询值不能为空");
				  }else{
				  	$("#loading").css("display","block")
					  $.post("/ai/translate.do",{"word":word},function (result) {
                        // alert(result)
						$("#loading").css("display","none")
                        $("#search_result").html(result)
                        $("#playImg").css("display","inline")

                  },"text")
				  }
			  })
			  //播放MP3
              $("#playImg").click(function () {
                  $.post("/ai/playMP3.do",function () {
                  })
              })

			  //点击我的词库
			  $("#profile-tab").click(function () {
				//  判断是否登录了
					  var username= $.session.get('username')//获取session,判断是否登录了
					  if (username!=undefined&&username!=""){
						  //修改用户名
						  $("#my_username").html(username)

						  //获取记忆模式
						  $.post("user/getUserDetailMemory.do",{"username":username},function (result) {
							  $("#my_memory").html(result.memory)
						  },"json")

						//  获取现在正在背诵的词表
						  $.post("user/getUserDetailBookname.do",{"username":username},function (result) {
								$("#my_book").html(result)
						  },"text")//中文得用text

						//  获取进度,即词库总词汇和已背词汇
						  $.post("user/getUserDetailProgress.do",{"username":username},function (result) {
							  var array=new Array();
							  array=result.split(",")//以逗号分割字符串，获取总单词量和已背单词量
							  var recitation= array[0]//已背单词量
							  var total=array[1]
							  $("#my_total").html(total)
							  $("#my_recitation").html(recitation)
							  $("#my_progress_ratio").html(recitation/total*100+"%")
							  $("#my_progress_int").css("width",recitation/total*300)
						  },"text")

						//  获取今天应该背的单词
						  $.post("user/getUserDetailTodayWord.do",{"username":username},function (result) {
							  if(result!=null&&result!=""){//如果传来的值不为空，则代表今天未背诵，将中文输入
								var html="<ul>"
								  for(var bookdetail of result){
									  html+="<li>"+bookdetail.word+"</li>"
								  }
								  html+="<ul>"
								  $("#my_today_word").html(html);
							  }else{//如果传来的值为空，则代表今天已经背诵，输出今日已经背诵
								  var html="<div style='font-size: 18pt;color: blue'>今日已经背诵</div>"
								  $("#my_today_word").html(html);
							  }

						  },"json")
					  } else {
						  alert("请先登录")
						  $("#login").click()
					  }

			  })
			  //点击修改按钮后就会进行修改
			  $("#editmybook").click(function () {
				  var username= $.session.get('username')//获取session,判断是否登录了
				  if (username!=undefined&&username!=""){
				  	var newbook=$(".modal-body").html()
					  $.post("/user/editUserBook.do",{"newbook":newbook,"username":username},function (result) {
					  },"json")
				  }
			  })
		  });
		  //获取最新动态
		  //假设每隔5秒发送一次请求
		  window.onload = function () {
		  	//获取所有用户
			  $.post("/user/getAllUser.do",function (result) {
				  getApi(result);
			  },"json")
		  }
		  var limit=0;
		  var limited=0;
		  function getApi(num) {
		  	var html="";
			  //设置时间 5-秒  1000-毫秒  这里设置你自己想要的时间
			  if(num>(limit+5)){
				  $.post("/user/getReadedUsername.do",{"limit":limit,"limited":limit+5},function (result) {
					  html+="<ul>"
					  for(var i=0;i<5;i++){
					  	html+="<li style=\"margin-top: 20px;color: white\">\n" +
								"<img src=\"images/head.jpg\" style=\"border-radius: 50%;height: 50px;display: inline\">\n" +
								""+'*'+result[i].slice(1,result[i].size)+"<br/><span style=\"margin-top: -20px;position: absolute;margin-left: 50px\">已完成今日的背诵任务</span>\n" +
								"</li>"
						  console.log(result[i])
					  }
					  html+="</ul>"
					  $("#showusername").html(html)
				  },"json")

				  limit=limit+5;
				  setTimeout("getApi("+num+")",10*1000);
			  }else {
				  limited=num-limit//获取小于多少
				  $.post("/user/getReadedUsername.do",{"limit":limit,"limited":limit+limited},function (result) {
					  html+="<ul>"
					  for(var i=0;i<limited;i++){
						  html+="<li style=\"margin-top: 20px;color: white\">\n" +
								  "<img src=\"images/head.jpg\" style=\"border-radius: 50%;height: 50px;display: inline\">\n" +
								  ""+'*'+result[i].slice(1,result[i].size)+"<br/><span style=\"margin-top: -20px;position: absolute;margin-left: 50px\">已完成今日的背诵任务</span>\n" +
								  "</li>"
					  }
					  html+="</ul>"
					  $("#showusername").html(html)
				  },"json")
				  limit=0;
				  setTimeout("getApi("+num+")",10*1000);
			  }

		  }

		</script>


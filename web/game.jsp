<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
	<head>
		<meta charset="utf-8">
		<title></title>
		<link rel="stylesheet" href="css/game.css" />
		<script type="text/javascript" src="js/jquery-3.1.1.min.js"></script>
		<script type="text/javascript" src="js/JquerySession.js"></script>
		<script>
			var username= $.session.get('username')//获取session,判断是否登录了
			// var englishword=["web","cat","dog","school"]
			var englishword= new Array();
			if(username!=null&&username!=""){
				$.post("/study/getGame.do",{"username":username},function (result) {
					var html="";
					var a=0;
					for(var bookdetail of result){
						html+="<span>"+bookdetail.word+":</span><div id=\"english\" class=\"english "+bookdetail.english+"\"></div><br/>"
						console.log(bookdetail.english)
						englishword[a]=bookdetail.english
						a++;
					}
					$("#word").html(html)

				},"json")
			}else{
				alert("请先登录")
				window.close();
			}

		</script>
	</head>
	<body>
		<div class="result">
			<div id="word" style="padding-left: 15px">
				<span>中文:</span><div id="english" class="english"></div><br/>
			</div>
			<input type="hidden" id="hidden"/>
		</div>
		<div class="content">
			<div class="btn">
				<div class="btn startBtn">
					<button>开始</button>
				</div>
				<div class="btn pauseBtn">
					<button>暂停</button>
				</div>
				<div id="snakeWrap">
				</div>
			</div>
		</div>
	</body>
	
	<script src="js/game.js"></script>
</html>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
	<head>
		<meta charset="utf-8">
		<title>学习页面</title>
		<link rel="stylesheet"  href="css/bootstrap.css"/>
		<script type="text/javascript" src="js/jquery-3.1.1.min.js"></script>
		<script type="text/javascript" src="js/bootstrap.bundle.js"></script>
		<script type="text/javascript" src="js/bootstrap.js"></script>
		<style>
			.content{
				margin: auto;
			}
			.carousel-inner{
				margin-left: 100px;
			}
			.carousel-item{
				width: 80%;
				padding-top: 100px;
				padding-bottom: 200px;
			}
			.dropdown{
				margin-top: -42px;
				margin-left:350px;
				
			}
			.dropdown-menu{
				min-width: 0px;
				margin: 0px;
				padding: 0px;
			}
			.dropdown-item{
				border: 1px solid green;
				width: 110px;
				color: green;
			}
		</style>
	</head>
	<body style="background-image: url('/images/beijin.jpg');background-repeat: no-repeat;background-size:100% 100%;">
	<%@include file="header.jsp" %>
		<div class="all" style="margin-top: 10%;">
			<div class="top" style="height: 40px;width: 500px;background-color: #a3c8ee;margin: auto;line-height: 40px;padding-left: 20px;">

				<!-- 单词测试 -->
				<div class="dropdown">
				  <button class="btn btn-secondary dropdown-toggle" type="button" id="dropdownMenuButton" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" style="background-color: green;margin-top: 3px">
				    开始测试
				  </button>
				  <div class="dropdown-menu" aria-labelledby="dropdownMenuButton">
				    <a class="dropdown-item" href="wordchange.jsp">单词挑战</a>
				    <a class="dropdown-item" href="wordrecall.jsp">英文回想</a>
				    <a class="dropdown-item" href="dictationchange.jsp">听写挑战</a>
				  </div>
				</div>
			</div>
			<div style="width: 500px;height: 400px;border: #000000 1px solid;background-color: #EEEEEE;" class="content">
					<div id="carouselExampleFade" class="carousel slide carousel-fade" data-interval="false" data-wrap="false">
					  <div class="carousel-inner" id="study_practice">

						</div>
						<a class="carousel-control-prev" href="#carouselExampleFade" role="button" data-slide="prev">
					      <span class="carousel-control-prev-icon" aria-hidden="true"></span>
					      <span class="sr-only">Previous</span>
					    </a>
					    <a class="carousel-control-next" href="#carouselExampleFade" role="button" data-slide="next">
					      <span class="carousel-control-next-icon" aria-hidden="true"></span>
					      <span class="sr-only">Next</span>
					    </a>
					</div>
				</div>

		</div>
	</body>
<script>
	$(function () {
		//点击获取学习的单词
		var username=$.session.get("username")
		$.post("/study/getStudyMyWord.do",{"username":username},function (result) {
				var html="";
				for (var bookDetail of result){
					html+="<div class=\"carousel-item\">\n" +
							"<div>\n" +
							"<span style=\"color: blue;font-size: 20pt;margin: 20px;\">"+bookDetail.english+"</span>\n" +
							"<span style=\"font-size: 15pt;margin-right: 20px;\">"+bookDetail.symbols+"</span>\n" +
							"<button onclick=\"voice('"+bookDetail.english+"')\" style=\"border: 0px;padding: 0px;margin: 0px\"><img src=\"images/play.jpg\" style=\"position:absolute;top: 80px;left: 50px\" /></button>\n"+
							"</div>\n" +
							"<div style=\"margin-top: 25px;margin-left: 25px;\">\n" +
							"释义:<span>"+bookDetail.wordclasses+"</span>\n" +
							"<span>"+bookDetail.word+"</span>\n" +
							"</div>\n" +
							"<div style=\"margin-top: 25px;margin-left: 25px;\">\n" +
							"例句:<span>"+bookDetail.example+"</span><br />\n" +
							"<span>"+bookDetail.exampleword+"</span>\n" +
							"</div>\n" +
							"</div>"
				}
				html+="<div class=\"carousel-item\">学习完成，点击右上角进行测试</div>"
				$("#study_practice").html(html)
			$(".carousel-item:first").addClass("active");
		},"json")

		$(".dropdown-menu").click(function () {
			$.post("/study/studyComplete.do",{"username":username},function (result) {

			})
		})
	})
	//点击播放语音
	function voice(name) {
		var MP3Name=name+"en";
		$.post("/study/PlayMP3.do",{"MP3Name":MP3Name},function (result) {
		})
	}
</script>
</html>

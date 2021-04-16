<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
	<head>
		<meta charset="utf-8">
		<title></title>
		<link rel="stylesheet"  href="css/bootstrap.css"/>
		<script type="text/javascript" src="js/jquery-3.1.1.min.js"></script>
		<script type="text/javascript" src="js/bootstrap.bundle.js"></script>
		<script type="text/javascript" src="js/bootstrap.js"></script>
	</head>
	<style>
		.content{
			margin: auto;
		}
		.carousel-inner{
			margin-left: 100px;
		}
		.carousel-item{
			width: 60%;	
			padding-top: 100px;
			padding-bottom: 200px;
		}
		.all .top button{
			height: 25px;font-size: 10pt;line-height: 10px;background-color: green;color: white;
		}
	</style>
	<body style="background-image: url('/images/beijin.jpg');background-repeat: no-repeat;background-size:100% 100%;">
	<%@include file="header.jsp" %>
		<div class="all" style="margin-top: 10%;">
				<div class="top" style="height: 40px;width: 500px;background-color: #a3c8ee;margin: auto;line-height: 40px;padding-left: 20px;padding-top: 10px">
					<button type="button" class="btn btn-secondary" data-toggle="tooltip" data-placement="right" title="点击回到学习页面" >
					  <a href="study.jsp" style="color: white;">单词测试</a>
					</button>
				</div>
				<div style="width: 500px;height: 400px;border: #000000 1px solid;background-color: #EEEEEE;" class="content">
						<div id="carouselExampleFade" class="carousel slide carousel-fade" data-interval="false" data-wrap="false">
						  <div class="carousel-inner" id="WordDictationchange">
							  <div class="carousel-item">
								  <div style="position: absolute;top: 50px;">
									  A spider had spun a perfect web outside the window.<br>
									  蜘蛛在窗外结了一张完整的网.
								  </div>
								  <div style="margin-top: 20px">
									  <span style="">['rekəɡnaɪz]</span>
									  <button style="padding: 0px;border: 0px;"><img src="images/play.jpg"></button>
								  </div>
								  <div style="position: absolute;top: 200px;">
									  <span style="position: absolute;top: 10px;">请输入正确的单词:</span>
									  <input type="text" style="margin-left: 140px;background-color: #EEEEEE;border-top: 0px;border-left: 0px;border-right: 0px;width: 100px;"/>
									  <input type="button" value="提交" style="border-radius: 20%;height: 30px;margin-left: 20px" id="submit" class="web,网状物,['rekəɡnaɪz]"/>
									  <span style="color: blue;font-size: 20pt;margin: 20px;display: block;margin-left: 170px;margin-top: 10px;">网状物</span>
								  </div>
							  </div>

							</div>
							<input type="button" value="下一题" style="border-radius: 20%;height: 30px;position: absolute;display: none;left: 350px;top: 200px;z-index:888;" id="nextquestion" />
							<input id="inputTxt" type="text" style="margin-left: 140px;background-color: #EEEEEE;border-top: 0px;border-left: 0px;border-right: 0px;width: 130px;position: absolute;top: 210px;margin-left: 220px;z-index: 2;"/>
						    <a class="carousel-control-next" href="#carouselExampleFade" role="button" data-slide="next" style="display: none;">
						      <span class="carousel-control-next-icon" aria-hidden="true"></span>
						      <span class="sr-only">Next</span>
							  <input type="button" id="next" />
						    </a>
						</div>
					</div>
				
			</div>
		
	</body>
	<script>
		var lastword="";
		$(function () {
			//点击获取学习的单词
			var username=$.session.get("username")
			$.post("/study/getStudyMyWord.do",{"username":username},function (result) {
				var html="";
				for(var bookDetail of result){
					html+=" <div class=\"carousel-item\">\n" +
							"<div style=\"position: absolute;top: 50px;display: none\" id='"+bookDetail.english+"ex"+"'>\n" +
							""+bookDetail.example+"<br>\n" +
							""+bookDetail.exampleword+"\n" +
							"</div>\n" +
							"<div style=\"margin-top: 20px\">\n" +
							"<span style='display: none' id='"+bookDetail.english+"sy"+"'>"+bookDetail.symbols+"</span>\n" +
							"<button onclick=\"PlayMP3('"+bookDetail.english+"')\" style='border: 0px;padding: 0px'><img src=\"images/play.jpg\" style=\"margin-left: 20px\" ></button>\n" +
							"</div>\n" +
							"<div style=\"position: absolute;top: 200px;\">\n" +
							"<span style=\"position: absolute;top: 10px;\">请输入正确的单词:</span>\n" +
							"<input type=\"text\" style=\"margin-left: 140px;background-color: #EEEEEE;border-top: 0px;border-left: 0px;border-right: 0px;width: 100px;\"/>\n" +
							"<input type=\"button\" value=\"提交\" style=\"border-radius: 20%;height: 30px;margin-left: 250px;z-index: 999;margin-top: -20px\" id=\""+bookDetail.english+"sub"+"\" onclick=\"subWord('"+bookDetail.english+"','"+bookDetail.answer+"')\"/>\n" +
							"<span style=\"color: blue;font-size: 20pt;margin: 20px;display: block;margin-left: 170px;margin-top: 10px;display: none\" id='"+bookDetail.english+"wo"+"'>"+bookDetail.word+"</span>\n" +
							"</div>\n" +
							"</div>"
					lastword=bookDetail.answer;
				}
				$("#WordDictationchange").html(html)
				$(".carousel-item:first").addClass("active");
			})

		})
		var sub="";

		function PlayMP3(name) {
			var MP3Name=name+"en";
			$.post("/study/PlayMP3.do",{"MP3Name":MP3Name},function (result) {
			})
		}
		var num=0;
		function subWord(word,answer) {
			if($("#inputTxt").val()==answer){
				if(lastword==answer){
					alert("学习完成,点击单词测试回到学习页面")
				}
				$("#"+word+"word"+"").css("display","inline")
				$("#"+word+"answer"+"").css("display","block")
				$("#"+word+"sub"+"").css('display','none')
				$("#"+word+"ex"+"").css("display","block")
				$("#"+word+"sy"+"").css("display","inline")
				$("#"+word+"wo"+"").css("display","inline")
				$("#nextquestion").css('display','inline-block')
				sub=word+"sub";
				num=0;
			}else{
				if(num==2){
					$("#"+word+"word"+"").css("display","inline")
					$("#"+word+"answer"+"").css("display","block")
					$("#"+word+"sub"+"").css('display','none')
					$("#nextquestion").css('display','inline-block')
					sub=word+"sub";
				}
				alert("输入错误")
				num++;
			}
		}
		$("#nextquestion").click(function(){
			$("#nextquestion").css('display','none')
			$("#"+sub+"").css('display','inline-block')
			$("#next").click();
		})
	</script>
</html>

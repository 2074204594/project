var sw=20,// 方块的宽
	sh=20,// 方块的高
	tr=30,// 行
	td=30;// 列
var snake=null;//蛇的实例
var food=null;//食物的实例
var game=null;//游戏的实例
var count=0;
var pos=[]//存储食物的坐标
var timer=-1;
var wordpos=[];
var wordcount=0;
var	snakepos=[[2,0],[1,0],[0,0]];//存储蛇身上的每一个方块的位置,二维数组

// 解析传入的单词数组
function getWord(){
	var count2=0;
	while(count2<englishword.length){
		var word=englishword[count2]
		count2++;
		wordpos=wordpos.concat(word)
	}
}
// 创建方块的构造函数
function Square(x,y,classname){//x,y是坐标,classname单立的样式
	// 用户传来的是 1 2 3,实际坐标0 20 40 ,所以需要转化
	this.x=x*sw;
	this.y=y*sh;
	this.class=classname;
	
	// 把数值转化为div
	this.viewContent=document.createElement('div');//方块对应的dom元素
	this.viewContent.className=this.class;//将创建的方块的类注入
	this.parent=document.getElementById('snakeWrap');// 方块对应的父级
}

// 添加方法
Square.prototype.create=function(d){//创建方块dom
	this.viewContent.style.position='absolute';//将方块变为相对定位
	this.viewContent.style.width=sw+'px';
	this.viewContent.style.height=sh+'px';
	this.viewContent.style.left=this.x+'px';
	this.viewContent.style.top=this.y+'px';
	// 食物的初始化在这里,如果不在这里将单词的第一个字母输入,会产生第一个字母不存在的现象
	if(d!=null){
		this.viewContent.innerHTML=d;
	}
	this.parent.appendChild(this.viewContent);//将方块创建到父元素上
}

// 添加一个方块的去除方法
Square.prototype.remove=function(){
	this.parent.removeChild(this.viewContent);//从方块的父元素上将方块去除
}

// 蛇   构造函数
function Snake(){
	this.head=null;//存一下蛇头信息
	this.tail=null;//存一下蛇尾信息
	this.directionNum={//存储蛇走的方向,用对象表示
		left:{
			x:-1,
			y:0,
			rotate:180//旋转蛇头
		},
		right:{
			x:1,
			y:0,
			rotate:0//旋转蛇头
		},
		up:{
			x:0,
			y:-1,
			rotate:-90//旋转蛇头
		},
		down:{
			x:0,
			y:1,
			rotate:90//旋转蛇头
		},
	}
}

// 蛇的初始化
Snake.prototype.init=function(flag,direction){
	if(!flag){
		// 创建蛇头
		var snakeHead=new Square(snakepos[0][0],snakepos[0][1],'snakeHead');//使用方块的构造函数建立一个蛇头
		snakeHead.create();//将方块创建出来
		this.head=snakeHead;//存储蛇头信息
		// snakepos.push([2,0]);//把蛇头的位置存起来
		
		// 创建蛇的身体1
		var snakeBody1=new Square(snakepos[1][0],snakepos[1][1],'snakeBody');
		snakeBody1.create();
		// snakepos.push([1,0]);//把蛇身1的位置存起来
		
		// 创建蛇的身体2
		var snakeBody2=new Square(snakepos[2][0],snakepos[2][1],'snakeBody');
		snakeBody2.create();
		this.tail=snakeBody2;
		// snakepos.push([0,0]);//把蛇身2的位置存起来
		
		
		// 形成链表关系
		snakeHead.last=null;//蛇头的下一个位置为空
		snakeHead.next=snakeBody1;//蛇头的上一个位置为身体1
		
		snakeBody1.last=snakeHead;//身体1的下一个位置为蛇头
		snakeBody1.next=snakeBody2;//身体1的上一个位置为身体2
		
		snakeBody2.last=snakeBody1;//身体2的下一个位置为身体1
		snakeBody2.next=null;//身体2的上一个位置为空
		
		// 给蛇添加一个属性，表示蛇走的方向
		this.direction=this.directionNum.right;//默认时蛇往右走
	}else{
		// 创建蛇头
		var snakeHead=new Square(snakepos[0][0],snakepos[0][1],'snakeHead');//使用方块的构造函数建立一个蛇头
		snakeHead.create();//将方块创建出来
		this.head=snakeHead;//存储蛇头信息
		
		var snakeBody1;
		var snakeBody2;
		for(var i=1;i<snakepos.length-1;i+=2){
			if(i==1){
				// 创建蛇的身体1
				snakeBody1=new Square(snakepos[i][0],snakepos[i][1],'snakeBody');
				snakeBody1.create();
				
				// 形成链表关系
				snakeHead.last=null;//蛇头的下一个位置为空
				snakeHead.next=snakeBody1;//蛇头的上一个位置为身体1
				snakeBody1.last=snakeHead;//身体1的下一个位置为蛇头
				// 创建蛇的身体2
				snakeBody2=new Square(snakepos[i+1][0],snakepos[i+1][1],'snakeBody');
				snakeBody2.create();
				
				snakeBody1.next=snakeBody2;//身体1的上一个位置为身体2
				snakeBody2.last=snakeBody1;//身体2的下一个位置为身体1
			}else{
				// 创建蛇的身体1
				snakeBody1=new Square(snakepos[i][0],snakepos[i][1],'snakeBody');
				snakeBody1.create();
				snakeBody2.next=snakeBody1;//身体2的下一个位置为身体1
				snakeBody1.last=snakeBody2;//身体1的上一个位置为身体2
				// 创建蛇的身体2
				snakeBody2=new Square(snakepos[i+1][0],snakepos[i+1][1],'snakeBody');
				snakeBody2.create();
				snakeBody1.next=snakeBody2;//身体1的上一个位置为身体2
				snakeBody2.last=snakeBody1;//身体2的下一个位置为身体1
			}
		}
		console.log(direction)
		console.log(this.directionNum.right)
		this.tail=snakeBody2;
		snakeBody2.next=null;//身体2的上一个位置为空
		// 给蛇添加一个属性，表示蛇走的方向
		this.direction=direction;//默认时蛇往右走
	}
}

// 为蛇添加一个方法，获取蛇头下一个位置对应的元素
Snake.prototype.getNextPos=function(){
	var nextPos=[
		// 判断方向并让指定坐标加1,即蛇头下一个点的坐标
		this.head.x/sw+this.direction.x,
		this.head.y/sh+this.direction.y
	]
	// console.log("nextPos:"+nextPos);
	//下个点是自己，代表撞到自己，gameover
	var selfCollied=false;//是否撞到自己
	snakepos.forEach(function(value){//value表示其中轮到的一项
	// console.log("value"+value[0]);
		if(value[0]==nextPos[0] && value[1]==nextPos[1]){
			// 表示撞到自己，未进入这里
			selfCollied=true;
		}
	});
	// 判断是否撞到自己
	if(selfCollied){
		console.log("撞到自己");
		// 撞到自己调用strategies函数里的die方法，并将this传过去
		this.strategies.die.call(this);
		return;
	}
	//下个点是围墙，代表撞到墙，gameover
	if(nextPos[0]<0 || nextPos[1]<0 || nextPos[0]>td-1 || nextPos[1]>tr-1 ){
		console.log("撞到墙了");
		this.strategies.die.call(this);
		return;
	}
	//下个点是食物，代表撞到食物，eat
	var nextfood= wordpos[wordcount];
	for(i=0;i<nextfood.length*3;i+=3){
		if(food && pos[i]==nextPos[0] && pos[i+1]==nextPos[1]){
			if(pos[i+2]!=""){
				// document.getElementById("english").innerHTML+=pos[i+2];
				document.getElementsByClassName(wordpos[wordcount])[0].innerHTML+=pos[i+2];
				pos.splice(i+2,1,"")
				this.strategies.eat.call(this);
				var losefood=new Square(this.head.x/sw,this.head.y/sh,'fooded',null);
				losefood.create()
				check.call(this)
				return;
			}
			else{
				this.strategies.move.call(this);
				var losefood=new Square(this.head.x/sw,this.head.y/sh,'fooded',null);
				losefood.create()
				check.call(this)
				return;
			}
		}
	}
	//下个点是空，go,把实例传递到strategies
	this.strategies.move.call(this);
}

function check(){
	if(document.getElementsByClassName(wordpos[wordcount])[0].innerHTML==wordpos[wordcount]){
		if(wordcount+1==englishword.length){
			alert("通过")
			location.reload();
		}
		clearInterval(timer);
		// 游戏回到初始状态
		var snakeWrap=document.getElementById('snakeWrap');
		snakeWrap.innerHTML='';
		count=0;
		pos=[];
		snake.init(true,this.direction)
		game=new Game();
		// document.getElementById("english").innerHTML=""
		if(wordcount<englishword.length){
			wordcount++;
		}else{
			alert("成功")
		}
		game.init();
	}
	if(document.getElementsByClassName(wordpos[wordcount])[0].innerHTMLlength==wordpos[wordcount].length&&document.getElementsByClassName(wordpos[wordcount])[0].innerHTML!=wordpos[wordcount]){
		console.log("单词错误");
		// 撞到自己调用strategies函数里的die方法，并将this传过去
		this.strategies.die.call(this);
	}
}

// 解决碰撞后的事件
Snake.prototype.strategies={
	// 走
	move:function(format){//这个参数用于判断删不删蛇尾
		// 创建一个新的身体，放在旧的蛇头
		var newBody=new Square(this.head.x/sw,this.head.y/sh,'snakeBody',null);
		// 更新列表
		newBody.next=this.head.next;
		newBody.next.last=newBody;
		newBody.last=null;
		// 去除旧的蛇头
		this.head.remove();
		newBody.create();
		// 新建一个蛇头,即下一个点
		var newHead=new Square(this.head.x/sw+this.direction.x,this.head.y/sh+this.direction.y,'snakeHead',null);
		// 更新列表
		newHead.next=newBody;
		newHead.last=null;
		newBody.last=newHead;
		// 蛇头扭转
		newHead.viewContent.style.transform='rotate('+this.direction.rotate+'deg)';
		newHead.create();
		// 更新每一个坐标pos
		snakepos.splice(0,0,[this.head.x/sw+this.direction.x,this.head.y/sh+this.direction.y]);//在pos的第一个插入newhead
		// console.log(pos)
		this.head=newHead;//更新蛇头
		if(!format){//format的值为false，表示没吃到食物，需要删除蛇尾
			this.tail.remove();
			this.tail=this.tail.last;//body1
			snakepos.pop();
		}
	},
	// 吃
	eat:function(){
		this.strategies.move.call(this,true);//this是把上一个的this传递过去
	},
	// gameover
	die:function(){
		game.over();
		console.log("die");
	}
}
snake=new Snake();
// 创建食物
function createFood(){
	var word=wordpos[wordcount];
	for(var i=0;i<word.length;i++){
		//食物的随机坐标
		var x=null;
		var y=null;
		var include=true;//循环跳出的条件,true表示随机生成的坐标在蛇身上
		while(include){
			x=Math.round(Math.random()*(td-1));//生成从0到29的随机数
			y=Math.round(Math.random()*(tr-1));
			// 获取蛇身上的所有坐标
			snakepos.forEach(function(value){
				if(x!=value[0]&&y!=value[1]){//比较xy的值
					include=false
				}	
			});
		}
		// 截取单词的字母并将其注入创建方块的方法中
		var d=word.substring(i,i+1);
		// 生成食物
		if(d!=""){//判断单词是否输入完毕
			food=new Square(x,y,'food')
			pos=pos.concat([x,y,d]);//存储食物坐标，用于判断是否吃到食物
			food.create(d);
		}
	}
}

// 创建控制游戏(操作游戏)
function Game(){
	timer=null;//定时器
}

Game.prototype.init=function(){
	getWord();
	createFood();
	
	console.log(pos)
	// 键盘事件
	document.onkeydown=function(ev){
		if(ev.which==37&&snake.direction!=snake.directionNum.right){//蛇在右的时候按左键没用
			snake.direction=snake.directionNum.left;
		}
		if(ev.which==38&&snake.direction!=snake.directionNum.down){
			snake.direction=snake.directionNum.up;
		}
		if(ev.which==39&&snake.direction!=snake.directionNum.left){
			snake.direction=snake.directionNum.right;
		}
		if(ev.which==40&&snake.direction!=snake.directionNum.up){
			snake.direction=snake.directionNum.down;
		}
	}
	this.start();
}
Game.prototype.start=function(){
	if(timer!=-1){
		// 开启定时器
		timer=setInterval(function(){
			// 获取下一个点
			snake.getNextPos();
		},200)
	}
}
Game.prototype.over=function(){
	clearInterval(timer);
	alert('游戏失败，重新开始游戏');
	// 游戏回到初始状态
	snakepos=[[2,0],[1,0],[0,0]];
	snake=new Snake();
	snake.init(true)
	var snakeWrap=document.getElementById('snakeWrap');
	snakeWrap.innerHTML='';
	count=0;
	pos=[];
	game=new Game();
	var startBtnWrap=document.querySelector('.startBtn');
	startBtnWrap.style.display='block';
	document.getElementsByClassName(wordpos[wordcount])[0].innerHTML=""
	
}

// 开始游戏
game=new Game();
var startBtn=document.querySelector('.startBtn button');
startBtn.onclick=function(){
	// 点击开始
	startBtn.parentNode.style.display='none';
	snake.init();
	game.init();
	
}
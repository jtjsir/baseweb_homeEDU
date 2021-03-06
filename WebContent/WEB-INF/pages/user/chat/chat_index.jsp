<%@page import="com.jing.edu.model.User"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%
	//全路径
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ request.getContextPath();

	//上下文路径
	String contextPath = request.getContextPath();
%>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width,initial-scale=1">
<link rel="stylesheet" type="text/css"
	href="<%=basePath%>/html/bootstrap/css/bootstrap.min.css">
<link rel="stylesheet" type="text/css"
	href="<%=basePath%>/html/common/common.css">
<link rel="stylesheet" type="text/css"
	href="<%=basePath%>/html/amazeui/assets/css/amazeui.min.css">
<link rel="stylesheet" type="text/css"
	href="<%=basePath%>/html/amazeui/assets/css/app.css">
<link rel="stylesheet" type="text/css"
	href="<%=basePath%>/html/umeditor/themes/default/css/umeditor.css">
<title>chat test</title>
<style>
body{
	background-image: url("/Home-Edu/images/pass/pattern.png");
}
.title {
	text-align: center;
}

.chat-content-container {
	height: 29rem;
	overflow-y: scroll;
	border: 1px solid silver;
}
</style>
</head>
<body>
	<!-- title start -->
	<div class="title">
		<div class="am-g am-g-fixed">
			<div class="am-u-sm-12">
				<h1 class="am-text-primary">在线聊天</h1>
			</div>
		</div>
	</div>
	<!-- title end -->
	<!-- chat content start -->
	<div class="chat-content">
		<div class="am-g am-g-fixed chat-content-container">
			<div class="am-u-sm-12">
				<ul id="message-list" class="am-comments-list am-comments-list-flip"></ul>
			</div>
		</div>
	</div>
	<!-- chat content start -->
	<!-- message input start -->
	<div class="message-input am-margin-top">
		<div class="am-g am-g-fixed">
			<div class="am-u-sm-12">
				<form class="am-form">
					<div class="am-form-group">
						<script type="text/html" id="myEditor"
							style="width: 100%;height: 8rem;"></script>
					</div>
				</form>
			</div>
		</div>
		<div class="am-g am-g-fixed am-margin-top">
			<div class="am-u-sm-6">
				<div id="message-input-nickname"
					class="am-input-group am-input-group-primary">
					<span class="am-input-group-label"><i class="am-icon-user"></i></span>
					<%
						String username = (String)request.getAttribute("from") ;
						if(username==null||"".equals(username)){
								username = "ROBOT" ;
						}
						 String toName = (String)request.getAttribute("to") ;
						 if(toName==null||"".equals(toName)){
							 toName = "ROBOT" ;
						 }
						String type = (String)request.getAttribute("type") ;
					%>
					<input id="username" type="text" class="am-form-field"
						value="<%=username%>" disabled/>
				</div>
			</div>
			<div class="am-u-sm-6">
				<button id="send" type="button" class="am-btn am-btn-primary">
					<i class="am-icon-send"></i> Send
				</button>
			</div>
		</div>
	</div>

	<script type="text/javascript"
		src="<%=basePath%>/html/bootstrap/js/jquery-1.11.1.min.js"></script>
	<!-- 加入umeditor相关js文件 -->
	<script type="text/javascript" charset="utf-8"
		src="<%=basePath%>/html/umeditor/umeditor.config.js"></script>
	<script type="text/javascript" charset="utf-8"
		src="<%=basePath%>/html/umeditor/umeditor.min.js"></script>
	<script type="text/javascript"
		src="<%=basePath%>/html/umeditor/lang/zh-cn/zh-cn.js"></script>
	<script type="text/javascript" src="<%=basePath %>/html/goeasy/goeasy.js"></script>
	<script type="text/javascript">
		$(function(){
			//实例化编辑器
			var um = UM.getEditor('myEditor') ;
			//使昵称框获取焦点
			$('#myEditor')[0].focus() ;
			
			//websocket页面端的调用
			var websk = new WebSocket("ws://localhost:8080/Home-Edu/chatserver/" + "<%=username + ">" + toName%>") ;
			//点击发送的事件
			$('#send').on('click',function(){
				var username = $('#username').val();
				if(!um.hasContents()){
					//判断输入框是否有内容
					$('#myEditor')[0].focus() ;
					//抖动效果
					 $('.edui-container').addClass('am-animation-shake');
			          setTimeout("$('.edui-container').removeClass('am-animation-shake')", 1000);
				}else{
					websk.send(JSON.stringify({
						content:um.getContent() ,
						username:username,
						toName:'<%=toName%>',
						requestType:'<%=type%>'
					}));
					//goeasy事件js
				//	var goEasy = new GoEasy({
					//	appkey:"04f5a023-63f6-477a-a933-a6dfa264fdda"
					//});
					//goEasy.publish({
						//channel:"channel_chat_jingtj",
						//message:um.getContent()
					//});
					//清空输入框内容
					um.setContent('') ;
					um.focus() ;
				}
			});
			//处理返回来的数据
			websk.onmessage = function(event){
				/* alert(event.data) ; */
				addMessage(event.data) ;
			}
			
			function addMessage(message){
				var jsonob = JSON.parse(message) ;
				//只有匹配自身的session或者接受者的session才显示内容
				if((jsonob.username=='<%=username%>'&&jsonob.toName=='<%=toName%>')||(jsonob.username=='<%=toName%>'&&jsonob.toName=='<%=username%>')){
					//设置图片路径
					var image_path = "<%=basePath%>/user/normal/" + jsonob.requestType + "/index?name=" + jsonob.username ;
					var combineMessage = '<li class="am-comment '
		        	    + (jsonob.isSelf ? 'am-comment-flip' : 'am-comment')
		            	+ '">'
		            	+ '<a href="javascript:void(0)" class="sendOb"><img src="<%=basePath%>/images/common/'
		            	+ ((('<%=type%>'==jsonob.requestType&&'<%=type%>'=='tea')||('<%=type%>'!=jsonob.requestType&&'<%=type%>'=='stu')) ? 'tea.jpg' : 'stu.jpg')
		            	+ '" alt="" class="am-comment-avatar" width="48" height="48"/></a>'
		            	+ '<div class="am-comment-main"><header class="am-comment-hd"><div class="am-comment-meta">'
		            	+ '<a href="javascript:void(0)" class="am-comment-author">'
		            	+ jsonob.username + '</a> <time>' + jsonob.datetime
		            	+ '</time></div></header>'
		            	+ '<div class="am-comment-bd">' + jsonob.content
		            	+ '</div></div></li>' ;
		            
		            	$(combineMessage).appendTo('#message-list') ;
		            	$('.sendOb').attr('href',image_path) ;
		         		// 把滚动条滚动到底部 scrollTop返回滚动条与所在顶部的距离,scrollHeight返回本身具有的高度
		            	$(".chat-content-container").scrollTop($(".chat-content-container")[0].scrollHeight);
				}
			}
			
		});
		
	</script>
</body>
</html>
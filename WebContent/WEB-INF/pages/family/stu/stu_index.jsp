<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@page import="com.jing.edu.model.User"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%
		//全路径
		String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + 
		request.getContextPath() ;
	
		//上下文路径
		String contextPath = request.getContextPath() ;
%>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width,initial-scale=1">
	<link rel="stylesheet" type="text/css" href="<%=basePath %>/css/bootstrap/css/bootstrap.min.css">
	<link rel="stylesheet" type="text/css" href="<%=basePath %>/css/common/common.css">
	<title>学生部营主页</title>
	<style type="text/css">
		.searchframe{
			width: 500px;
    		margin: 0 auto;
    		padding: 20px;
    		height: 57px;
		}
		.underline{
        	border: solid 1px #007;
        	margin:20px auto 2px auto;
        	width:90%;
        }
        .keyword_search{
        	height: 200px;
        	width:800px;
        }
        .keyword_search .theme{
        	height: 50px;
        }
        .keyword_search .theme .title{
        	float: left;
        	width:200px;
        	text-align: center;
        	padding-top: 20px;
   			padding-bottom: 9px;
   			color: mediumseagreen;
    		font-size: 15px;
        }
        .keyword_search .theme .content{
        	float: left;
        	width:600px;
        	padding-top: 20px;
        }
        .keyword_search .theme .content .city{
        	margin-right:15px;
        }
        .keyword_search .theme .content .grade{
        	margin-right:15px;
        }
        .keyword_search .theme .content .subject{
        	margin-right:15px;
        }
        .wrap_content{
        	height: 300px;
        }
         .wrap_content .infowrap{
        	text-align: center ;
        	padding-top:10px;
        	padding-left: 15px;
        	padding-bottom:10px;
        }
        .wrap_content .infoborder{
        	background-color:#ddd;
        	border:1px solid #5bc0de;
        }
        .wrap_content .infoborder:HOVER {
        	border:1px solid #000;
			background-color: #ccc;
		}
        .pagebtn{
        	height: 200px;
        	width:500px;
        	margin:0 auto;
        	text-align: center;
        }
	</style>
</head>
<body>
<div class="navbar navbar-default navbar-fixed-top" role="navigation">
	<div class="container">
		<div class="navbar-header">
			<button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#loginHeader" aria-expanded="false">
				<!--sr-only指代让辅助设备该提示的意思-->
				<span class="sr-only">切换导航</span>
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
			</button>
			<a href="#" class=""><img src="<%=basePath %>/images/common/welcome-small.gif" alt="welcome"
			 class="img-welcome"></a>
			 <span class="content">HOME_EDU</span>
		</div>
		<div id="loginHeader" class="collapse navbar-collapse">
			<ul class="nav navbar-nav">
				<li><a href="<%=basePath%>/index">首页</a></li>
				<li><a href="#">|</a></li>
				<li><a href="<%=basePath %>/family/index/tea">老师部营</a></li>
				<li><a href="#">|</a></li>
				<li><a href="<%=basePath %>/family/index/stu">学生部营</a></li>
				<li><a href="#">|</a></li>
				<li><a href="#">about us</a></li>
			</ul>
			<form class="nav navbar-right">
				<a href="<%=basePath %>/index/login" class="navbar-text" name="text1">登录</a>
				<span class="navbar-text">|</span>
				<a href="<%=basePath %>/index/register" class="navbar-text" name="text2">注册</a>
			</form>
		</div>
	</div>
</div>
<div class="container">
	<div class="underline"></div>
	<div class="searchframe">
		<div style="float:left;width: 390px;">
			<input type="text" placeholder="输入搜索的科目,比如:小学/小学语文" class="form-control">
		</div>
		<div style="float:left;padding-top: 2px;">
			<button class="btn btn-default btn-danger" id="searchBt"><span class="glyphicon glyphicon-search"></span></button>
		</div>
	</div>
	<div class="underline"></div>
	<div class="keyword_search">
		<div class="theme">
			<div class="title">
				<span>省份</span>
			</div>
			<div class="content">
				<span>浙江</span>
			</div>
		</div>
		<div class="theme">
			<div class="title">
				<span>市级</span>
			</div>
			<div class="content">
				<span class="city"><a class="active" id="hangzhou">杭州市</a></span>
				<span class="city"><a id="ningbo">宁波市</a></span>
				<span class="city"><a id="wenzhou">温州市</a></span>
				<span class="city"><a id="jiaxing">嘉兴市</a></span>
				<span class="city"><a id="huzhou">湖州市</a></span>
				<span class="city"><a id="shaoxing">绍兴市</a></span>
				<span class="city"><a id="jinhua">金华市</a></span>
				<span class="city"><a id="quzhou">衢州市</a></span>
				<span class="city"><a id="zhoushan">舟山市</a></span>
				<span class="city"><a id="taizhou">台州市</a></span>
				<span class="city"><a id="lishui">丽水市</a></span>
			</div>
		</div>
		<div class="theme">
			<div class="title">
				<span>年级</span>
			</div>
			<div class="content">
				<span class="grade"><a class="active" id="xiaoxue">小学</a></span>
				<span class="grade"><a id="chuzhong">初中</a></span>
				<span class="grade"><a id="gaozhong">高中</a></span>
			</div>
		</div>
		<div class="theme">
			<div class="title">
				<span>科目</span>
			</div>
			<div class="content">
				<div class="subjectcontent">
					<span class="subject"><a class="active" id="yuwen">语文</a></span>
					<span class="subject"><a id="shuxue">数学</a></span>
					<span class="subject"><a id="yingyu">英语</a></span>
				</div>
			</div>
		</div>
	</div>
	<div class="underline"></div>
	<div class="wrap_content">
		<div class="row infowrap"></div>
	</div>
	<div class="underline"></div>
	<div class="pagebtn">
		<div>
			<ul class="pagination">
				<li><a href="#"><<</a></li>
				<li><a href="#">>></a></li>
			</ul>
		</div>
	</div>
	<div class="underline"></div>
</div>
<div class="footer">
	<div class="bottom">Copyright &copy; 2015 by JingSir,All Right Reserved</div>
</div>
<script type="text/javascript" src="<%=basePath %>/css/bootstrap/js/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="<%=basePath %>/css/bootstrap/js/bootstrap.min.js"></script>
<script type="text/javascript">
	//共有的js代码
	$(function(){
		<%
			User user = (User)request.getSession().getAttribute("user") ;
			if(user!=null){
		%>
		//判断是否有用户已经登录
		var index_text1 = $('.navbar-right a[name="text1"]') ;
		var index_text2 = $('.navbar-right a[name="text2"]') ;
		index_text1.val(<%=user.getUsername()%>);
		index_text1.attr("href","<%=basePath%>/user/detail/tea/index") ;
		//退出返回到登录界面
		index_text2.val('退出');
		index_text2.attr("href","<%=basePath%>/login/out");
		<%
			}
		%>
});
</script>
<script type="text/javascript">
	$(function(){
		var contentDiv = $('.wrap_content .infowrap');
		
		//城市
		$('.keyword_search .theme .content .city a').click(function(event){
			var city= $(this).text() ;
			$.ajax({
				url:"/baseweb_homeEDU/family/stutea/infos",
				type:"GET",
				data:{
					city:city,
					userType:"stu",
					page:"1"
				},
				success:function(data){
					var stuOb = JSON.parse(data) ;
					//得到查询资源的条目数
					var stuLen = stuOb.size;
					if(stuLen===0){
						contentDiv.html("<p style='text-align: center;margin-top: 80px;font-size:24px;'>搜索的资源还未出现~~</p>");
						$('.pagebtn').html("<ul class='pagination'><li><a href='#'><<</a></li><li><a href='#'>>></a></li></ul>");
					}else{
						contentDiv.html('');
						var pageLen = Math.ceil((stuOb.count-1) / 4);
						if(stuLen>=4){
							stuLen = 4 ;
						}
						for(var i = 0;i < stuLen;i++){
							var str = "<div class='col-md-3 infoborder'>";
							var oneStu = stuOb.familys[i] ;
							str+="<a href='<%=basePath%>/user/normal/stu/index?name="+ oneStu.name + "'>" + "<img alt='还未上传头像' class='img-rounded' src='"+oneStu.imgpath+ "'>" + "</img>" + "</a>" 
							+ "<p>姓名:"+ oneStu.realname + "</p>"
							+ "<p>学历:"+ oneStu.level + "</p>"
							+ "<p>授课内容:"+ oneStu.subjects + "</p>"
							;
							str+="</div>" ;
							contentDiv.append(str) ;
						}
						//生成page标签页
						var pageStr = "<ul class='pagination'><li><a id='page_1'><<</a></li>" ;
						for(var j= 0 ; j < pageLen ; j++){
							pageStr+="<li><a id='page_" + (j+1) + "'>" +(j+1) +  "</a></li>" ;
						}
						pageStr+="<li><a id='page_" +pageLen  + "'>>></a></li></ul>" ;
						console.log(pageStr);
						$('.pagebtn').html('');
						$('.pagebtn').append(pageStr) ;
					}
				}
			});
		});
		
		//年级
		$('.keyword_search .theme .content .grade a').click(function(event){
			var grade= $(this).text()  ; 
			//通过ajax请求得到相应的数据内容
			$.ajax({
				url:"/baseweb_homeEDU/family/content/getsubject",
				type:"GET",
				data:{
					grade:grade
				},
				success:function(data){
					$('.keyword_search .theme .content .subjectcontent').html(data);
				}
			});
			$.ajax({
				url:"/baseweb_homeEDU/family/stutea/infos",
				type:"GET",
				data:{
					grade:grade,
					userType:"stu",
					page:"1"
				},
				success:function(data){
					var stuOb = JSON.parse(data) ;
					//得到查询资源的条目数
					var stuLen = stuOb.size;
					if(stuLen===0){
						contentDiv.html("<p style='text-align: center;margin-top: 80px;font-size:24px;'>搜索的资源还未出现~~</p>");
						$('.pagebtn').html("<ul class='pagination'><li><a href='#'><<</a></li><li><a href='#'>>></a></li></ul>");
					}else{
						contentDiv.html('');
						var pageLen = Math.ceil((stuOb.count-1) / 4);
						if(stuLen>=4){
							stuLen = 4 ;
						}
						for(var i = 0;i < stuLen;i++){
							var str = "<div class='col-md-3 infoborder'>";
							var oneStu = stuOb.familys[i] ;
							str+="<a href='<%=basePath%>/user/normal/stu/index?name="+ oneStu.name + "'>" + "<img alt='还未上传头像' class='img-rounded' src='"+oneStu.imgpath+ "'>" + "</img>" + "</a>" 
							+ "<p>姓名:"+ oneStu.realname + "</p>"
							+ "<p>学历:"+ oneStu.level + "</p>"
							+ "<p>授课内容:"+ oneStu.subjects + "</p>"
							;
							str+="</div>" ;
							contentDiv.append(str) ;
						}
						
						//生成page标签页
						var pageStr = "<ul class='pagination'><li><a id='page_1'><<</a></li>" ;
						for(var j= 0 ; j < pageLen ; j++){
							pageStr+="<li><a id='page_" + (j+1) + "'>" +(j+1) +  "</a></li>" ;
						}
						pageStr+="<li><a id='page_" +pageLen  + "'>>></a></li></ul>" ;
						console.log(pageStr);
						$('.pagebtn').html('');
						$('.pagebtn').append(pageStr) ;
					}
				}
			});
		});
		
		//科目
		$('.keyword_search .theme .content .subjectcontent').on('click','.subject a',function(event){
			var subject= $(this).text()  ;
			console.log(subject) ;
			$.ajax({
				url:"/baseweb_homeEDU/family/stutea/infos",
				type:"GET",
				data:{
					subject:subject,
					userType:"stu",
					page:"1"
				},
				success:function(data){
						console.log(data) ;
						var teaOb = JSON.parse(data) ;
						//得到查询资源的条目数
						var teaLen = teaOb.size;
						if(teaLen===0){
							contentDiv.html("<p style='text-align: center;margin-top: 80px;font-size:24px;'>搜索的资源还未出现~~</p>");
							$('.pagebtn').html("<ul class='pagination'><li><a href='#'><<</a></li><li><a href='#'>>></a></li></ul>");
						}else{
							contentDiv.html('');
							var pageLen = Math.ceil((teaOb.count-1) / 4);
							if(teaLen>=4){
								teaLen = 4 ;
							}
							for(var i = 0;i < teaLen;i++){
								var str = "<div class='col-md-3 infoborder'>";
								var oneTea = teaOb.familys[i] ;
								str+="<a href='<%=basePath%>/user/normal/stu/index?name="+ oneTea.name + "'>" + "<img alt='还未上传头像' class='img-rounded' src='"+oneTea.imgpath+ "'>" + "</img>" + "</a>" 
								+ "<p>姓名:"+ oneTea.realname + "</p>"
								+ "<p>学历:"+ oneTea.level + "</p>"
								+ "<p>授课内容:"+ oneTea.subjects + "</p>"
								;
								str+="</div>" ;
								contentDiv.append(str) ;
							}
							//生成page标签页
							var pageStr = "<ul class='pagination'><li><a id='page_1'><<</a></li>" ;
							for(var j= 0 ; j < pageLen ; j++){
								pageStr+="<li><a id='page_" + (j+1) + "'>" +(j+1) +  "</a></li>" ;
							}
							pageStr+="<li><a id='page_" +pageLen  + "'>>></a></li></ul>" ;
							console.log(pageStr);
							$('.pagebtn').html('');
							$('.pagebtn').append(pageStr) ;
						}
					}
			});
		});
	});
</script>
<script type="text/javascript">
	$(function(){
		//搜索框的点击事件
		$('.searchframe #searchBt').click(function(e){
			var content = $('.searchframe input').val();
			if(content===null||content===''){
				console.log('没有输入任何搜索信息') ;
			}else{
				$.ajax({
					url:"/baseweb_homeEDU/family/all/stutea/infos",
					data:{
						content:content,
						userType:"stu",
						page:"1"
					},
					type:"GET",
					success:function(data){
						var teaOb = JSON.parse(data) ;
						//得到查询资源的条目数
						var teaLen = teaOb.size;
						if(teaLen===0){
							$('.wrap_content .infowrap').html("<p style='text-align: center;margin-top: 80px;font-size:24px;'>搜索的资源还未出现~~</p>");
							$('.pagebtn').html("<ul class='pagination'><li><a href='#'><<</a></li><li><a href='#'>>></a></li></ul>");
						}else{
							$('.wrap_content .infowrap').html('');
							var pageLen = Math.ceil((teaOb.count-1) / 4);
							if(teaLen>=4){
								teaLen = 4 ;
							}
							for(var i = 0;i < teaLen;i++){
								var str = "<div class='col-md-3 infoborder'>";
								var oneTea = teaOb.familys[i] ;
								str+="<a href='<%=basePath%>/user/normal/stu/index?name="+ oneTea.name + "'>" + "<img alt='还未上传头像' class='img-rounded' src='"+oneTea.imgpath+ "'>" + "</img>" + "</a>" 
								+ "<p>姓名:"+ oneTea.realname + "</p>"
								+ "<p>学历:"+ oneTea.level + "</p>"
								+ "<p>授课内容:"+ oneTea.subjects + "</p>"
								;
								str+="</div>" ;
								$('.wrap_content .infowrap').append(str) ;
							}
							
							//生成page标签页
							var pageStr = "<ul class='pagination'><li><a id='page_1'><<</a></li>" ;
							for(var j= 0 ; j < pageLen ; j++){
								pageStr+="<li><a id='page_" + (j+1) + "'>" +(j+1) +  "</a></li>" ;
							}
							pageStr+="<li><a id='page_" +pageLen  + "'>>></a></li></ul>" ;
							console.log(pageStr);
							$('.pagebtn').html('');
							$('.pagebtn').append(pageStr) ;
						}	
					}
				});
			}
		});
		
		$('.pagebtn').on('click','a',function(event){
			var id = $(this).attr('id') ;
			var page = id.substring(id.indexOf('_') + 1,id.length) ;
			$.ajax({
				url:"/baseweb_homeEDU/family/stutea/infos",
				type:"GET",
				data:{
					userType:"stu",
					page:page
				},
				success:function(data){
					var teaOb = JSON.parse(data) ;
					//得到查询资源的条目数
					var teaLen = teaOb.size;
					if(teaLen===0){
						$('.wrap_content .infowrap').html("<p style='text-align: center;margin-top: 80px;font-size:24px;'>搜索的资源还未出现~~</p>");
						$('.pagebtn').html("<ul class='pagination'><li><a href='#'><<</a></li><li><a href='#'>>></a></li></ul>");
					}else{
						$('.wrap_content .infowrap').html('');
						var pageLen = Math.ceil((teaOb.count-1) / 4);
						if(teaLen>=4){
							teaLen = 4 ;
						}
						for(var i = 0;i < teaLen;i++){
							var str = "<div class='col-md-3 infoborder'>";
							var oneTea = teaOb.familys[i] ;
							str+="<a href='<%=basePath%>/user/normal/stu/index?name="+ oneTea.name + "'>" + "<img alt='还未上传头像' class='img-rounded' src='"+oneTea.imgpath+ "'>" + "</img>" + "</a>" 
							+ "<p>姓名:"+ oneTea.realname + "</p>"
							+ "<p>学历:"+ oneTea.level + "</p>"
							+ "<p>授课内容:"+ oneTea.subjects + "</p>"
							;
							str+="</div>" ;
							$('.wrap_content .infowrap').append(str) ;
						}
					}
				}
			});
		});
	});
</script>

</body>
</html>
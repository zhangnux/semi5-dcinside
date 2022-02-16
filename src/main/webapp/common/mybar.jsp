<%@page import="vo.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	User loginUserInfo = (User)session.getAttribute("LOGIN_USER_INFO");
 %>
<!DOCTYPE html>
<html lang="ko">
<style>
* {
  box-sizing: border-box;
}

body {
  margin: 0;
  background-color: white;
}

a,  a:hover, a:visited, a:active {
  text-decoration: none;
  outline: none;
}


.barText{
  text-decoration: none;
  color: white;
}

.dcwrap {
  display: flex;
  flex-direction: column;
}

.header {
  display: flex;
  height: 90px;
}

.head {
  display: flex;
  justify-content: space-between;
  align-items: center;
  width: 1160px;
  margin: 0 auto;
}

.logo {
  margin: 0;
}

.logo img {
  vertical-align: middle;
  height: 100%;
}

.head_list {
  display: flex;
  flex-direction: row;
  list-style: none;
  padding: 0;
  margin: 0;
}

.head_list a {
  color: #555;
  font-family: Dotum, "돋움", sans-serif;
  font-size: 14px;
}

.head_list li:first-child::before {
  display: none;
}

.head_list li::before {
  content: "|";
  font-size: 14px;
  padding: 0 5px 0 4px;
}

.head_list li:hover {
  text-decoration: underline;
}

.gnb_bar {
  display: flex;
  background-color: #3b4890;
}

.nav {
  width: 1160px;
  height: 44px;
  margin: 0 auto;
}

.nav_list {
  display: flex;
  flex-direction: row;
  align-items: center;
  list-style: none;
  color: white;
  font-family: Dotum, "돋움", sans-serif;
  font-weight: bold;
  font-size: 14px;
  height: 100%;
  padding: 0;
  margin: 0;
}

.nav_list li {
  margin-right: 20px;
}

.list_gall {
  color: #ffed44;
}

.nav_list li:hover :not(.list_gall) {
  text-decoration: underline;
}

.wrap_inner {
  display: flex;
  height: 707px;
}

.mainContainer {
  display: flex;
  flex-direction: row;
  justify-content: space-between;
  width: 1160px;
  margin: 17px auto 0;
}

.left_content {
  display: flex;
  flex-direction: column;
  width: 840px;
  height: 690px;
}

.hit_content {
  width: 840px;
  height: 162px;
  background-color: #ffe082;
}

.left_banner {
  width: 840px;
  height: 90px;
  margin-top: 15px;
  background-color: #ffe082;
}

.time_best {
  width: 840;
  height: 406px;
  margin-top: 17px;
  background-color: #ffe082;
}
.right_content {
  display: flex;
  flex-direction: column;
  width: 300px;
  height: 690px;
  background-color: #f8ffd7;
}

.login_box {
  width: 300px;
  height: 150px;
  border: 1px solid #29367c;
  background-color: #c5e1a5;
}

.gall_rank {
  width: 300px;
  height: 360px;
  margin-top: 15px;
  border: 1px solid #ccc;
  background-color: #c5e1a5;
}

.right_banner {
  width: 300px;
  height: 150px;
  margin-top: 15px;
  background-color: #c5e1a5;
}
.dcfoot {
  display: flex;
  flex-direction: column;
  margin-top: 23px;
}

.info_policy {
  display: flex;
  flex-direction: row;
  justify-content: center;
  align-items: flex-end;
  list-style: none;
  width: 1160px;
  height: 42px;
  margin: 0 auto;
  border-top: 0.5px solid #333;
}

.info_policy li:first-child::before {
  display: none;
}

.info_policy li::before {
  content: "|";
  font-size: 12px;
  color: #333;
  margin: 0 10px;
}

.info_policy a {
  font-size: 12px;
  font-family: Dotum, "돋움";
  color: #333;
}

.copyright {
  width: 1160px;
  margin: 10px auto 0;
  text-align: center;
  font-size: 12px;
  font-family: tahoma, sans-serif;
  color: #333;
}

@media screen and (max-width: 768px) {
  .head {
    flex-direction: column;
    justify-content: center;
    align-items: center;
  }
}

.btn {background-color: #3b4890;}
.coinTitle{color: #3b4890;}
</style>
<head>
	<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<link rel="stylesheet" href="dc_style.css">
	<title>## CONNECTING HEARTS! 디시인사이드입니다. ## </title>
</head>
<body>
	<div class="dcwrap">
		<header class="header">
			<div class="head">
				<h1 class="logo">
					<a href="https://www.dcinside.com/"><img src="../resources/images/dc_logo.png" alt="dc_logo"></a>
				</h1>
				<ul class="head_list">
					<li><a href="#">HIT 갤러리</a></li>
					<li><a href="#">실시간 베스트</a></li>
					<li><a href="#">실북갤</a></li>
			<%
				if(loginUserInfo==null){
			%>
				<li><a href="../login.jsp" class="btn btn-primary" style="height: 30px; width: 90px; color : white;">로그인</a></li>
			<%
			}else{
			%>
				<li><a href="../logout.jsp" class="btn btn-primary" style="height: 30px; width: 90px; color : white;">로그아웃</a></li>
			<%
			}
			%>
				</ul>
			</div>
		</header>
		<div class="gnb_bar">
			<nav class="nav">
				<ul class="nav_list">
					<li class="list_gall">갤러리</li>
					<li><a class="barText"href="#">동물, 기타</a></li>
					<li><a class="barText"href="#">디아블로</a></li>
					<li><a class="barText"href="#">주식</a></li>
					<li><a class="barText"href="#">축구</a></li>
					<li><a class="barText"href="../board/list.jsp?&categoryNo=5">코인</a></li>
					<li><a class="barText"href="#">핫플레이스</a></li>
				</ul>
			</nav>
		</div>
		</div>
	</body>
</html>
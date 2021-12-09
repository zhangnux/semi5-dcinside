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

.coinTitle{color: #3b4890;}

body {
  margin: 0;
  background-color: white;
}

a,  a:hover, a:visited, a:active {
  text-decoration: none;
  outline: none;
}

.bookmarkList{
 	 text-decoration: none;
 	 outline: none;
 	 color: #3b4890;
}

.barText{
  text-decoration: none;
  color: white;
}

.dcwrap {
  display: flex;
  flex-direction: column;
}

/* header */
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
/* 네비게이션 */
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

/* 본문 */

.wrap_inner {
  display: flex;
}

.container {
  display: flex;
  flex-direction: row;
  justify-content: space-between;
  width: 1160px;
  margin: 17px auto 0;
}

/* 좌측 컨텐츠 */

.left_content {
  display: flex;
  flex-direction: column;
  width: 840px;
}

.hit_content {
  width: 840px;
  height: 162px;
}

.hit_head {
  height: 34px;
  margin-bottom: 12px;
  border-bottom: 2px solid #29367c;
  padding-top: 1px;
}

.hit_head h3 {
  font-size: 14px;
  color: #29367c;
  font-family: Dotum, "돋움";
  margin: 0;
}

.hit_list {
  list-style-type: none;
  padding: 0 13px;
  margin: auto 0;
}

.hit_list li {
  font-size: 14px;
  margin-bottom: 11px;
}

.hit_list li::before {
  content: "\1F525";
  margin-right: 5px;
}

.hit_list a {
  color: #333;
}

.left_banner {
  width: 840px;
  height: 90px;
  margin-top: 15px;
}

.time_best {
  width: 840;
  margin-top: 17px;
}

.time_head {
  height: 44px;
  border-bottom: 2px solid #29367c;
  padding-top: 1px;
}

.time_head h3 {
  font-size: 14px;
  color: #29367c;
  font-family: Dotum, "돋움";
  margin: 0;
}

.time_list {
  position: relative;
  list-style: none;
  margin: 2px 0 0 0;
  padding: 0 0 2px 0;
  border-bottom: 1px #29367c solid;
}

.time_list a {
  color: #333;
}

.time_list li {
  display: flex;
  justify-content: space-between;
  align-items: center;
  font-family: Dotum, "돋움";
  height: 40px;
  border-top: 1px #e4e4e4 solid;
  padding: 2px 0;
}

.time_list li:first-child {
  border: none;
}

.test {
  display: inline-block;
  vertical-align: middle;
}

.time_list p {
  font-size: 14px;
  font-weight: bold;
  color: #333;
  margin: 0;
}

.best_info {
  font-size: 12px;
  color: #555;
  position: absolute;
  right: 0;
}

.date::before {
  content: "";
  display: inline-block;
  width: 1px;
  height: 9px;
  background: #aaa;
  margin: 0 6px;
}
/* 우측 컨텐츠 */

.right_content {
  display: flex;
  flex-direction: column;
  width: 300px;
}

.login_box {
  width: 300px;
  height: 150px;
  border: 1px solid #29367c;
  color: #333;
}

.log_inr {
  padding: 14px 0;
}

.login_process {
  height: 79px;
  padding: 0 14px;
}

.login_form {
  float: left;
}

.input_box label {
  display: none;
}

.pw {
  margin-top: 5px;
}

.input_text {
  width: 170px;
  height: 37px;
  padding: 0 3px 0 10px;
  font-size: 14px;
  color: #555;
}

.login_set {
  float: left;
  position: relative;
  height: 79px;
  margin-left: 7px;
}

.btn_login {
  position: absolute;
  bottom: 0;
  width: 93px;
  height: 37px;
  font-size: 14px;
  border: 1px solid #29367c;
  background: #3b4890;
  text-align: center;
  color: #fff;
  font-weight: bold;
  text-shadow: 0px 1px #1d2761;
}

.option {
  clear: left;
  margin: 14px 12px 0;
  padding-top: 13px;
  border-top: 1px dashed #aaa;
  text-align: center;
  font-size: 14px;
  font-family: Dotum, "돋움";
}

.page-item{
    text-decoration: none;
    outline: none;
}
.option a {
  color: #333;
}

.gall_rank {
  width: 300px;
  height: 360px;
  margin-top: 15px;
  padding: 0 13px 16px;
  border: 1px solid #ccc;
}

.gall_rank a {
  color: #333;
}

.rank_head {
  border-bottom: 1px dashed #aaa;
}

.gall_rank li {
  font-size: 14px;
  margin-bottom: 11px;
}

.rank_head h3 {
  height: 44px;
  line-height: 48px;
  font-size: 14px;
  margin: 0;
}

.rank_title {
  position: relative;
  padding-left: 20px;
}

.count {
  position: absolute;
  display: inline-block;
  right: 0;
}

.rank_title li::marker {
  color: #4f4dc6;
}

.rank_best {
  border-top: 1px dashed #aaa;
}

.rank_best ul {
  list-style: none;
  padding: 0;
}

.right_banner {
  width: 300px;
  height: 250px;
  margin-top: 15px;
}

/* footer */

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

/* 미디어 쿼리(반응형) */

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
					<a href="../index.jsp"><img src="../resources/images/dc_logo.png" alt="dc_logo"></a>
				</h1>
				<ul class="head_list">
					<li><a href="#">HIT 갤러리</a></li>
					<li><a href="#">실시간 베스트</a></li>
					<li><a href="#">실북갤</a></li>
				</ul>
			</div>
		</header>
		<div class="gnb_bar">
			<nav class="nav">
				<ul class="nav_list">
					<li class="list_gall">갤러리</li>
					<li><a class="barText"href="/semi5/1/list.jsp">동물, 기타</a></li>
					<li><a class="barText"href="/semi5/2/list.jsp">디아블로</a></li>
					<li><a class="barText"href="/semi5/3/list.jsp">주식</a></li>
					<li><a class="barText"href="/semi5/4/list.jsp">축구</a></li>
					<li><a class="barText"href="../5/list.jsp?categoryNo=5">코인</a></li>
					<li><a class="barText"href="/semi5/6/list.jsp">핫플레이스</a></li>
				</ul>
			</nav>
		</div>
		</div>
	</body>
</html>
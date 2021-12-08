<%@page import="vo.User"%>
<%@page import="dao2.BoardDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div class="login_box">	
<%
	User rightLoginUserInfo = (User)session.getAttribute("LOGIN_USER_INFO");

	if(rightLoginUserInfo==null){
%>
				
	<div class="log_inr">
		<form action="#" class="login_process" method="post">
			<div class="login_form">
				<div class="input_box">
					<label for="user_id">아이디</label>
					<input type="text" class="input_text" name="id" id="user_id" placeholder="아이디">
				</div>
				<div class="input_box pw">
					<label for="user_pw">비밀번호</label>
					<input type="password" class="input_text" name="password" id="user_pw" placeholder="비밀번호">
				</div>
			</div>
			<div class="login_set">
				<button type="submit" class="btn_login">로그인</button>
			</div>
		</form>
		<div class="option">
			<a href="#"><strong>회원가입</strong></a>
		</div>
	</div>

<%
	} else {
%>
	<!-- 로그인 상태 -->	
	<div class="user_info">
		<div class="user_inr">
			<div class="user_name">
				<strong>semip</strong>님
			</div>
			<div class="btn_logout">
				<a href="#">로그아웃</a>
			</div>
		</div>
		<div class="info_detail">
			<ul class="info_list">
				<li>글 <span><%=BoardDao.getInstance().getMyPostingCount(rightLoginUserInfo.getNo()) %></span></li>
				<li>댓글 <span><%=BoardDao.getInstance().getMyCommentCount(rightLoginUserInfo.getNo()) %></span></li>
				<li>즐겨찾기 <span>74</span></li>
			</ul>
		</div>
		<div class="user_option">
			<a href="http://localhost/semi5/gallog/myposting.jsp">MY갤로그</a>
		</div>
	</div>
<% } %>	
</div>
<article>
	<div class="gall_rank">
		<header class="rank_head">
			<h3>실북갤</h3>
		</header>
		<ol class="rank_title">
			<li><a href="#">동물, 기타갤러리</a><span class="count">113</span></li>
			<li><a href="#">디아블로 갤러리</a><span class="count">107</span></li>
			<li><a href="#">주식 갤러리</a><span class="count">95</span></li>
			<li><a href="#">축구 갤러리</a><span class="count">91</span></li>
			<li><a href="#">코인 갤러리</a><span class="count">83</span></li>
			<li><a href="#">핫플레이스 갤러리</a><span class="count">77</span></li>
		</ol>
	</div>	
</article>
<div class="right_banner">
	<img src="/semi5/resources/images/right_banner.jpg" alt="오른쪽 광고">
</div>
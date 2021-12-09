<%@page import="dao.BoardDao"%>
<%@page import="vo.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!doctype html>
<div class="login_box">
<%
	User rightLoginUserInfo = (User)session.getAttribute("LOGIN_USER_INFO");

	if(rightLoginUserInfo==null){
%>
				
	<div class="log_inr">
		<form action="http://localhost/semi5/login.jsp" class="login_process" method="post">
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
			<a href="http://localhost/semi5/registerform.jsp"><strong>회원가입</strong></a>
		</div>
	</div>

<%
	} else {
%>
	<!-- 로그인 상태 -->	
	<div class="user_info">
		<div class="user_inr">
			<div class="user_name">
				<strong><%=rightLoginUserInfo.getName() %></strong>님
			</div>
			<div class="btn_logout">
				<a href="http://localhost/semi5/logout.jsp">로그아웃</a>
			</div>
		</div>
		<div class="info_detail text-center">
			<ul class="info_list">
				<li>글 <span><%=BoardDao.getInstance().getMyPostingCount(rightLoginUserInfo.getNo()) %></span></li>
				<li>댓글 <span><%=BoardDao.getInstance().getMyCommentCount(rightLoginUserInfo.getNo()) %></span></li>
			</ul>
		</div>
		<div class="user_option">
			<a href="http://localhost/semi5/gallog/myposting.jsp">MY갤로그</a>
		</div>
	</div>
<% } %>	
</div>
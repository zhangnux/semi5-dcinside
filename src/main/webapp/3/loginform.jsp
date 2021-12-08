<%@page import="vo.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!doctype html>
<html lang="ko">
<head>
   <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
   <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" >
    <title>로그인폼</title>
</head>
<body>
<div class="container">    
	<div class="row mb-3">
		<div class="col">
		</div>
	</div>
	<div class="row">
		<div class="col-12">
<%
	String error = request.getParameter("error");

	if("empty".equals(error)){
%>		
		<div class= "alert alert-danger">
			<strong>로그인 실패</strong> 아이디와 비밀번호는 필수 입력값입니다.
		</div>
<%
	} else if ("notfound-user".equals(error)){
%>		
		<div class="alert alert-danger">
			<strong>로그인 실패</strong> 회원정보가 존재하지 않습니다.
		</div>	
<%
	} else if ("mismatch-password".equals(error)){
%>		
		<div class="alert alert-danger">
			<strong>로그인 실패</strong> 비밀번호가 일치하지 않습니다.
		</div>
<%
	} else if("login-required".equals(error)){
%>	
		<div class="alert alert-danger">
			<strong>로그인 필수</strong> 로그인이 필요한 페이지 입니다.
		</div>	
<%
	}
%>		
<%
	// System.out.println("얻은 섹션ID: " + session.getId() + "로그인한 사용자정보 객체: " + (User) session.getAttribute("LOGIN_USER_INFO"));
	User loginUserInfo = (User) session.getAttribute("LOGIN_USER_INFO");
	if (loginUserInfo == null) {
%>
	<!-- loginBox Start -->
	<div class="login_box">
		<div class="log_inr">
			<form action="login.jsp" class="login_process" method="post">
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
				<a href="registerForm.jsp"><strong>회원가입</strong></a>
			</div>
		</div>
	</div>
<%
	} else {
%> 
	<div class="login_box">
		<div class="user_info">
			<div class="user_inr">
				<div class="user_name">
					<strong><%=loginUserInfo.getName() %></strong>님
				</div>
				<div class="btn_logout">
					<a href="/semiProjectDC/logout.jsp">로그아웃</a>
				</div>
			</div>
			<div class="info_detail">
				<ul class="info_list">
					<li>글 <span>10</span></li>
					<li>댓글 <span>231</span></li>
					<li>즐겨찾기 <span>74</span></li>
				</ul>
			</div>
			<div class="user_option">
				<a href="#" target="_blank">MY갤로그</a>
			</div>
		</div>
	</div>
<%
	}
%> 
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
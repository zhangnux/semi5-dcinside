<%@page import="dao3.UserDao"%>
<%@page import="vo.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!doctype html>
<html lang="ko">
<head>
   <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
   <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" >
    <title></title>
</head>
<body>
<div class="container">    
<%
	pageContext.setAttribute("menu", "user");
%>
<%@include file="../common/navbar.jsp" %>
<div class="container">
	<div class="row">
		<div class="col">
			<h3>사용자 상세정보</h3>
		</div>
	</div>
	<div class="row">
		<div class="col">
<%
	User loginUserInfo = (User) session.getAttribute("LOGIN_USER_INFO");
	if(loginUserInfo == null){
		response.sendRedirect("loginform.jsp?error=login-required");		
		return;
	}
		UserDao userDao = UserDao.getInstance();
		User user = userDao.getUserByNo(loginUserInfo.getNo());
%>
			<table class="table">
				<tbody>
					<tr>
						<th class="col-2">번호</th>
						<td class="col-4"><%=user.getNo() %></td>
						<th class="col-2">가입일</th>
						<td class="col-2"><%=user.getCreateDate() %></td>
					</tr>
					<tr>
						<th class="col-2">아이디</th>
						<td class="col-4"><%=user.getId() %></td>
						<th class="col-2">이름</th>
						<td class="col-4"><%=user.getName() %></td>
					</tr>
					<tr>
						<th class="col-2">전화번호</th>
						<td class="col-4"><%=user.getTel() %></td>
						<th class="col-2">이메일</th>
						<td class="col-2"><%=user.getEmail() %></td>
					</tr>
				</tbody>
			</table>
		</div>
	</div>
</div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
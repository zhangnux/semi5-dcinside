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
	String error = request.getParameter("error");
%>
<%
	if("id-exists".equals(error)){
		
%>
	<div class="alert alert-danger">
		<strong>회원가입 실패</strong> 이미 사용중인 아이디입니다.
	</div>	
<%
	} else if ("email-exists".equals(error)){
%>
		<div class="alert alert-danger">
			<strong>회원가입 실패</strong> 이미 사용중인 이메일입니다.
		</div>
<% 		
	}
%>	
		<form class="border p-3 bg-light"  method="post" action="register.jsp">
			<div class="mb-3">
				<label>아이디</label>
				<input type="text" class="form-control" name="id" id="user-id">
			</div>
			<div class="mb-3">
				<label>비밀번호</label>
				<input type="password" class="form-control" name="password" id="user-password">
			</div>
			<div class="mb-3">
				<label>이름</label>
				<input type="text" class="form-control" name="name" id="user-name">
			</div>
			<div class="mb-3">
				<label>전화번호</label>
				<input type="text" class="form-control" name="tel" id="user-tel">
			</div>
			<div class="mb-3">
				<label>이메일</label>
				<input type="text" class="form-control" name="email" id="user-email">
			</div>
			<div class="mb-3 text-end">
				<button type = "submit" class="btn btn-primary">회원가입</button>
			</div>
		</form>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
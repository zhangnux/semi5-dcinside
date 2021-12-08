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
	<div class="row mb-3">
		<div class="col">
			<h1 class="fs-3">회원가입 폼</h1>
		</div>
	</div>
	<div class="row">
		<div class="col-5 p-1">
			<form class="border p-3 bg-warning" action="register.jsp" method="post">
<%	
	String error = request.getParameter("error");
	
	if ("id-exists".equals(error)){
%>
		<div class="alert alert-danger" role="alert">
		  존재하는 아이디입니다.
		</div>		
<%		
	}
	
	if ("email-exists".equals(error)){
%>
			<div class="alert alert-danger" role="alert">
			  이미 가입된 이메일입니다.
			</div>		
<%		
		}
%>			
				<div class="mb-3">
					<label class="form-label" for="user-id">아이디</label>
					<input type="text" class="form-control" name="id" id="user-id">
				</div>
				<div class="mb-3">
					<label class="form-label" for="user-password">비밀번호</label>
					<input type="password" class="form-control" name="password" id="user-password">
				</div>
				<div class="mb-3">
					<label class="form-label" for="user-name">이름</label>
					<input type="text" class="form-control" name="name" id="user-name">
				</div>
				<div class="mb-3">
					<label class="form-label" for="user-tel">전화번호</label>
					<input type="text" class="form-control" name="tel" id="user-tel">
				</div>
				<div class="mb-3">
					<label class="form-label" for="user-email">이메일</label>
					<input type="email" class="form-control" name="email" id="user-email">
				</div>
				<div class="text-end">
					<button class="btn btn-primary" type="submit">회원가입</button>
				</div>
				
			</form>
		</div>
	</div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
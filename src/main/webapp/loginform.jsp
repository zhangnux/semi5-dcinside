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
	<div class="row">
		<div class="col">
			<h3>로그인 폼</h3>
		</div>
	</div>
	<div class="row">
		<div class="col-5">
			<form class="border p-3 bg-info" action="login.jsp" method="post">
<%
	String error = request.getParameter("error");

	if ("empty".equals(error)){
%>
		<div class="alert alert-danger" role="alert">
		  아이디를 입력해주세요
		</div>
<%
	}
	
	if ("emptyt".equals(error)) {
%>
		<div class="alert alert-danger" role="alert">
		  비밀번호를 입력해주세요
		</div>
<%	
	}

	if ("not-found-user".equals(error)){
%>
		<div class="alert alert-danger" role="alert">
		  없는 아이디입니다.
		</div>		
<%	
	}
	
	if ("mismatch-password".equals(error)){
%>
		<div class="alert alert-danger" role="alert">
		  틀린 비밀번호입니다.
		</div>		
<%		
	}

	if ("noLogin".equals(error)){
%>
		<div class="alert alert-danger" role="alert">
		  로그인이 필요합니다.
		</div>		
<%		
	}
%>
				<div class="mb-3">
					<label class="form-label" for="user-id">아이디</label>
					<input type="text" class="form-control" name="id" id="user-id">
				</div>
				
				<div class="mb-3">
					<label class="form-label" for="user-password">패스워드</label>
					<input type="password" class="form-control" name="password" id="user-password">
				</div>
				
				<div class="mb-3 text-end">
					<button type="submit" class="btn btn-primary">로그인</button>
				</div>
				
			</form>
		</div>
	</div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
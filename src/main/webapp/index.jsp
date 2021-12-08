<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!doctype html>
<html lang="ko">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" >
	<link rel = "stylesheet" href="common/style.css">
	<script src="https://kit.fontawesome.com/d94ff6bbbc.js" crossorigin="anonymous"></script>
	<title>## CONNECTING HEARTS! 디시인사이드입니다. ## </title>
</head>
<body>
	<div class="dcwrap">
	<%@include file="common/navbar.jsp" %>
		<div class="wrap_inner">
			<main class="dc_container">
				<section class="left_content"> 
				<!-- 깃허브 업데이트 연습 -->
					<div class="row">
						<div class="col-5">
				<%
					String register = request.getParameter("register");
					if("completed".equals(register)){
				%>
						<div class="alert alert-primary" role="alert">
						  회원가입이 완료되었습니다
						</div>			
				<%
					}
				%>
				<%@include file="common/hitMain.jsp" %>
							<h1>디씨인사이드</h1>	
							<div>
								<a href="loginform.jsp">로그인</a>
								<a href="registerform.jsp">회원가입</a>
								<a href="1/list.jsp">게시판</a>
							</div>
						</div>
					</div>
				</section>
				<section class="right_content">
					<%@include file="common/right_section.jsp" %>
				</section>
			</main>
		</div>
		<%@include file="common/footer.jsp" %>
	</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
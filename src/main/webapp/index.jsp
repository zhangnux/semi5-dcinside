<%@page import="dao6.HotplaceBoardDao"%>
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
					<div class="row">
						<div class="col">
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
						</div>
					</div>
					<div class="row">
						<div class="col">
							<div class="left_banner">
								<img src="resources/images/left_banner.png" alt="왼쪽 광고">
							</div>
						</div>
					</div>
					<article class="row">
						<div class="col">
							<div class="time_best">
								<header class="time_head">
									<h3>베스트 갤러리</h3>
								</header>
								<ul class="time_list">
								<%
									HotplaceBoardDao HotplaceboardDao = HotplaceBoardDao.getInstance();
									List<Board> boards = HotplaceboardDao.getBoardsRankByVeiwCount();
									for (Board board : boards) {
								%>
									<li>
										<a href="<%=board.getTypeCode() %>/detail.jsp?no=<%=board.getNo() %>"><p><%=board.getTitle() %></p></a>
										<div class="best_info">
											<span class="gall_name"><%=board.getTypeName() %></span>
											<span class="date"><%=board.getCreatedDate() %></span>
										</div>	
									</li>
								<% 
									}
								%>
								</ul>
							</div>
						</div>
					</article>
				</section>
				<section class="right_content">
					<%@include file="common/right_section.jsp" %>
				</section>
			</main>
		</div>
		<%@include file="common/footer.jsp" %>
	</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
<script type="text/javascript">
<%
String error = request.getParameter("error");

if ("empty".equals(error)){
%>
	alert('아이디를 입력해주세요')
<%
}

if ("emptyt".equals(error)) {
%>
alert('비밀번호를 입력해주세요')
<%	
}

if ("not-found-user".equals(error)){
%>
alert('없는 아이디입니다.')
	
<%	
}

if ("mismatch-password".equals(error)){
%>
alert('틀린 비밀번호입니다.')
	
<%		
}

if ("noLogin".equals(error)){
%>
alert('로그인이 필요합니다.')
	
<%		
}
%>
</script>
</body>
</html>
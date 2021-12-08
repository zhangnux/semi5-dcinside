<%@page import="vo.Board"%>
<%@page import="vo.User"%>
<%@page import="dao6.HotPlaceBoardDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!doctype html>
<html lang="ko">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" >
	<link rel = "stylesheet" href="../common/style.css">
	<title>## CONNECTING HEARTS! 디시인사이드입니다. ## </title>
</head>
<body>
	<!-- wrap Start-->
	<div class="dcwrap">
		<!-- navbar Start-->
		<%@ include file="/common/navbar.jsp" %>
		<!-- navbar End-->
<%
User loginUserInfoByInsertFrom = (User) session.getAttribute("LOGIN_USER_INFO");
	String currentPageNo = request.getParameter("cpno"); 
	
	if (loginUserInfoByInsertFrom == null) {
		response.sendRedirect("../index.jsp?error=required");
	}
%>
		<!-- wrap_inner Start-->
		<div class="wrap_inner">
			<main class="dc_container">
			<!-- left contents Start -->
			<section class="left_content">
				<div class="row">
					<div class="col mb-2 mt-2">
						<h2>핫플레이스 갤러리</h2>
					</div>
				</div>
				<div class="row">
					<div class="col">
						<form method="post" action="insertRegister.jsp">
							<div class="mb-3">
								<input type="text" class="form-control" name="title" placeholder="제목을 입력하세요" />
								<div class="form-text">※음란물, 차별, 비하, 혐오 및 초상권, 저작권 침해 게시물은 민, 형사상의 책임을 질 수 있습니다.</div>
							</div>
							<div class="mb-3">
								<textarea rows="20" class="content form-control" name="content" style="resize: none;"></textarea>
							</div>
							
							<div class="mb-3 text-end">
								<a href="list.jsp?cpno=<%=currentPageNo%>" type="button" class="btn btn-secondary">취소</a>
								<button type="submit" class="btn btn-primary ">등록</button>
							</div>
						</form>
					</div>
				</div>
			</section>
			<!-- left contents End -->
			
			<!-- right content Start -->
			<section class="right_content">
				<%@include file="/common/right_section.jsp" %>
			</section>
			<!-- right content End -->
			</main>
		</div>
		<!-- wrap_inner End-->
	</div>
	<!-- wrap End-->	
</body>
<!-- footer Start -->
<%@ include file="/common/footer.jsp" %>
<!-- footer End -->

<!-- script -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</html>
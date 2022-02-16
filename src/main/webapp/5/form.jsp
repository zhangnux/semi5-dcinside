<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!doctype html>
<html lang="ko">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" >
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">	
	<link rel = "stylesheet" href="../common/style.css">
	<title>## CONNECTING HEARTS! 디시인사이드입니다. ## </title>
</head>
<body>
<%
	// include 시킨 navbar의 nav-item 중에서 페이지에 해당하는 nav-item를 active 시키기위해서 "menu"라는 이름으로 페이지이름을 속성으로 저장한다.
	// pageContext에 menu라는 이름으로 설정한 속성값은 navbar.jsp의 6번째 라인에서 조회해서 navbar의 메뉴들 중 하나를 active 시키기 위해서 읽어간다.
	pageContext.setAttribute("menu", "board");
%>
<%
	//로그인한 사용자정보가 세션에 존재하지 않으면 입력폼을 요청할 수 없다.
	// 클라이언트에게 로그인 정보를 입력하는 loginform.jsp를 재요청하는 응답을 보낸다.
	// 재요청 URL에 오류원인을 포함시킨다.
	
	//if (loginUserInfo == null) {
	//	response.sendRedirect("../loginform.jsp?error=login-required");
	//	return;
	//}
%>
<div class="dcwrap">
	<%@include file="/common/navbar.jsp" %>
		<div class="wrap_inner">
			<main class="dc_container">
				<section class="left_content">

	
	<div class="row mb-3 mt-5">
		<div class="col">
<%
	// form.jsp에서는 요청객체에서 요청파라미터값 error을 조회한다.
	// 새 글 링크를 눌러서 form.jsp를 요청하는 경우에는 요청파라미터 error값이 존재하지 않는다.
	// 새 글 등록에 실패한 경우에만 form.jsp를 요청할 때 생성한 요청객체에 요청파라미터로 error값이 존재한다.
	String error = request.getParameter("error");

	if ("empty-title".equals(error)) {
%>
			<div class="alert alert-danger">
				<strong>게시글 등록 실패!!</strong> 게시글 제목은 필수입력값입니다.
			</div>
<%
	} else if ("empty-content".equals(error)) {
%>
			<div class="alert alert-danger">
				<strong>게시글 등록 실패!!</strong> 게시글 내용은 필수입력값입니다.
			</div>
<%
	}
%>
			<!-- 
				게시글 정보 입력폼이다.
				title, content 정보를 입력받아서 register.jsp로 제출한다.
				register.jsp에서 게시글을 등록하고, 오류가 발생하면 이 페이지를 재요청하는 URL을 응답으로 보낸다.
				register.jsp에서 게시글 등록이 완료되면, list.jsp를 재요청하는 URL을 클라이언트에 응답으로 보낸다. 
			 -->
			<div class="row">
				<div class="col">
					<form class="border p-3" method="post" action="register.jsp">
						<div class="mb-3">
							<input type="text" class="form-control" name="title" placeholder="제목을 입력하세요" />
							<div class="form-text">※음란물, 차별, 비하, 혐오 및 초상권, 저작권 침해 게시물은 민, 형사상의 책임을 질 수 있습니다.</div>
						</div>
						<div class="mb-3">
							<textarea rows="20" class="form-control" name="content" style="resize: none;"></textarea>
						</div>
						<div class="mb-3 text-end">
							<a href="list.jsp?categoryNo=1" class="btn btn-secondary">취소</a>
							<button type="submit" class="btn btn-primary">등록</button>
						</div>
					</form>
				</div>
			</div>

				</div>
			</div>
		</section>
		<section class="right_content">
			<%@include file="/common/right_section.jsp" %>
		</section>
	</main>
</div>
		<%@include file="/common/footer.jsp" %>
	</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

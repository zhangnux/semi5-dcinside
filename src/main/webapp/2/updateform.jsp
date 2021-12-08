<%@page import="vo.User"%>
<%@page import="vo.Board"%>
<%@page import="dao2.DiabloBoardDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
<%
DiabloBoardDao boardDao = DiabloBoardDao.getInstance();
	int no = Integer.parseInt(request.getParameter("no"));
	Board board = boardDao.getBoardDetail(no);
	
	String content = board.getContent();
	content = content.replace("<br>", "\r\n");
	
	User loginUserInfo = (User)session.getAttribute("LOGIN_USER_INFO");
	
	if(loginUserInfo == null){
		response.sendRedirect("../loginform.jsp?error=noLogin");
		return;
	}
%>
	<div class="dcwrap">
	<%@include file="/common/navbar.jsp" %>
		<div class="wrap_inner">
			<main class="dc_container">
				<section class="left_content">
			<div class="row">
				<div class="col mb-4 mt-2">
					<h2>디아블로 갤러리</h2>
				</div>
			</div>
			<div class="row">
				<div class="col">
					<form class="border p-3" method="post" action="register.jsp">
						<div class="mb-3">
							<input type="text" class="form-control" name="title" value=<%=board.getTitle()%> />
							<div class="form-text">※음란물, 차별, 비하, 혐오 및 초상권, 저작권 침해 게시물은 민, 형사상의 책임을 질 수 있습니다.</div>
						</div>
						<div class="mb-3">
							<textarea rows="20" class="form-control" name="content" style="resize: none;"><%=content%></textarea>
						</div>
						<div class="mb-3 text-end">
							<button type="button" class="btn btn-secondary" data-bs-toggle="modal" data-bs-target="#cancelConfirm">취소</button>
							<button type="submit" class="btn btn-primary ">등록</button>
						</div>
					</form>
				</div>
			</div>
				<!-- 취소 재확인 모달창 -->
				<div class="modal fade" id="cancelConfirm" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
				  <div class="modal-dialog modal-dialog-centered">
				    <div class="modal-content">
				      <div class="modal-header">
				        <h6 class="modal-title" id="exampleModalLabel">글쓰기</h6>
				        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
				      </div>
				      <div class="modal-body">
				        글 작성을 취소하시겠습니까?
				      </div>
				      <div class="modal-footer">
				        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
				        <a class="btn btn-primary" href="list.jsp">확인</a>
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
<script type="text/javascript">
<%
	String error = request.getParameter("error");
	if("title".equals(error)){
%>
	alert('제목을 입력하세요')
<% 
	} 
	if("content".equals(error)){
%>
	alert('내용을 입력하세요')
<% } %>
</script>
</body>
</html>
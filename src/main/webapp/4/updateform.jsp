<%@page import="vo.Board"%>
<%@page import="vo.User"%>
<%@page import="dao4.SoccerBoardDao"%>
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
<%@ include file="/common/navbar.jsp" %>
<%
	SoccerBoardDao boardDao = SoccerBoardDao.getInstance();
	int no = Integer.parseInt(request.getParameter("no"));
	Board board = boardDao.getBoardDetail(no);
	
	User loginUserInfo = (User)session.getAttribute("LOGIN_USER_INFO");
	
	String content = board.getContent();
	content = content.replace("<br>", "\r\n");

	if(loginUserInfo == null){
		response.sendRedirect("../loginform.jsp?error=noLogin");
		return;
	}
%>
	<div class="dcwrap">
	
		<div class="wrap_inner">
			<main class="dc_container">
				<section class="left_content">
			<div class="row">
				<div class="col mb-4 mt-2">
					<h2>축구 갤러리</h2>
				</div>
			</div>
			<div class="row">
				<div class="col">
					<form class="border p-3" method="post" action="update.jsp">
						<div class="mb-3">
							<input type="text" class="form-control" name="title" value=<%=board.getTitle() %> />
						</div>
						<div class="mb-3">
							<textarea rows="20" class="form-control" name="content" style="resize: none;"><%=content %></textarea>
						</div>
							<input type="hidden" name="no" value="<%=board.getNo()%>">
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
					
				</section>
			</main>
		</div>
		
	</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
<%@page import="vo.Board"%>
<%@page import="dao6.HotplaceBoardDao"%>
<%@page import="vo.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!doctype html>
<html lang="ko">
<%@ include file="/common/head.jsp" %>
<body>
	<!-- wrap Start-->
	<div class="dcwrap">
		<!-- header Start-->
		<%@ include file="/common/header.jsp" %>
		<!-- header End-->
		<!-- navbar Start-->
		<%@ include file="/common/navbar.jsp" %>
		<!-- navbar End-->
<%
	User loginUserInfoByInsertFrom = (User) session.getAttribute("LOGIN_USER_INFO");
	if (loginUserInfoByInsertFrom == null) {
		response.sendRedirect("../index.jsp?error=required");
	}
	
	int boardNo = Integer.parseInt(request.getParameter("boardNo"));
	int currentPageNo = Integer.parseInt(request.getParameter("cpno"));
	
	HotplaceBoardDao boardDao = HotplaceBoardDao.getInstance();
	Board board = boardDao.getBoardDetail(boardNo);
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
						<form method="post" action="updateRegister.jsp">
							<div class="mb-3">
								<input type="text" class="form-control" name="title" value="<%=board.getTitle() %>"/>
								<input type="hidden" class="form-control" name="boardNo" value="<%=board.getNo() %>"/>
								<input type="hidden" class="form-control" name="cpno" value="<%=currentPageNo %>"/>
								<div class="form-text">※음란물, 차별, 비하, 혐오 및 초상권, 저작권 침해 게시물은 민, 형사상의 책임을 질 수 있습니다.</div>
							</div>
							<div class="mb-3">
								<textarea rows="20" class="content form-control" name="content" style="resize: none;"><%=board.getContent() %></textarea>
							</div>
							
							<div class="mb-3 text-end">
								<a href="list.jsp" class="btn btn-secondary btn-sm" data-bs-toggle="modal" data-bs-target="#cancleModal">취소</a>
								<button type="submit" class="btn btn-primary btn-sm">수정</button>
							</div>
						</form>
					</div>
				</div>
			</section>
			<!-- left contents End -->
			
			<!-- right content Start -->
			<%@ include file="/common/right_section.jsp" %>
			<!-- right content End -->
			</main>
		</div>
		<!-- wrap_inner End-->
		
<!-- 수정 Modal Start-->
<div class="modal fade" id="cancleModal" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="staticBackdropLabel">게시글 수정 취소</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        정말 취소하시겠습니까?
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">아니요</button>
        <a href="detail.jsp?boardNo=<%=board.getNo() %>&cpno=<%=currentPageNo %>">
        	<button type="button" class="btn btn-primary">네</button>
        </a>
      </div>
    </div>
  </div>
</div>
<!-- Modal End-->
	</div>
	<!-- wrap End-->	
</body>
<%@ include file="/common/footer.jsp" %>
<%@ include file="/common/script.jsp" %>
</html>
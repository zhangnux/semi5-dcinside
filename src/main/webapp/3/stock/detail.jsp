
<%@page import="utils.DateUtils"%>
<%@page import="vo.User"%>
<%@page import="vo.BoardLiker"%>
<%@page import="vo.Comment"%>
<%@page import="java.util.List"%>
<%@page import="vo.Board"%>
<%@page import="dao3.StockBoardDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!doctype html>
<html lang="ko">
<head>
   <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" >
    <link rel="stylesheet" href="../common/dc_style.css">
   
    <title>## CONNECTING HEARTS! 디시인사이드입니다. ##</title>
</head>
<body>
<div class="dcwrap">
	<header class="header">
			<div class="head">
				<h1 class="logo">
					<a href="https://www.dcinside.com/"><img src="../resources/images/dc_logo.png" alt="dc_logo"></a>
				</h1>
			</div>
		</header> 
	<%@include file="/common/navbar.jsp" %>
		<div class="wrap_inner">
<%
// 요청 파라미터 boardNo
	int no = Integer.parseInt(request.getParameter("no"));
	// 페이징 요청파라미터 pageNo
	
	String pageNo = request.getParameter("pageNo");
	String error = request.getParameter("error");
	
	StockBoardDao boardDao = StockBoardDao.getInstance();
	Board board = boardDao.getBoardDetail(no);
	board.setViewCount(board.getViewCount()+1);
	boardDao.updateBoard(board);
	
	List<Comment> commentList = boardDao.getAllComment(no);
%>
<main class="dc_container">
	<section class="Left_content">
	
	<div class="row">
		<div class="col mb-4 mt-2">
			<h2>주식 갤러리</h2>		
		</div>
	</div>
	<div class="row mb-1">
		<div class="col mb-3">
			<div class="border-top border-bottom">
				<div class="fs-4 pt-2"><%=board.getTitle() %></div>
				<div>
					<small><%=board.getWriter().getName() %></small>
					<small class="ml-3 ps-2 border-start"><%=board.getCreatedDate() %></small>
				</div>
				<div class="text-end border-bottom">
				<small>조회 <%=board.getViewCount() %></small>
				<small class="ml-3 ps-2 border-start">추천
<%
if(board.getLikeCount()> 0 ){
%>				
					<button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#liker">
<%
}
%>				
					<%=board.getLikeCount() %></button></small>
				</div>
				<div class="py-3"><%=board.getContent() %></div>
				<div class="text-center mb-3">
<%
	User loginUserInfo = (User)session.getAttribute("LOGIN_USER_INFO");
	if(loginUserInfo != null && loginUserInfo.getNo() != board.getWriter().getNo()){
		BoardLiker boardLiker = boardDao.getBoardLiker(no, loginUserInfo.getNo());
%>				
				<a href="like.jsp?no=<%=board.getNo() %>&pageNo=<%=pageNo%>" class="btn btn-primary <%=boardLiker!=null?"disalbed":""%>">추천</a>		 	
<%
	}
%>				
				<a href="" class="btn btn-outline-warning">★즐겨찾기</a>
				</div>
			</div>
		</div>
	</div>
	
	<!-- 버튼 -->
	<div class="row">
		<div class="col">
			<div class="col d-flex justify-content-between">
				<div>
					<a href="list.jsp?pageNo=1" class="btn btn-primary">전체글</a> 
					<a href="" class="btn btn-light">개념글</a>
				</div>
<%
		if(loginUserInfo != null && loginUserInfo.getNo() == board.getWriter().getNo()){
%>				
				<div>
					<a href="updateform.jsp?no=<%=board.getNo() %>&pageNo=<%=pageNo%>" class="btn btn-secondary">수정</a>
					<a class="btn btn-secondary"data-bs-toggle="modal" data-bs-target="#deleteConfirm">삭제</a>
				</div>
<%
		}
%>				
			</div>
		</div>
	</div>
	
	<!-- 댓글  -->
	<div class="row mt-5 mb-3">
		<div class="col pt-1 pb-1">
		<div class="border-top">
<%
	if("comcont".equals(error)){
%>		
		<div class="alert alert-danger" role="alert">
		내용을 입력하세요.
		</div>	
<%
	}
	if("commentId".equals(error)){
%>	
		<div class="alert alert-danger" role="alert">
			로그인이 필요합니다.
		</div>	
<%
	}
%>	
	
<%	
	if(!commentList.isEmpty()){	

		for(Comment comments : commentList){		
%>
				<div class="row p-2">
					<div class="col <%=comments.getOrder() != 0 ? "ps-5" : ""%>">
						<div class="row <%=comments.getOrder() != 0 ? "border pt-2 pb-2" : ""%>">
							
<%
				if (comments.getDeleted().equals("Y")) {
%>
							<div class="col-12">삭제된 댓글입니다.</div>
							
<%		
				} else {
%>
							<div class="col-2 text-muted fs-9"><%=comments.getWriter().getName() %></div>
							<div class="col-7"><%=comments.getContent() %></div>
							<div class="col-2 fs-9"><%=DateUtils.dateToString(comments.getCreatedDate()) %></div>
							<div class="col-1">
							<!-- 답글달기 아이콘 -->
							<%
								if(loginUserInfo!=null && comments.getOrder() == 0) {
							
							%>
								<i class="fa  fa-commenting-o" aria-hidden="true" onclick="toggleform('form-<%=comments.getNo() %>')"></i>
							<% } 
								// 댓글 삭제 아이콘							
								if(loginUserInfo != null && loginUserInfo.getNo() == comments.getWriter().getNo()) {
									
							%>				
		
								<a href="../comment/delete.jsp?no=<%=board.getNo() %>&writerNo=<%=comments.getWriter().getNo() %>&commentNo=<%=comments.getNo() %>&order=<%=comments.getOrder() %>&groupNo=<%=comments.getGroup() %>">
								<i class="fa  fa-trash" aria-hidden="true"></i></a>
							<% } %>								
							</div>
		
<%		
				}
%>							

			<!-- 대댓글 달기 창 -->
<%
			if (comments.getOrder() == 0){
%>
					<div class="row my-3" id="form-<%=comments.getNo() %>" style="display: none;">
						<div class="col">
							<form method="get" action="../comment/reply.jsp" class="border bg-light p-2">
								<input type="hidden" name="no" value="<%=board.getNo() %>" />
								<input type="hidden" name="order" value="<%=comments.getNo() %>" />
								<input type="hidden" name="group" value="<%=comments.getGroup() %>" />
								<div class="row g-3">
									<div class="col-11">
										<textarea placeholder="타인의 권리를 침해하거나 명예를 훼손하는 댓글은 운영원칙 및 관련법률에 제재를 받을 수 있습니다." rows="2" name="content" class="form-control" style="resize: none;"></textarea>
									</div>
									<div class="col-1">
										<button type="submit" class="btn btn-primary ">등록</button>
									</div>
								</div>
							</form>
						</div>
					</div>
<%
			}
%>
				</div>
			</div>	
		</div>
<%	
		}
%>
					

<%
		
	} else {

%>
			<div class="col ps-5">
				<div class="row px-3 py-2">
					작성된 댓글이 없습니다.
				</div>
			</div>
<% } %>

		
<%
	if (loginUserInfo == null) {
%>
	<div class="row mb-3 px-3 py-2">
		<div class="col">
			<div class="alert alert-secondary py-2">
				로그인 작성자만 댓글을 작성 할 수 있습니다.
				<a class="btn btn-outline-primary btn-sm" href="../loginform.jsp">로그인</a>
			</div>
		</div>
	</div>

<%
	} else {
%>
	<!-- 댓글 달기 창 -->
	<div class="row mb-3 px-3 py-2">
		<div class="col">
			<form method="post" action="../comment/comment.jsp" class="border bg-light p-2">
				<input type="hidden" name="no" value="<%=board.getNo() %>" />
				<div class="row g-3">
					<div class="col-11">
						<textarea placeholder="타인의 권리를 침해하거나 명예를 훼손하는 댓글은 운영원칙 및 관련법률에 제재를 받을 수 있습니다." rows="5" name="content" class="form-control" style="resize: none;"></textarea>
					</div>
					<div class="col-1">
						<button type="submit" class="btn btn-primary ">등록</button>
					</div>
				</div>
			</form>
		</div>
	</div>
<%
		}
%>
			</div>					
		</div>
	</div>
	</section>
	<section class="right_content">
		
	</section>
</main>
	</div>
	
</div>



<!-- 추천인 표시 모달창 -->
	<div class="modal fade" id="liker" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
	  <div class="modal-dialog">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h5 class="modal-title" id="exampleModalLabel">추천인</h5>
	        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
	      </div>
	      <div class="modal-body">
	      	<ul>
<% 
	List<User> likerList = boardDao.getLikeUsers(no);
	for (User liker : likerList){
%>
				<li><%=liker.getName() %></li>
<% } %>
			</ul>
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
	      </div>
	    </div>
	  </div>
	</div>
					
<!-- 삭제 재확인 모달창 -->
<div class="modal fade" id="deleteConfirm" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content">
      <div class="modal-header">
        <h6 class="modal-title" id="exampleModalLabel">삭제</h6>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        게시글을 삭제하시겠습니까?
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
        <a class="btn btn-primary" href="delete.jsp?no=<%=board.getNo() %>&pageNo=<%=pageNo %>">확인</a>
      </div>
    </div>
  </div>
</div>
					
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
<script type="text/javascript">
function toggleform (id) {
	var el = document.getElementById(id);
	var value = el.style.display;
	if (value == '') {
		el.style.display = 'none';
	} else {
		el.style.display = '';
	}
}

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

<%@page import="vo.Comment"%>
<%@page import="dao6.CommentDao"%>
<%@page import="vo.User"%>
<%@page import="vo.Board"%>
<%@page import="dao6.HotplaceBoardDao"%>
<%@page import="utils.DateUtils"%>
<%@page import="java.util.List"%>
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
<%
	int boardNo = Integer.parseInt(request.getParameter("boardNo"));
	int pageNo = Integer.parseInt(request.getParameter("cpno"));
	String error = (String) request.getParameter("error");
	
	HotplaceBoardDao boardDao = HotplaceBoardDao.getInstance();
	Board board = boardDao.getBoardDetail(boardNo);
	
	board.setViewCount(board.getViewCount() + 1);
	boardDao.updateBoard(board);
%>
<body>
<div class="dcwrap">
	<%@include file="/common/navbar.jsp" %>
		<div class="wrap_inner">
			<main class="dc_container">
				<section class="left_content">

						<h2>핫플레이스 갤러리</h2>
							<div class="border-top fs-4 pt-2"><%=board.getTitle() %></div>
							<div>
								<small><%=board.getWriter().getId() %></small> 
								<small class="ml-3 ps-2 border-start"><%=board.getCreatedDate() %></small>
							</div>
							<div class="text-end border-bottom">
								<small>조회 <%=board.getViewCount() %></small> 
								<small class="ml-3 ps-2 border-start">추천 <%=board.getLikeCount() %></small>
							</div>
							<div class="text-wrap py-3">
								<div class="contentArea"><%=board.getContent() %></div>
							</div>
								<%
								if ("deny-like".equals(error)){
								%>
										<div class="alert alert-danger text-center" role="alert">
										  이미 추천한 글입니다.
										</div>
								<%
								}
								%>						
								
<!-- btn align div Start-->
<div class="border-top border-bottom text-end">
	<a href="list.jsp?cpno=<%=pageNo %>" class="btn btn-primary btn-sm my-3">목록</a>
<%
	User loginUserInfoByDetail = (User) session.getAttribute("LOGIN_USER_INFO");
	if (loginUserInfoByDetail != null && loginUserInfoByDetail.getNo() != board.getWriter().getNo()) {
%>
		<!-- 추천 링크 -->
		<a href="like.jsp?typeCode=6&boardNo=<%=boardNo %>&cpno=<%=pageNo %>" class="btn btn-primary btn-sm my-3">추천</a>

<%
	}
%>	
<%
	if (loginUserInfoByDetail != null && loginUserInfoByDetail.getNo() == board.getWriter().getNo()) {
%>		
		<!-- 수정 링크 -->
		<a href="updateForm.jsp?boardNo=<%=boardNo %>&cpno=<%=pageNo %>" class="btn btn-primary btn-sm my-3">
			수정
		</a>
		
		<!-- 삭제 모달 링크 -->
		<a class="btn btn-danger btn-sm my-3" data-bs-toggle="modal" data-bs-target="#deleteModal">삭제</a>
<%
	}
%>

</div>
<!-- btn align div End-->
							
<!-- conment Start -->
	<ul class="border-top border-bottom">
<% 
	CommentDao commentDao = CommentDao.getInstance();
	List<Comment> comments = commentDao.getCommentListByBoard(board);
	if (!comments.isEmpty()) {
		for (Comment comment : comments) {
			if (comment.getOrder() == 0) {
%>
		<!-- comment view Start -->
		<li class="row mt-2 border-bottom">
			<div class="col-2">
		    	<small><%=comment.getWriter().getId() %></small>
		    </div>
		    <div class="col-8">
   				<!-- comment reply form Start -->
		    	<a class="commentContent" data-bs-toggle="collapse" href="#collapse_<%=comment.getGroup() %>" role="button" aria-expanded="false" aria-controls="collapseExample">
		      		<small><%=comment.getContent() %></small>
		      		<i class="fa fa-commenting-o" aria-hidden="true"></i>
		      	</a>
		      	<div class="collapse" id="collapse_<%=comment.getGroup() %>">
				  <div class="card card-body">
				    <div class="row">
						<div class="col">
							<form method="post" action="commentReplyRegister.jsp">
								<div class="mb-3">
									<input type="hidden" class="form-control" name="boardNo" value="<%=boardNo %>" />
									<input type="hidden" class="form-control" name="cpno" value="<%=pageNo %>" />
									<input type="hidden" class="form-control" name="orderNo" value="1" />
									<input type="hidden" class="form-control" name="groupNo" value="<%=comment.getGroup() %>" />
									<textarea rows="3" class="form-control" name="comment" style="resize: vertical;"></textarea>
								</div>
								<div class="text-end">
									<button type="submit" class="btn btn-primary btn-sm">댓글등록</button>
								</div>
							</form>
						</div>
					</div>
				  </div>
				</div>
				<!-- comment reply form End -->
		    </div>
		    <div class="col-2 text-end">
		      	<small><%=DateUtils.dateToString(comment.getCreatedDate()) %></small>
		      	<%
		      		if (loginUserInfoByDetail != null && loginUserInfoByDetail.getNo() == board.getWriter().getNo()) {
		      	%>
		      	<a href="deleteComment.jsp?boardNo=<%=board.getNo() %>&cpno=<%=pageNo %>&commentNo=<%=comment.getNo() %>">
		      		<i class="fa fa-trash" aria-hidden="true"></i>
		      	</a>
		      	<%
		      		}
		      	%>
		    </div>
		</li>
		<!-- comment view End -->
<%
			}
			if (comment.getOrder() == 1) {
%>
		<!-- comment reply view Start -->
		<li>
			<ol class="">
				<li class="row mt-2">
					<div class="col-2">
				    	<small><%=comment.getWriter().getId() %></small>
				    </div>
				    <div class="col-8">
					      	<small><%=comment.getContent() %></small>
				    </div>
				    <div class="col-2 text-end">
				      	<small><%=DateUtils.dateToString(comment.getCreatedDate()) %></small>
<%
	if (loginUserInfoByDetail != null && loginUserInfoByDetail.getNo() == board.getWriter().getNo()) {
%>
				      	<a href="deleteComment.jsp?boardNo=<%=board.getNo() %>&cpno=<%=pageNo %>&commentNo=<%=comment.getNo() %>">
					      	<i class="fa  fa-trash" aria-hidden="true"></i>
				      	</a>
<%
	}
%>
				    </div>
				</li>
			</ol>
		</li>
		<!-- comment reply view End -->
<%
			}
		}
	} else {
%>
	<li>댓글이 존재하지 않습니다.</li>
<%
	}
%>

	</ul>
	<!-- commentForm Start -->
	<div class="row">
		<div class="col">
			<form method="post" action="commentRegister.jsp">
				<div class="mb-3">
					<input type="hidden" class="form-control" name="boardNo" value="<%=boardNo %>" />
					<input type="hidden" class="form-control" name="cpno" value="<%=pageNo %>" />
					<input type="hidden" class="form-control" name="orderNo" value="0" />
					<textarea rows="3" class="form-control" name="comment" style="resize: vertical;"></textarea>
				</div>
				<div class="mb-3 text-end">
					<button type="submit" class="btn btn-primary btn-sm">댓글등록</button>
				</div>
			</form>
		</div>
	</div>
	<!-- commentForm End -->
	<!-- comment End -->

<!-- 삭제 Modal Start-->
<div class="modal fade" id="deleteModal" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="staticBackdropLabel">게시글 삭제</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        정말 삭제하시겠습니까?
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">아니요</button>
        <a href="delete.jsp?boardNo=<%=board.getNo() %>&cpno=<%=pageNo %>">
        	<button type="button" class="btn btn-primary">네</button>
        </a>
      </div>
    </div>
  </div>
</div>
<!-- Modal End-->	
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
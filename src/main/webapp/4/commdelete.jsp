<%@page import="dao4.SoccerBoardDao"%>
<%@page import="vo.Board"%>
<%@page import="vo.User"%>
<%@page import="vo.Comment"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%

	Comment comment = new Comment();

	int boardNo = Integer.parseInt(request.getParameter("boardNo"));
	int writerNo = Integer.parseInt(request.getParameter("writerNo"));
	int commentNo = Integer.parseInt(request.getParameter("commentNo"));
	
	// 로그인 여부 확인
	User loginUserInfo = (User) session.getAttribute("LOGIN_USER_INFO");
	if(loginUserInfo == null || loginUserInfo.getNo() != writerNo){
	response.sendRedirect("../4/detail.jsp?no="+boardNo+"&error=commentId");
	return;
	}
	
	// 댓글 삭제 관련 action
	Board board = new Board();
	SoccerBoardDao boardDao = SoccerBoardDao.getInstance();

	boardDao.deleteComment(commentNo);

%>
<script> 
location.href = document.referrer; 
</script>

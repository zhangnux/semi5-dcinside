<%@page import="dao1.AnimalBoardDao"%>
<%@page import="java.util.List"%>
<%@page import="vo.Board"%>
<%@page import="dao2.BoardDao"%>
<%@page import="vo.User"%>
<%@page import="vo.Comment"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	
int boardNo = Integer.parseInt(request.getParameter("boardNo"));
int writerNo = Integer.parseInt(request.getParameter("writerNo"));
int commentNo = Integer.parseInt(request.getParameter("commentNo"));
int order = Integer.parseInt(request.getParameter("order"));
int groupNo = Integer.parseInt(request.getParameter("groupNo"));

// 로그인 여부 확인
User loginUserInfo = (User) session.getAttribute("LOGIN_USER_INFO");
if(loginUserInfo == null || loginUserInfo.getNo() != writerNo){
	response.sendRedirect("../1/detail.jsp?no="+boardNo+"&error=commentId");
	return;
}

// 댓글 삭제 관련 action
Comment comment = new Comment();

AnimalBoardDao boardDao = AnimalBoardDao.getInstance();
Board board = boardDao.getBoardDetail(boardNo);
int groupCount = boardDao.getGroupCount(groupNo);


// 모댓글일때
if(order == 0){

	if(groupCount == 1){
		boardDao.deleteCommentGroup(groupNo);
		
	} else if (groupCount > 1) {
		boardDao.deleteComment(commentNo);		
	}
// 대댓글일때
} else {

	if (groupCount == 2) {
		
		Comment motherComment = boardDao.getCommentInfo(order);
		
		if(motherComment.getDeleted().equals("Y")){
			boardDao.deleteCommentGroup(groupNo);
		} else {
			boardDao.deleteCommentColumn(commentNo);		
		}

	} else {
		boardDao.deleteCommentColumn(commentNo);			
	}

}

board.setCommentCount(board.getCommentCount()-1);
boardDao.updateBoard(board);

response.sendRedirect("../1/detail.jsp?no="+boardNo);
	
%>
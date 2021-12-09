<%@page import="dao1.AnimalBoardDao"%>
<%@page import="vo.Board"%>
<%@page import="vo.Comment"%>
<%@page import="vo.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
User loginUserInfo = (User) session.getAttribute("LOGIN_USER_INFO");

int boardNo = Integer.parseInt(request.getParameter("boardNo"));
String pageNo = request.getParameter("pageNo");

int order = Integer.parseInt(request.getParameter("order"));
String content = request.getParameter("content");
int group = Integer.parseInt(request.getParameter("group"));	

if (loginUserInfo == null) {
	response.sendRedirect("../loginform.jsp?error=noLogin");
	return;
}

if(content == null || content.isBlank()){
	response.sendRedirect("../1/detail.jsp?no="+boardNo+"&pageNo="+pageNo+"&error=comcont");
	return;
}

AnimalBoardDao boardDao = AnimalBoardDao.getInstance();
Board board = boardDao.getBoardDetail(boardNo);

Comment comment = new Comment();

comment.setBoard(board);
comment.setOrder(order);
comment.setContent(content);
comment.setWriter(loginUserInfo);
comment.setGroup(group);
boardDao.insertCommetReply(comment);

board.setCommentCount(board.getCommentCount()+1);
boardDao.updateBoard(board);	

response.sendRedirect("../1/detail.jsp?no="+boardNo+"&pageNo="+pageNo);

%>

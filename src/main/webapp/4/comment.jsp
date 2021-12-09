<%@page import="vo.Comment"%>
<%@page import="vo.Board"%>
<%@page import="dao4.SoccerBoardDao"%>
<%@page import="vo.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%

	User loginUserInfo = (User) session.getAttribute("LOGIN_USER_INFO");
	int boardNo = Integer.parseInt(request.getParameter("boardNo"));
	String content = request.getParameter("content");

	if (loginUserInfo == null) {
		response.sendRedirect("../loginform.jsp?error=noLogin");
		return;
	}

	if(content == null || content.isBlank()){
		response.sendRedirect("../4/detail.jsp?no="+boardNo+"&error=comcont");
		return;
	}

	SoccerBoardDao boardDao = SoccerBoardDao.getInstance();
	Board board = boardDao.getBoardDetail(boardNo);

	Comment comment = new Comment();
	
	comment.setBoard(board);
	comment.setWriter(loginUserInfo);
	comment.setContent(content);
	
	boardDao.insertComment(comment);
	
	board.setCommentCount(board.getCommentCount() + 1);
	boardDao.updateBoard(board);
	
	response.sendRedirect("../4/detail.jsp?no="+boardNo);

%>
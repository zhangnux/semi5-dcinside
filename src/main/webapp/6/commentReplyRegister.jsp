<%@page import="vo.User"%>
<%@page import="vo.Comment"%>
<%@page import="vo.Board"%>
<%@page import="dao6.HotPlaceBoardDao"%>
<%@page import="dao6.CommentDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
int boardNo = Integer.parseInt(request.getParameter("boardNo"));
	int currentPageNo = Integer.parseInt(request.getParameter("cpno"));
	int orderNo = Integer.parseInt(request.getParameter("orderNo"));
	int groupNo = Integer.parseInt(request.getParameter("groupNo"));
	String commentContent = request.getParameter("comment");
	
	HotPlaceBoardDao boardDao = HotPlaceBoardDao.getInstance();
	Board board = boardDao.getBoardDetail(boardNo);
	
	User loginUserInfo = (User) session.getAttribute("LOGIN_USER_INFO");
	
	Comment comment = new Comment();
	comment.setBoard(board);
	comment.setWriter(loginUserInfo);
	comment.setContent(commentContent);
	comment.setOrder(orderNo);
	comment.setGroup(groupNo);
	
	CommentDao commentDao = CommentDao.getInstance();
	commentDao.insertCommentReply(comment);
	
	response.sendRedirect("detail.jsp?boardNo=" + boardNo + "&cpno=" + currentPageNo);
%>
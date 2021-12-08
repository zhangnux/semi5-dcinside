<%@ page import="dao6.HotPlaceBoardDao"%>
<%@ page import="vo.Board"%>
<%@ page import="vo.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
/* insert를 위해 insertForm에서 전달받은 title, content를 가지고 옴 */
	String title = request.getParameter("title");
	String content = request.getParameter("content");
	
	/* session에 있는 유저정보를 가져옴 */
	User loginUserInfo = (User)session.getAttribute("LOGIN_USER_INFO");
	
	/* 예외 처리 */
	if (loginUserInfo == null) {
		response.sendRedirect("../loginform.jsp?fail=required");
		return;
	}
	
	/* 가져온 insert정보를 setting 해줌 */
	Board board = new Board();
	board.setTitle(title);
	board.setWriter(loginUserInfo);
	board.setContent(content);
	
	HotPlaceBoardDao boardDao = HotPlaceBoardDao.getInstance();
	
	boardDao.insertBoard(board);
	
	response.sendRedirect("list.jsp?cpno=1");
%>
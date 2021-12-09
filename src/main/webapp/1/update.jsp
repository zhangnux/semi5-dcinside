<%@page import="vo.Board"%>
<%@page import="dao1.AnimalBoardDao"%>
<%@page import="vo.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	int no = Integer.parseInt(request.getParameter("no"));
	int pageNo = Integer.parseInt(request.getParameter("pageNo"));
	String title = request.getParameter("title");
	String content = request.getParameter("content");
	
	/* 제목/내용 유무 확인 */
	if(title == null || title.isBlank()){
		response.sendRedirect("updateform.jsp?error=title");
		return;
	}
	
	if(content == null|| content.isBlank()){
		response.sendRedirect("updateform.jsp?error=content");
		return;
	}
	
	/* 로그인 여부 확인 */
	User loginUserInfo = (User)session.getAttribute("LOGIN_USER_INFO");
	
	if(loginUserInfo == null){
		response.sendRedirect("../loginform.jsp?error=noLogin");
		return;
	}
	
	
	AnimalBoardDao boardDao = AnimalBoardDao.getInstance();
	
	Board board = new Board();
	
	board.setNo(no);
	board.setTitle(title);
	board.setContent(content);
	
	boardDao.updateBoard(board);
	
	response.sendRedirect("detail.jsp?no="+no+"&pageNo="+pageNo);
%>
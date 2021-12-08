<%@page import="vo.User"%>
<%@page import="vo.Board"%>
<%@page import="dao2.DiabloBoardDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
int no = Integer.parseInt(request.getParameter("no"));
	String pageNo = request.getParameter("pageNo");

	String title = request.getParameter("title");
	String content = request.getParameter("content");
	
	/* 제목/내용 유무 확인 */
	if(title == null || title.isBlank()){
		response.sendRedirect("form.jsp?error=title");
		return;
	}
	
	if(content == null|| content.isBlank()){
		response.sendRedirect("form.jsp?error=content");
		return;
	}
	
	/* 로그인 여부 확인 */
	User loginUserInfo = (User)session.getAttribute("LOGIN_USER_INFO");
	
	if(loginUserInfo == null){
		response.sendRedirect("../loginform.jsp?error=noLogin");
		return;
	}
	
	
	DiabloBoardDao boardDao = DiabloBoardDao.getInstance();
	
	Board board = new Board();
	
	board.setNo(no);
	board.setTitle(title);
	board.setContent(content);
	
	boardDao.updateBoard(board);
	
	response.sendRedirect("detail.jsp?no="+no+"&pageNo="+pageNo);
%>
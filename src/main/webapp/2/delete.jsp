<%@page import="vo.Board"%>
<%@page import="dao2.DiabloBoardDao"%>
<%@page import="vo.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
int no = Integer.parseInt(request.getParameter("no"));
	String pageNo = request.getParameter("pageNo");
	
	// 로그인 여부확인
	User loginUserInfo = (User)session.getAttribute("LOGIN_USER_INFO");

	if(loginUserInfo == null){
		response.sendRedirect("../loginform.jsp?error=noLogin");
		return;
	}
	
	// 게시글 삭제 관련 action
	DiabloBoardDao boardDao = DiabloBoardDao.getInstance();
	Board board = boardDao.getBoardDetail(no);
	
	if(board.getWriter().getNo() != loginUserInfo.getNo()){
%>
		<script>
			alert('작성자만 삭제 가능합니다');
			window.history.back();
		</script>
<%		
		return;
	}
	
	boardDao.deleteBoard(no);
	response.sendRedirect("list.jsp");

%>
<%@page import="vo.User"%>
<%@page import="dao.UserDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%


	String id = request.getParameter("id");
	String password = request.getParameter("password");

	if(id == null || id.isBlank()){
		response.sendRedirect("index.jsp?error=empty");
		return;
	} 
	
	if(password == null || password.isBlank()){
		response.sendRedirect("index.jsp?error=emptyt");
		// 응답 보낸 후 아래 구문은 더이상 실행 할 필요 없으므로 return으로 로직을 종료시킴
		return;
	}
	
	UserDao userDao = UserDao.getInstance();
	User user = userDao.getUserById(id);

	if(user == null){
		response.sendRedirect("index.jsp?error=not-found-user");
		return;
	}

	if(!user.getPassword().trim().equals(password)){
		response.sendRedirect("index.jsp?error=mismatch-password");
		return;
	}
	
	session.setAttribute("LOGIN_USER_INFO", user);
	
	response.sendRedirect("index.jsp");
%>
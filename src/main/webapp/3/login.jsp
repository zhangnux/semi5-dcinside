<%@page import="vo.User"%>
<%@page import="dao3.UserDao"%>
<%@page import="org.apache.commons.codec.digest.DigestUtils"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String id = request.getParameter("id");
	String password = request.getParameter("password");
	
	
	if(id != null && id.isBlank()){
		response.sendRedirect("loginform.jsp?error=empty");
		return;
	} 
	if(password != null && password.isBlank()){
		response.sendRedirect("loginform.jsp?error=empty");
		return;
	}
	
	UserDao userDao = UserDao.getInstance();
	User user = userDao.getUserById(id);
	
	if(user == null) {
		response.sendRedirect("loginform.jsp?error=notfound-user");
		return;
	}
	
	
	String secretPassword = DigestUtils.sha256Hex(password);
	
	if(!user.getPassword().equals(secretPassword)){
		response.sendRedirect("loginform.jsp?error=mismatch-password");
		return;
	}

	session.setAttribute("LOGIN_USER_INFO", user);
	
	response.sendRedirect("index.jsp");
%>

<%@page import="vo.User"%>
<%@page import="dao.UserDao"%>
<%@page import="org.apache.commons.codec.digest.DigestUtils"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String id = request.getParameter("id");
	String password = request.getParameter("password");
	String name = request.getParameter("name");
	String tel = request.getParameter("tel");
	String email = request.getParameter("email");
	
	UserDao userDao = UserDao.getInstance();
	
	User savedUser = userDao.getUserById(id);
	if(savedUser != null ){
		response.sendRedirect("registerform.jsp?error=id-exists");
		return;
	}
		
	savedUser = userDao.getUserByEmail(email);
	if(savedUser != null){
		response.sendRedirect("registerform.jsp?error=email-exists");
		return;
	}
	
	String secretPassword = DigestUtils.sha256Hex(password);

	User user = new User();
	user.setId(id);
	user.setPassword(secretPassword);
	user.setName(name);
	user.setTel(tel);
	user.setEmail(email);
	
	userDao.insertUser(user);
	
	response.sendRedirect("index.jsp?register=completed");
	
%>
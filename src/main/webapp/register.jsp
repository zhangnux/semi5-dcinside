<%@page import="vo.User"%>
<%@page import="dao.UserDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%

	String id = request.getParameter("id");
	String password = request.getParameter("password");
	String name = request.getParameter("name");
	String tel = request.getParameter("tel");
	String email = request.getParameter("email");

	UserDao userDao = UserDao.getInstance();
	
	// 중복 아이디 조회
	User savedUser = userDao.getUserById(id);
	if(savedUser != null){
		response.sendRedirect("registerform.jsp?error=id-exists");
		return;
	}
	
	// 중복 이메일 조회
	savedUser = userDao.getUserByEmail(email);
	if(savedUser != null){
		response.sendRedirect("registerform.jsp?error=email-exists");
		return;
	}

	User user = new User();
	user.setId(id);
	user.setPassword(password);
	user.setName(name);
	user.setTel(tel);
	user.setEmail(email);
	
	userDao.insertUser(user);
	
	response.sendRedirect("index.jsp?register=completed");

%>
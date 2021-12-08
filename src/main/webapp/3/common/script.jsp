<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://kit.fontawesome.com/d94ff6bbbc.js" crossorigin="anonymous"></script>
<script type="text/javascript">
<%
String error = request.getParameter("error");
if("deny-like".equals(error)){
%>
alert('이미 추천한 게시판입니다.');
<% 
} 
if("content".equals(error)){
%>
alert('내용을 입력하세요');

<% } %>

</script>

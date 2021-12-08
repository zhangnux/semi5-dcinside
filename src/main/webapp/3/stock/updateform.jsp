
<%@page import="vo.User"%>
<%@page import="vo.Board"%>
<%@page import="dao3.StockBoardDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!doctype html>
<html lang="ko">
<head>
   <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
   <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" >
   <link rel="stylesheet" href="../common/dc_style.css">
    <title></title>
</head>
<body>
<%@ include file ="../common/navbar.jsp" %>
<%
int no = Integer.parseInt(request.getParameter("no")); 
	String pageNo = request.getParameter("pageNo");

	StockBoardDao boardDao = StockBoardDao.getInstance();
	Board board = boardDao.getBoardDetail(no);
	
	User loginUserInfo = (User)session.getAttribute("LOGIN_USER_INFO");
	if(loginUserInfo == null){
		response.sendRedirect("../loginform.jsp?error=noLogin");
		return;
	}
	
	if(board.getWriter().getNo() != loginUserInfo.getNo()){

		return;
	}
%>
<div class="container ">
	<div class="row">
		<div class="col">
			<form class="border p-3"  method="post" action="update.jsp?no=<%=board.getNo()%>">
				<div class="mb-3">
					<label>제목</label>
					<input type="text" name="title" value="<%=board.getTitle() %>">
				</div>
				<div>
					<label>내용</label>
					<textarea rows="20" cols="100" class="form-control" name="content" style="resize: none;" ><%=board.getContent() %></textarea>
				</div>
				<button type="button" class="btn btn-secondary" >취소</button>
				<button type="submit" class="btn btn-primary">등록</button>
			</form>
		</div>	
	</div>
</div>
<script type="text/javascript">
<%
	String error = request.getParameter("error");
	if("title".equals(error)){
%>
	alert('제목을 입력하세요')
<% 
	} 
	if("content".equals(error)){
%>
	alert('내용을 입력하세요')
	
<% } %>

</script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
	
</body>
</html>
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
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">	
	<link rel = "stylesheet" href="../common/style.css">
	<title>## CONNECTING HEARTS! 디시인사이드입니다. ## </title>
</head>
<body>
<div class="dcwrap">
	<%@include file="/common/navbar.jsp" %>
		<div class="wrap_inner">
			<main class="dc_container">
				<section class="left_content">
		<%
			int no = Integer.parseInt(request.getParameter("no")); 
			String pageNo = request.getParameter("pageNo");
			
			User loginUserInfo = (User)session.getAttribute("LOGIN_USER_INFO");
		
			StockBoardDao boardDao = StockBoardDao.getInstance();
			Board board = boardDao.getBoardDetail(no);
			
			if(loginUserInfo == null){
				response.sendRedirect("../loginform.jsp?error=noLogin");
				return;
			}
			
			if(board.getWriter().getNo() != loginUserInfo.getNo()){
		
				return;
			}
		%>

				<div class="row">
					<div class="col">
						<form class="border p-3"  method="post" action="update.jsp?no=<%=board.getNo()%>">
							<div class="mb-3">
								<label>제목</label>
								<input type="text" class="form-control" name="title" value=<%=board.getTitle() %> />
							</div>
							<div>
								<label>내용</label>
								<textarea rows="20" cols="100" class="form-control" name="content" style="resize: none;" ><%=board.getContent() %></textarea>
							</div>
							<a class="btn btn-secondary" href="detail.jsp?no=<%=no %>&pageNo=<%=pageNo %>">취소</a>
							<button type="submit" class="btn btn-primary">등록</button>
						</form>
					</div>	
				</div>				



				
				</section>
				<section class="right_content">
					<%@include file="/common/right_section.jsp" %>
				</section>
			</main>
		</div>
		<%@include file="/common/footer.jsp" %>
	</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
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
</body>
</html>

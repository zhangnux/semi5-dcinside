<%@page import="vo.User"%>
<%@page import="utils.DateUtils"%>
<%@page import="vo.Hit"%>
<%@page import="java.util.List"%>
<%@page import="vo.Pagination"%>
<%@page import="dao2.DiabloBoardDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!doctype html>
<html lang="ko">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" >
	<link rel = "stylesheet" href="../common/style.css">
	<title>## CONNECTING HEARTS! 디시인사이드입니다. ## </title>
</head>
<body>
<%
User loginUserInfo = (User)session.getAttribute("LOGIN_USER_INFO");
	if(loginUserInfo == null){
		response.sendRedirect("../loginform.jsp?error=noLogin");
		return;
	}
	
	DiabloBoardDao boardDao = DiabloBoardDao.getInstance();
	BoardDao boardDao2 = BoardDao.getInstance();
	
	List<Hit> posting = boardDao2.getMyPosting(loginUserInfo.getNo());
	List<Hit> comments = boardDao2.getMyComment(loginUserInfo.getNo());
%>
<div class="dcwrap">
<%@include file="../common/navbar.jsp" %>
	<div class="wrap_inner">
		<main class="dc_container">
			<section class="left_content"> 
				
				<!-- 작성글 -->
				<div class="row mt-2 mb-2">
					<div class="col">
						<div class="border-bottom border-secondary border-2 p-1 fw-bold text-primary fs-6">작성글</div>												
							<table class="table table-sm mt-3">
								<tbody>
									<tr class="fw-bold">
										<td class="col-1">갤러리</td>
										<td class="col-6 text-center">제목</td>
										<td class="col-2 text-center">작성일</td>
										<td class="col-1">조회</td>
										<td class="col-1">추천</td>
									</tr>
								
						<%
														if (posting.isEmpty()) {
														%>
									<tr class="border-bottom mt-1 p-2 text-center align-middle" style="height: 180px;">
										<td></td>
										<td class="align-top text-end"> 작성한 게시글이 없습니다.</td>
									</tr>
						<%
						}
											
											for (Hit post : posting) {
						%>
									<tr>
										<td class="col-1" style="font-size:13px;"><%=post.getBoardType().getName()%></td>
										<td class="col-6">
											<a href="../<%=post.getBoard().getType()%>/detail.jsp?no=<%=post.getBoard().getNo()%>">
											<%=post.getBoard().getTitle()%></a>
											(<%=post.getBoard().getCommentCount()%>)
										</td>
										<td class="col-2" style="font-size:13px;"><%=DateUtils.dateToString(post.getBoard().getCreatedDate())%></td>
										<td class="col-1"><%=post.getBoard().getViewCount()%></td>
										<td class="col-1"><%=post.getBoard().getLikeCount()%></td>
									</tr>
						<%
						}
						%>
								</tbody>	
							</table>
						</div>
					</div>
				
				<!-- 작성댓글 -->
				<div class="row mt-2 mb-2">
					<div class="col">
						<div class="border-bottom border-secondary border-2 p-1 fw-bold text-primary fs-6">작성댓글</div>												
							<table class="table table-sm mt-3">
								<tbody>
									<tr class="fw-bold">
										<td class="col-2">갤러리</td>
										<td class="col-7 text-center">내용</td>
										<td class="col-2">작성일</td>
										<td class="col-1"></td>
									</tr>
				
						<%
										if (comments.isEmpty()) {
										%>
									<tr class="border-bottom mt-1 p-2 text-center align-middle" style="height: 180px;">
										<td></td>
										<td class="align-top text-end"> 작성한 댓글이 없습니다.</td>
									</tr>
						<%
						}
											
											for (Hit comment : comments) {
						%>
									<tr>
										<td class="col-2" style="font-size:13px;"><%=comment.getBoardType().getName() %></td>
										<td class="col-7">
											<%=comment.getBoard().getContent()%>
										</td>
										<td class="col-2" style="font-size:13px;"><%=DateUtils.dateToString(comment.getBoard().getCreatedDate())%></td>
										<td class="col-1"></td>
									</tr>
						<%
						}
						%>
								</tbody>	
							</table>
						</div>
					</div>
				
				<!-- 즐겨찾기 -->
				
			
			</section>
			<section class="right_content">
				<%@include file="../common/right_section.jsp" %>
			</section>
		</main>
	</div>
<%@include file="/common/footer.jsp" %>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
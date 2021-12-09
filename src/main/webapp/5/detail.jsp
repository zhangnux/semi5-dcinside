<%@page import="vo.User"%>
<%@page import="utils.DateUtils"%>
<%@page import="vo.BoardComment"%>
<%@page import="vo.Pagination"%>
<%@page import="vo.CoinBoard"%>
<%@page import="dao5.CoinBoardDao"%>
<%@page import="java.util.List"%>
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
// include 시킨 navbar의 nav-item 중에서 페이지에 해당하는 nav-item를 active 시키기위해서 "menu"라는 이름으로 페이지이름을 속성으로 저장한다.
	// pageContext에 menu라는 이름으로 설정한 속성값은 navbar.jsp의 6번째 라인에서 조회해서 navbar의 메뉴들 중 하나를 active 시키기 위해서 읽어간다.
	pageContext.setAttribute("menu", "board");
%>

<!-- 게시글 제목 시작 --> <article>
							<div class="time_best">
								<header class="time_head">
									<div class="col d-flex justify-content-between">
										<div class="coinTitle col-3"><h2 class="fw-bold"><a href="list.jsp?categoryNo=5">코인 갤러리</a></h2></div>
										<div class="col-5">
											<a><img src="https://static.upbit.com/logos/BTC.png" width="20" height="20"><strong class="ms-1 fs-5">비트코인</strong></a>
											<a><img src="https://static.upbit.com/logos/ETH.png" width="20" height="20"><strong class="ms-1 fs-5">이더리움</strong></a>
											<a><img src="https://static.upbit.com/logos/DOGE.png" width="20" height="20"><strong class="ms-1 fs-5">도지코인</strong></a>
										</div>
									</div>
								</header>		
							</div>
<!-- 게시글 제목 끝 -->  </article>
						<%
						// 클라이언트는 게시글 상세 페이지를 조회할 때 "detail.jsp?no=글번호&pageNo=페이지번호" 로 요청한다.(list.jsp의 78번 라인 참조)
																				// 요청파라미터에서 글번호와 페이지 번호를 조회한다.
																				User loginUserInfo = (User)session.getAttribute("LOGIN_USER_INFO");
																				int no = Integer.parseInt(request.getParameter("no"));
																				int categoryNo = Integer.parseInt(request.getParameter("categoryNo"));
																				
																				String error = request.getParameter("error");
																				String pageNo = request.getParameter("pageNo");
																				
																				
																				// 게시글 정보를 제공하는 BoardDao객체를 획득한다.
																				CoinBoardDao boardDao = CoinBoardDao.getInstance();	
																				
																				int totalRecords = boardDao.getTotalRecords();
																				Pagination pagination = new Pagination(pageNo, totalRecords);
																				
																				// 게시글 번호에 해당하는 글 정보를 조회한다.
																				CoinBoard boardDetail = boardDao.getBoardDetail(no);
																				
																				// 리스트
																				List<CoinBoard> boardList = boardDao.getBoardList(pagination.getBegin(), pagination.getEnd());
																				
																
																				List<BoardComment> commentList = boardDao.getAllComment(no);
																				
																				// 게시글의 조회수를 1 증가시킨다.
																				boardDetail.setViewCount(boardDetail.getViewCount() + 1);
																				
																				// 조회수가 1증가된 글정보를 테이블에 반영시킨다.
																				boardDao.updateBoard(boardDetail);
						%>
							
							<div class="row mb-3">
									<div class="col">
<!-- 오류 처리 시작-->			<%
			if ("deny-delete".equals(error)) {
			%>
										<div class="alert alert-danger">
											<strong>삭제 실패!!</strong> 자신이 작성한 글이 아닌 경우 삭제할 수 없습니다.
										</div>
							<%
							} else if ("deny-update".equals(error)) {
							%>
										<div class="alert alert-danger">
											<strong>수정 실패!!</strong> 자신이 작성한 글이 아닌 경우 수정할 수 없습니다.
										</div>
							<%
							} else if ("deny-like".equals(error)) {
							%>
									<script type="text/javascript">
									 	alert("이미 추천한 글이거나 자신의 글은 추천할 수 없습니다.");									
									</script>
							<%
							}else if("deny-bookmark".equals(error)){
							%>
									<script type="text/javascript">
									 	alert("이미 즐겨찾기한 글은 즐겨찾기 할 수 없습니다.");									
									</script>
							<%
							}else if("commentId".equals(error)){
							%>
								    <script type="text/javascript">
									 	alert("댓글 작성자만 삭제 가능합니다.");									
									</script>
							<%
							}else if("noLogin".equals(error)){
							%>	
								loginPlease();
							<% 	
							}else if("noComment".equals(error)){
							%>
								 <script type="text/javascript">
									 	alert("댓글 내용을 입력하세요.");									
								 </script>
							<% 	
							}
							if("like".equals(error)){
							%>
								<script type="text/javascript">
							 		alert("추천이 완료 되었습니다.");									
								</script>
							<% 	
							}
							%>
<!-- 오류 처리 끝 -->
<!-- 게시글 작성 부분 --><article>
						 <table class="table">
								<thead class="table-light">
										<tr><td><%=boardDetail.getTitle()%></td></tr>
								</thead>	
								<tbody>
									<tr>
										<td>
											<div class="col">
												<div class="col d-flex justify-content-between mb-3">
													<div>
														<a><%=boardDetail.getWriter().getId()%></a> 
														<a><%=boardDetail.getCreatedDate()%></a>
													</div>						
													<div class="d-flex flex-row-reverse">
														<a class="ms-2">조회 <%=boardDetail.getViewCount()%></a>
														<a>추천 <%=boardDetail.getLikeCount()%></a>				
													</div>
												</div>
											</div>
										</td>
									</tr>
<!-- 게시글 작성 시작 -->				<tr class="d-flex h-auto">		
										<td style="height: 400px" class="col row ms-2"><%=boardDetail.getContent()%>
											<div class="d-flex justify-content-center align-self-end">
<!-- 개념 비추 폼 박스 -->							<div class="border p-3 bg-light"style="height: 100px; width: 120px;">	
													<div class="row">
														<div class="col-3">
															<p class="text-danger fs-1"><%=boardDetail.getLikeCount()%></p>
														</div>
														<%
														if(loginUserInfo==null){
														%>
														<div class="col-3">
															<a onclick="loginPlease()"><img class="m-1" src="../resources/images/like.png"></a>
														</div>
														<%
															}else{
															%>
														<div class="col-3">
															<a href="like.jsp?no=<%=boardDetail.getNo()%>&categoryNo=5"><img class="m-1" src="../resources/images/like.png"></a>
														</div>
														<%
														}
														%>
													</div>
												</div>	
											</div>
									    </td>
									</tr>
							</tbody>				
						</table>
					</div>
				</div>
					<div>
<!-- 댓글 -->				<table class="table">
							<div="grid">
							<%
							for(BoardComment comments : commentList){
							%>
								<tr class="d-flex ms-3">
									<td class="col-2"><%=comments.getUser().getId()%></td>
									<td class="col-6"><%=comments.getContent()%></td>
									<td class="col-3"><%=DateUtils.dateToString(comments.getCreatedDate())%></td>
									<td class="col-1"><a href="deleteComment.jsp?writerNo=<%=comments.getUser().getNo()%>&commentNo=<%=comments.getNo()%>&no=<%=boardDetail.getNo()%>&categoryNo=<%=categoryNo%>"><img class="m-1" src="../resources/images/deleteBox.png"></a></td>
								</tr>
							<%
							}
							%>
							</div>
						</table>
					</div>
						<div class="row mb-3">
							<div class="col">
								<table class="table table-sm bg-light">
									<%
									if(loginUserInfo==null){
									%>
									<tr>
									<td class="col-2 p-3">
										<input class="form-control" type="text" value="로그인" aria-label="Disabled input example" disabled readonly>
									</td>
									<td class="col-10 p-3">
										<textarea class="form-control" id="exampleFormControlTextarea1" rows="3" disabled readonly>로그인 유저만 작성</textarea>
									</td>
									</tr>
									<tr>
										<td></td>
											<td>
												<div class="d-flex flex-row-reverse">
													<a class="btn btn-primary ms-1" onclick="loginPlease()">등록</a>
												</div>
											</td>						
									</tr>
									<%
									}else{
									%>
									<form class="border p-3 bg-light" method="post" action="insertComment.jsp?no=<%=boardDetail.getNo()%>&categoryNo=<%=categoryNo%>">
										<tr>
												<td class="col-2 p-3">
													<input class="form-control" type="text" value="<%=loginUserInfo.getId()%>" name="commentWriter" aria-label="Disabled input example" disabled readonly>
												</td>
												<td class="col-10 p-3">
													 <textarea class="form-control" name="comment" rows="3"></textarea>
												</td>
										</tr>												
										<tr>
										<td></td>
											<td>
												<div class="d-flex flex-row-reverse">
													<button type="submit" class="btn btn-primary ms-1">등록</button>
												</div>
											</td>						
										</tr>
									</form>
									<%
									}
									%>
										</table>
									</div>
							</div>
<!-- 버튼 시작 -->
								<div class="row mb-3 mt-3">
									<div class="col">
											<div class="col d-flex justify-content-between mb-3">
												<div>
													<a href="list.jsp?list=no&categoryNo=<%=categoryNo%>" class="btn btn-primary">전체글</a>
													<a href="list.jsp?list=view&categoryNo=<%=categoryNo%>" class="btn btn-primary">개념글</a>
												</div>						
												<div class="d-flex flex-row-reverse">
													
													<%
																										if(loginUserInfo==null){
																										%>
														<a class="btn btn-primary ms-1" onclick="loginPlease()">글쓰기</a>
														<a class="btn btn-danger ms-1" onclick="loginPlease()">삭제</a>
														<a class="btn btn-primary ms-1"onclick="loginPlease()">수정</a>
													<%
													}
																								 else if(boardDetail.getWriter().getId().equals(loginUserInfo.getId())){
													%>
														<a href="form.jsp" class="btn btn-primary ms-1">글쓰기</a>
														<a href="delete.jsp?no=<%=boardDetail.getNo()%>" class="btn btn-danger ms-1">삭제</a>
														<a href="modifyform.jsp?no=<%=boardDetail.getNo()%>" class="btn btn-primary ms-1">수정</a>
													<%
													}else{
													%>
														<a href="form.jsp" class="btn btn-primary ms-1">글쓰기</a>
													  	<a class="btn btn-danger ms-1" onclick="otherUser()">삭제</a>
														<a class="btn btn-primary ms-1"onclick="otherUser()">수정</a>
														<a href="bookmarkInsert.jsp?no=<%=boardDetail.getNo()%>&categoryNo=<%=categoryNo%>" class="btn btn-primary ms-1">즐겨찾기</a>
													<%
													}
													
													%>
													
																
												</div>
											</div>
									</div>
								</div>
<!-- 게시글 작성 부분 끝--></article>		
<!-- 게시글 목록 시작 --> <article> 		
							<div class="col d-flex justify-content-between mb-3 mt-2">
									<div>
										<a href="list.jsp?list=no&categoryNo=<%=categoryNo%>" class="btn btn-primary">전체글</a>
										<a href="list.jsp?list=view&categoryNo=<%=categoryNo%>" class="btn btn-primary">개념글</a>
									</div>						
							</div>
							<ul class="time_list">
								
								
								<table class="table table-sm">
										<thead>
											<tr class="d-flex border-top border-primary">
												<th class="col-2">번호</th>
												<th class="col-5"><div class="mx-auto" style="width: 90px;">제목</div></th>
												<th class="col-1">글쓴이</th>
												<th class="col-2">작성일</th>
												<th class="col-1">조회</th>
												<th class="col-1">추천</th>
											</tr>
										</thead>
										<tbody>
						<%
						if (boardList.isEmpty()) {
						%>
											<tr>
												<td class="text-center" colspan="6">게시글이 존재하지 않습니다.</td>
											</tr>
						<%
						}else{
											for (CoinBoard board : boardList) {
						%>
											<tr class="d-flex">
												<td class="col-1"><%=board.getNo() %></td>
												<td class="col-6"><a href="detail.jsp?no=<%=board.getNo()%>&categoryNo=<%=categoryNo%>"><%=board.getTitle()%>
												 <%
												if(board.getCommentCount()>0){
												%>
												(<%=board.getCommentCount() %>)
												<%
												}
												%>
												</a></td>
												<td class="col-1"><%=board.getWriter().getId()%></td>
												<td class="col-2"><%=board.getCreatedDate()%></td>
												<td class="col-1"><%=board.getViewCount()%></td>
												<td class="col-1"><%=board.getLikeCount()%></td>
											</tr>
						<%
							}
						}
						%>
										</tbody>	
									</table>	
<!-- 게시글 목록 끝 -->			</ul>
<!-- 아래 버튼 시작 -->			<div class="col d-flex justify-content-between mt-2">
							<!-- 플렉스(flex): https://getbootstrap.kr/docs/5.1/utilities/flex/ -->
												<!-- div 기준으로 양옆으로 배치 -->
												<div>
													<a href="list.jsp?list=no" class="btn btn-primary">전체글</a>
													<a href="list.jsp?list=view" class="btn btn-primary">개념글</a>
												</div>
												<!-- div 기준으로 끝쪽으로 배치 -->
												<div class="d-flex flex-row-reverse">
													<%
													 if(loginUserInfo==null){
													%>
														<a class="btn btn-primary ms-1" onclick="loginPlease()">글쓰기</a>
													<%
													 }
													 else{
													%>
														<a href="form.jsp" class="btn btn-primary ms-1">글쓰기</a>
													<%
													}
													%>
												</div>
<!-- 아래 버튼 끝 -->			</div>
							
<!-- 페이지버튼 시작 -->	
<div class="row mb-3">
		<div class="col-6 offset-3">
			<nav>
				<ul class="pagination justify-content-center">
					<!-- 
						Pagination객체가 제공하는 isExistPrev()는 이전 블록이 존재하는 경우 true를 반환한다.
						Pagination객체가 제공하는 getPrevPage()는 이전 블록의 마지막 페이지값을 반환한다.
					 -->
					<li class="page-item <%=!pagination.isExistPrev() ? "disabled" : "" %>"><a class="page-link" href="list.jsp?pageNo=<%=pagination.getPrevPage()%>&categoryNo=<%=categoryNo%>" >이전</a></li>
<%
	// Pagination 객체로부터 해당 페이지 블록의 시작 페이지번호와 끝 페이지번호만큼 페이지내비게이션 정보를 표시한다.
	for (int num = pagination.getBeginPage(); num <= pagination.getEndPage(); num++) {
%>					
					<li class="page-item <%=pagination.getPageNo() == num ? "active" : "" %>"><a class="page-link" href="detail.jsp?no=<%=boardDetail.getNo() %>&pageNo=<%=num%>&categoryNo=<%=categoryNo%>"><%=num %></a></li>
<%
	}
%>					
					<!-- 
						Pagination객체가 제공하는 isExistNext()는 다음 블록이 존재하는 경우 true를 반환한다.
						Pagination객체가 제공하는 getNexPage()는 다음 블록의 첫 페이지값을 반환한다.
					 -->
					<li class="page-item <%=!pagination.isExistNext() ? "disabled" :"abled" %>"><a class="page-link" href="list.jsp?pageNo=<%=pagination.getNextPage()%>&categoryNo=<%=categoryNo%>" >다음</a></li>
				</ul>
			</nav>
		</div>
	</div>	
<!-- 페이지버튼 끝 -->	 

						</article>
					</section>
<!-- 오른쪽 섹션 시작 --><section class="right_content ms-3">
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
	function loginPlease(){
		alert("로그인이 필요합니다.");
	}
	
	function otherUser(){
		alert("작성자만이 수정/삭제가 가능합니다.");
	}
	
	function 즐겨찾기완료(){
		alert("즐겨찾기 되었습니다.");
	}
</script>
</body>
</html>
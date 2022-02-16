<%@page import="vo.BoardBookmarker"%>
<%@page import="java.util.ArrayList"%>
<%@page import="vo.Pagination"%>
<%@page import="vo.BoardLiker"%>
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
    <title></title>
    <%@ include file="../common/mybar2.jsp" %>
</head>
<body>
	<div class="dcwrap">
			<div class="wrap_inner">
				<main class="container">
					<section class="left_content h-auto">
<!-- 게시글 제목 시작 --> <article>
							<div class="time_best">
								<header class="time_head">
										<div class="coinTitle col-3"><h2 class="fw-bold">즐겨찾기 목록</h2></div>
								</header>	
							</div>
<!-- 게시글 제목 끝 -->  </article>
<%
			int userNo = Integer.parseInt(request.getParameter("no"));
			int categoryNo = Integer.parseInt(request.getParameter("categoryNo"));
			
			String pageNo = request.getParameter("pageNo");
			
			CoinBoardDao boardDao = CoinBoardDao.getInstance();
			
			int totalRecords = boardDao.getBookmarkRecords(userNo);
			int getBookmarkAllCount = boardDao.getBookmarkAllCount(userNo, categoryNo);
			int getBookmarkCount[] = {0,0,0,0,0,0,0};
			String boardCategory[] = {"[동기]","[디아]","[주식]","[축구]","[코인]","[핫플]"};
			Pagination pagination = new Pagination(pageNo, totalRecords);
			
		
			// 즐겨찾기에 등록된 게시물의 번호가 들어있는 리스트
			//List<BoardLiker> bookmarkList = boardDao.getBookmarks(userNo);
			// List<BoardLiker> bookmarkList = boardDao.getBookmarksByCategory(userNo, categoryNo);
			List<BoardBookmarker> bookmarkList = boardDao.getBookmarksByCategorys(userNo, categoryNo);
			
			List<CoinBoard> boardList = new ArrayList<>();
			
			for(int category=1;category<7;category++){
				getBookmarkCount[category] = boardDao.getBookmarkCount(userNo, category);
			}
			
			for (BoardBookmarker bookmark : bookmarkList) {
				//Board board = boardDao.getBoardBookmark(bookmark.getBoardNo(),pagination.getBegin(), pagination.getEnd());
				CoinBoard board = boardDao.getBoardBookmarks(bookmark.getBoardNo(),bookmark.getCategoryNo(),pagination.getBegin(), pagination.getEnd());
				boardList.add(board);
			}
%>
					<div>
						<nav class="nav">
							<ul class="nav_list">
								<li><a class="bookmarkList"href="bookmarkform.jsp?no=<%=loginUserInfo.getNo()%>&categoryNo=0">전체(<%=getBookmarkAllCount %>)</a></li>
								<li><a class="bookmarkList"href="bookmarkform.jsp?no=<%=loginUserInfo.getNo()%>&categoryNo=1">동물, 기타(<%=getBookmarkCount[1]%>)</a></li>
								<li><a class="bookmarkList"href="bookmarkform.jsp?no=<%=loginUserInfo.getNo()%>&categoryNo=2">디아블로(<%=getBookmarkCount[2]%>)</a></li>
								<li><a class="bookmarkList"href="bookmarkform.jsp?no=<%=loginUserInfo.getNo()%>&categoryNo=3">주식(<%=getBookmarkCount[3]%>)</a></li>
								<li><a class="bookmarkList"href="bookmarkform.jsp?no=<%=loginUserInfo.getNo()%>&categoryNo=4">축구(<%=getBookmarkCount[4]%>)</a></li>
								<li><a class="bookmarkList"href="bookmarkform.jsp?no=<%=loginUserInfo.getNo()%>&categoryNo=5">코인(<%=getBookmarkCount[5]%>)</a></li>
								<li><a class="bookmarkList"href="bookmarkform.jsp?no=<%=loginUserInfo.getNo()%>&categoryNo=6">핫플레이스(<%=getBookmarkCount[6]%>)</a></li>
							</ul>
						</nav>
					</div>			
									

<!-- 게시글 시작 --> 	 <article> 		
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
						if (bookmarkList.isEmpty()) {
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
												<td class="col-6"><a href="detail.jsp?no=<%=board.getNo()%>&categoryNo=<%=board.getTypeCode()%>"><%=boardCategory[board.getTypeCode()-1]%><%=board.getTitle()%></a></td>
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
<!-- 게시글 끝 -->			</ul>
				
							
<!-- 페이지버튼 시작 -->		
<div class="row mb-3 mt-3">
		<div class="col-6 offset-3">
			<nav>
				<ul class="pagination justify-content-center">
					<!-- 
						Pagination객체가 제공하는 isExistPrev()는 이전 블록이 존재하는 경우 true를 반환한다.
						Pagination객체가 제공하는 getPrevPage()는 이전 블록의 마지막 페이지값을 반환한다.
					 -->
					<li class="page-item <%=!pagination.isExistPrev() ? "active" : "disabled" %>"><a class="page-link" href="bookmarkform.jsp?pageNo=<%=pagination.getPrevPage()%>" >이전</a></li>
<%
	// Pagination 객체로부터 해당 페이지 블록의 시작 페이지번호와 끝 페이지번호만큼 페이지내비게이션 정보를 표시한다.
	for (int num = pagination.getBeginPage(); num <= pagination.getEndPage(); num++) {
%>					
					<li class="page-item <%=pagination.getPageNo() == num ? "active" : "" %>"><a class="page-link" href="bookmarkform.jsp?pageNo=<%=num%>>"><%=num %></a></li>
<%
	}
%>					
					<!-- 
						Pagination객체가 제공하는 isExistNext()는 다음 블록이 존재하는 경우 true를 반환한다.
						Pagination객체가 제공하는 getNexPage()는 다음 블록의 첫 페이지값을 반환한다.
					 -->
					<li class="page-item <%=!pagination.isExistNext() ? "active" :"disabled" %>"><a class="page-link" href="bookmarkform.jsp?pageNo=<%=pagination.getNextPage()%>" >다음</a></li>
				</ul>
			</nav>
		</div>
	</div>	
<!-- 페이지버튼 끝 -->	  

						</article>
					</section>
<!-- 오른쪽 섹션 시작 --><section class="right_content ms-3">
							<div class="login_box">
								<div class="log_inr">
									<%
									if(loginUserInfo==null){
								%>
								
									<form action="../login.jsp" class="login_process" method="post">
										<div class="login_form">
											<div class="input_box">
												<label for="user_id">아이디</label>
												<input type="text" class="input_text" name="id" id="user_id" placeholder="아이디">
											</div>
											<div class="input_box pw">
												<label for="user_pw">비밀번호</label>
												<input type="password" class="input_text" name="password" id="user_pw" placeholder="비밀번호">
											</div>
										</div>
										<div class="login_set">
											<button type="submit" class="btn_login">로그인</button>
										</div>
									</form>
									<div class="option">
										<a href="registerform.jsp"><strong>회원가입</strong></a>
									</div>
								<%
									}else{
								%>
									<a><%=loginUserInfo.getName() %> 님 환영합니다.</a>
										<div>
											<a href="bookmarkform.jsp?categoryNo=0&no=<%=loginUserInfo.getNo()%>" class="btn btn-primary ms-1">즐겨찾기</a>
											<a href="../logout.jsp?categoryNo=<%=categoryNo %>" class="btn btn-primary ms-1">로그아웃</a>
										</div>
									
								<%
								}
								%>
								</div>
							</div>
							<article>
								<div class="gall_rank">
									<header class="rank_head">
										<h3>실북갤</h3>
									</header>
									<ol class="rank_title">
										<li><a href="#">동물, 기타갤러리</a><span class="count">113</span></li>
										<li><a href="#">디아블로 갤러리</a><span class="count">107</span></li>
										<li><a href="#">주식 갤러리</a><span class="count">95</span></li>
										<li><a href="#">축구 갤러리</a><span class="count">91</span></li>
										<li><a href="#">코인 갤러리</a><span class="count">83</span></li>
										<li><a href="#">핫플레이스 갤러리</a><span class="count">77</span></li>
									</ol>
									<div class="rank_best">
										<ul>
											<li><a href="#">기니피그 귀여워</a></li>
											<li><a href="#">햄스터 간식 뭐 사야대?</a></li>
											<li><a href="#">새 찍은거 봐줘</a></li>
										</ul>
									</div>
								</div>	
							</article>
							<div class="right_banner">
								<img src="../resources/images/right_banner.png" alt="오른쪽 광고">
							</div>
<!-- 오른쪽 섹션 끝 --></section>	
				</main>
			</div>
			<footer class="dcfoot">
				<div class="info_policy">
					<li><a href="#">장정윤</a></li>
					<li><a href="#">강태현</a></li>
					<li><a href="#">신재호</a></li>
					<li><a href="#">이승준</a></li>
					<li><a href="#">이윤재</a></li>
					<li><a href="#">정수민</a></li>
				</div>
				<div class="copyright">Copyright ⓒ 2021 semi_No5. All rights reserved.</div>
			</footer>
</div>				
<script type="text/javascript">
	function loginPlease(){
		alert("로그인이 필요합니다.");
	}
</script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
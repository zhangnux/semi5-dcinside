<%@page import="vo.BoardLiker"%>
<%@page import="vo.Comment"%>
<%@page import="java.util.List"%>
<%@page import="vo.Board"%>
<%@page import="dao4.SoccerBoardDao"%>
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
   <div class="dcwrap">
   <%@include file="/common/navbar.jsp" %>
      <div class="wrap_inner">
         <main class="dc_container">
            <section class="left_content"> 
				<div class="row">
					<div class="col mb-4 mt-2 border-bottom">
						<div class="coinTitle col">
							<h2 class="fw-bold"><a href="list.jsp">축구 갤러리</a></h2>
						</div>
					</div>		
				</div>
<%
	int no = Integer.parseInt(request.getParameter("no"));	

	String pageNo = request.getParameter("pageNo");
	String error = request.getParameter("error");

	SoccerBoardDao boardDao = SoccerBoardDao.getInstance();
	
	Board board = boardDao.getBoardDetail(no);
	
	// 추천 관련 코드
	board.setViewCount(board.getViewCount() + 1);
	boardDao.updateBoard(board);
	
	List<Comment> commentList = boardDao.getAllComment(no);

	User loginUserInfo = (User)session.getAttribute("LOGIN_USER_INFO");	
	
%>
	
	<table class="table">
		<tbody>
			<tr class="d-flex">
				<th class="col-2">번호</th>
				<td class="col-4"><%=board.getNo()%></td>
				<th class="col-2">등록일</th>
				<td class="col-4"><%=board.getCreatedDate()%></td>
			</tr>
			<tr class="d-flex">
				<th class="col-2">제목</th>
				<td class="col-4"><%=board.getTitle()%></td>
				<th class="col-2">작성자</th>
				<td class="col-4"><%=board.getWriter().getName()%></td>
			</tr>
			<tr class="d-flex">
				<th class="col-2">조회수</th>
				<td class="col-4"><%=board.getViewCount()%></td>
				<th class="col-2">추천수</th>
				<td class="col-4"><%=board.getLikeCount()%></td>
			</tr>
			<tr class="d-flex">
				<th class="col-2">내용</th>
				<td class="col-10"><%=board.getContent()%></td>
			</tr>
		</tbody>		
	</table>
	<div class="row">
		<div class="col">
			<div class="col d-flex justify-content-between">
				<div>
				
					<a href="list.jsp?pageNo=1" class="btn btn-primary">전체글</a>
					
				</div>
	
	<%
		if (loginUserInfo != null && loginUserInfo.getNo() == board.getWriter().getNo()) {
		%>
				<div>
					 <a href="updateform.jsp?no=<%=board.getNo()%>&pageNo=<%=pageNo%>&title=<%=board.getTitle()%>&content=<%=board.getContent()%>" class="btn btn-secondary">수정</a>
					<a href="delete.jsp?no=<%=board.getNo()%>&pageNo=<%=pageNo%>" class="btn btn-danger">삭제</a>
				</div>
<%
}
%>
		</div>
	</div>
</div>
<%
if (loginUserInfo != null && loginUserInfo.getNo() != board.getWriter().getNo()) {
		BoardLiker boardLiker = boardDao.getBoardLiker(board.getNo(), loginUserInfo.getNo());
%>					
					<div class="text-end border-bottom">
					<a href="like.jsp?no=<%=board.getNo()%>&pageNo=<%=pageNo%>" class="btn btn-success <%=boardLiker != null ? "disabled" : ""%>">추천</a>
					</div>

<%
}
%>
	<div class="row mt-5 mb-3">
      <div class="col pt-1 pb-1">
      <div class="border-top">
	
<%
	if ("commmentId".equals(error)){
	%>
      <div class="alert alert-danger" role="alert">
        로그인이 필요합니다.
      </div>
<%
}
%>

   <!-- 댓글창시작 -->
<%
if(!commentList.isEmpty()){   

      for(Comment comments : commentList){
%>
            <div class="row p-2">
               <div class="col <%=comments.getOrder() != 0 ? "ps-5" : ""%>">
                  <div class="row <%=comments.getOrder() != 0 ? "border pt-2 pb-2" : ""%>">
                     
<%
                     if (comments.getDeleted().equals("Y")) {
                     %>
 							<div class="col-12">삭제된 댓글입니다.</div>                    
<%
                     } else {
                     %>
                     <div class="col-2 text-muted fs-9"><%=comments.getWriter().getName()%></div>
                     <div class="col-7"><%=comments.getContent()%></div>
                     <div class="col-2 fs-9"><%=comments.getCreatedDate()%></div>
                     <div class="col-1">
                     <!-- 답글달기 아이콘 -->
                     <%
                     if(loginUserInfo!=null && comments.getOrder() == 0) {
                     %>
                        <i class="fa  fa-commenting-o" aria-hidden="true" onclick="toggleform('form-<%=comments.getNo()%>')"></i>
                     <%
                     } 
                                             // 댓글 삭제 아이콘                     
                                             if(loginUserInfo != null && loginUserInfo.getNo() == comments.getWriter().getNo()) {
                     %>            
      
                        <a href="http://localhost/semi5/4/commdelete.jsp?boardNo=<%=board.getNo()%>&writerNo=<%=comments.getWriter().getNo()%>&commentNo=<%=comments.getNo()%>">
                        <i class="fa  fa-trash" aria-hidden="true"></i><button class="btn btn-outline-danger">삭제</button></a>
                     <%
                     }
                     %>                        
                     </div> 
<%
 }
 %>
				</div>
			</div>
		</div>
<%
}
%>
			</div>
		</div>
	</div>

<%
} else {
%>
         <div class="col ps-5">
            <div class="row px-3 py-2">
               작성된 댓글이 없습니다.
            </div>
         </div>
<%
}
%>

      
<%
      if (loginUserInfo == null) {
      %>
   		<div class="row mb-3 px-3 py-2">
     		 <div class="col">
       		  <div class="alert alert-secondary py-2">
        		    로그인 작성자만 댓글을 작성 할 수 있습니다.
      		   </div>
    		  </div>
   		</div>

<%
} else {
%>
  		 <!-- 댓글 달기 창 -->
  		 <div class="row mb-3 px-3 py-2">
    		  <div class="col">
       		  <form method="post" action="http://localhost/semi5/4/comment.jsp" class="border bg-light p-2">
          		  <input type="hidden" name="boardNo" value="<%=board.getNo()%>" />
          		  <div class="row g-3">
            		   <div class="col-11">
            		      <textarea placeholder="타인의 권리를 침해하거나 명예를 훼손하는 댓글은 운영원칙 및 관련법률에 제재를 받을 수 있습니다." rows="5" name="content" class="form-control" style="resize: none;"></textarea>
            		   </div>
            		   <div class="col-1">
            		      <button type="submit" class="btn btn-primary ">등록</button>
           		    </div>
          		  </div>
        		 </form>
     		 </div>
   		</div>
<%
}
%>
            </section>
            <section class="right_content">
               <%@include file="/common/right_section.jsp" %>
            </section>
         </main>
      </div>
      <%@include file="/common/footer.jsp" %>
   </div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
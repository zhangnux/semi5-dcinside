<%@page import="vo.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<link rel="stylesheet" href="common/dc_style.css">
	<title>## CONNECTING HEARTS! 디시인사이드입니다. ## </title>
</head>
<body>
	<div class="dcwrap">
		<header class="header">
			<div class="head">
				<h1 class="logo">
					<a href="index.jsp"><img src="resources/images/dc_logo.png" alt="dc_logo"></a>
				</h1>
				<ul class="head_list">
					<li><a href="#">HIT 갤러리</a></li>
					<li><a href="#">실시간 베스트</a></li>
					<li><a href="rightContent.jsp">실북갤</a></li>
				</ul>
			</div>
		</header>
		<div class="gnb_bar">
			<nav class="nav">
				<ul class="nav_list">
					<li class="list_gall">갤러리</li>
					<li><a href="#">동물, 기타</a></li>
					<li><a href="#">디아블로</a></li>
					<li><a href="stock/list.jsp">주식</a></li>
					<li><a href="#">축구</a></li>
					<li><a href="#">코인</a></li>
					<li><a href="#">핫플레이스</a></li>
				</ul>
			</nav>
		</div>
		<div class="wrap_inner">
			<main class="container">
				<section class="left_content">
					<article>
						<div class="hit_content">
							<header class="hit_head">
								<h3>HIT 갤러리</h3>
							</header>
							<ul class="hit_list"> <!-- li 보여주는 갯수는 4개까지 -->
								<li>
									<a href="#">귀여운 두더쥐 보고 가...</a>
									<div class="hit_info"><span class="hit_gall_name">동물, 기타</span><span class="hit_date">12-02</span></div>
								</li>
								<li>
									<a href="#">아메리카 갓 탤런트에 피아노 치는 닭 출연,.jpg</a>
									<div class="hit_info"><span class="hit_gall_name">동물, 기타</span><span class="hit_date">12-02</span></div>
								</li>
								<li>
									<a href="#">누워서 밥먹는 햄스터ㅋㅋㅋㅋ</a>
									<div class="hit_info"><span class="hit_gall_name">동물, 기타</span><span class="hit_date">12-02</span></div>
								</li>
								<li>
									<a href="#">1박 2일 자전거 여행하면서 본 동물들</a>
									<div class="hit_info"><span class="hit_gall_name">동물, 기타</span><span class="hit_date">12-02</span></div>
								</li>
							</ul>
						</div>
					</article>
					<div class="left_banner">
						<img src="resources/images/left_banner.png" alt="왼쪽 광고">
					</div>
					<article>
						<div class="time_best">
							<header class="time_head">
								<h3>실시간베스트</h3>
							</header>
							<ul class="time_list">
								<li>
									<a href="#"><p>아무말이나 적어야 하는데 참 할 말이 없네여....</p></a>
									<div class="best_info"><span class="gall_name">디아블로</span><span class="date">12-02</span></div>	
								</li>
								<li>
									<a href="#"><p>아 아 실험중 </p></a>
									<div class="best_info"><span class="gall_name">코인</span><span class="date">12-02</span></div>								
								</li>
								<li>
									<a href="#"><p>할 말이 없으면 lorem ipsum을 쓰자...!!!</p></a>
									<div class="best_info"><span class="gall_name">핫플레이스</span><span class="date">12-02</span></div>
								</li>
								<li>
									<a href="#"><p>계엄을 선포한 때에는 대통령은 지체없이 국회에 통고하여야 한다</p></a>
									<div class="best_info"><span class="gall_name">동물, 기타</span><span class="date">12-02</span></div>
								</li>
								<li>
									<a href=#"><p>국가는 농수산물의 수급균형과 유통구조의 개선에 노력하여 가격안정을 도모함으로써 농·어민의 이익을 보호한다. </p></a>
									<div class="best_info"><span class="gall_name">축구</span><span class="date">12-02</span></div>
								</li>
								<li>
									<a href="#"><p>국회의원은 국가이익을 우선하여 양심에 따라 직무를 행한다.</p></a>
									<div class="best_info"><span class="gall_name">주식</span><span class="date">12-02</span></div>
								</li>
								<li>
									<a href="#"><p>대한민국의 주권은 국민에게 있고, 모든 권력은 국민으로부터 나온다.</p></a>
									<div class="best_info"><span class="gall_name">디아블로</span><span class="date">12-02</span></div>
								</li>
								<li>
									<a href="#"><p>대통령은 제4항과 제5항의 규정에 의하여 확정된 법률을 지체없이 공포하여야 한다.</p></a>
									<div class="best_info"><span class="gall_name">동물, 기타</span><span class="date">12-02</span></div>
								</li>
								<li>
									<a href="#"><p>행정각부의 설치·조직과 직무범위는 법률로 정한다.</p></a>
									<div class="best_info"><span class="gall_name">핫플레이스</span><span class="date">12-02</span></div>
								</li>
								<li>
									<a href="#"><p>사회적 특수계급의 제도는 인정되지 아니하며, 어떠한 형태로도 이를 창설할 수 없다.</p></a>
									<div class="best_info"><span class="gall_name">축구</span><span class="date">12-02</span></div>
								</li>
								<li>
									<a href="#"><p>모든 국민은 법률이 정하는 바에 의하여 국가기관에 문서로 청원할 권리를 가진다. </p></a>
									<div class="best_info"><span class="gall_name">동물, 기타</span><span class="date">12-02</span></div>
								</li>
								<li>
									<a href="#"><p>교육의 자주성·전문성·정치적 중립성 및 대학의 자율성은 법률이 정하는 바에 의하여 보장된다.</p></a>
									<div class="best_info"><span class="gall_name">주식</span><span class="date">12-02</span></div>
								</li>
								<li>
									<a href="#"><p>정부위원은 국회나 그 위원회에 출석하여 국정처리상황을 보고하거나 의견을 진술하고 질문에 응답할 수 있다. </p></a>
									<div class="best_info"><span class="gall_name">코인</span><span class="date">12-02</span></div>
								</li>
								<li>
									<a href="#"><p>모든 국민은 법 앞에 평등하다.</p></a>
									<div class="best_info"><span class="gall_name">코인</span><span class="date">12-02</span></div>
								</li>
								<li>
									<a href="#"><p>국가는 과학기술의 혁신과 정보 및 인력의 개발을 통하여 국민경제의 발전에 노력하여야 한다. </p></a>
									<div class="best_info"><span class="gall_name">핫플레이스</span><span class="date">12-02</span></div>
								</li>
								<li>
									<a href="#"><p>선거와 국민투표의 공정한 관리 및 정당에 관한 사무를 처리하기 위하여 선거관리위원회를 둔다.</p></a>
									<div class="best_info"><span class="gall_name">축구</span><span class="date">12-02</span></div>
								</li>
								<li>
									<a href="#"><p>전직대통령의 신분과 예우에 관하여는 법률로 정한다. </p></a>
									<div class="best_info"><span class="gall_name">디아블로</span><span class="date">12-02</span></div>
								</li>
								<li>
									<a href="#"><p>대통령의 선거에 관한 사항은 법률로 정한다.</p></a>
									<div class="best_info"><span class="gall_name">주식</span><span class="date">12-02</span></div>
								</li>
							</ul>
						</div>
					</article>
				</section>
					<%@ include file="common/right_section.jsp" %>
			</main>
		</div>
		
		<!-- footer Start -->
		<%@ include file="common/footer.jsp" %>
		<!-- footer End -->
	</div>
</body>
<!-- script -->
</html>
	</div>	
</body>
</html>
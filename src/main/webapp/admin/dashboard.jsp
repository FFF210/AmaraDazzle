<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags"%>


<!DOCTYPE html>
<html>
<!-- 헤드부분 -->
<%@ include file="./common/config.jsp"%>

<title>홈</title>
<link rel="stylesheet" href="./css/dashboard.css" />

<!-- Chartjs cdn -->
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<!-- 헤드부분 end -->

<body>

	<!-- 레이아웃 + 메인컨텐츠 -->
	<my:adminLayout>
		<section class="part1">
			<article class="statistics1">
				<!-- 카드섹션 -->
				<div class="card_section">
					<!-- 당일 총 주문 건수 -->
					<div class="stats_card">
						<div class="card_header">
							<div class="card_title" id="orderCardTitle">당일 총 주문건수 | Today</div>
							<div class="card_updouwn">
								<i class="bi bi-three-dots" onclick="cardChange('order')"></i>
							</div>
						</div>
						<div class="card_value">
							<div class="stats_number" >
								<b id="totalOrderCnt"></b>
							</div>
							<div class="stats_updouwn" >
								<b id="orderDiffPercent"></b> 
								<span id="orderFrom">from yesterday</span>
							</div>
						</div>
					</div>
					<!-- 당일 신규가입자수  -->
					<div class="stats_card">
						<div class="card_header">
							<div class="card_title" id="memberCardTitle">당일 신규가입자수 | Today</div>
							<div class="card_updouwn">
								<i class="bi bi-three-dots" onclick="cardChange('member')"></i>
							</div>
						</div>
						<div class="card_value">
							<div class="stats_number">
								<b id="totalMemberCnt"></b>
							</div>
							<div class="stats_updouwn">
								<b id="memberDiffPercent"></b> 
								<span id="memberFrom">from yesterday</span>
							</div>
						</div>
					</div>
					<!-- 당일 방문자 수 -->
					<div class="stats_card">
						<div class="card_header">
							<div class="card_title" id="visitCardTitle">당일 방문자 수 | Today</div>
							<div class="card_updouwn">
								<i class="bi bi-three-dots" onclick="cardChange('visit')"></i>
							</div>
						</div>
						<div class="card_value">
							<div class="stats_number">
								<b id="totalVisitCnt">7,526건</b>
							</div>
							<div class="stats_updouwn">
								<b id="visitDiffPercent">+12.5%</b> 
								<span id="visitFrom">from yesterday</span>
							</div>
						</div>
					</div>
				</div>
				<!-- 카드섹션 end -->
				
				<!-- 라인차트섹션 -->
				<div class="chart_section">
					<div>
						<canvas id="barChart"></canvas>
					</div>
				</div>
				<!-- 라인차트섹션 end -->
			</article>
			
			<!-- 도넛차트부분 -->
			<article class="statistics2">
				<div>
					<canvas id="doughnutChart"></canvas>
				</div>
				<div>
					<canvas id="pieChart"></canvas>
				</div>
			</article>
			<!-- 도넛차트부분 end -->
		</section>
		
		<section class="part2">
			<!-- 테이블 차트섹션 -->
			<article class="table_section">
				<!-- 베스트셀러 TOP5 -->
				<div class="bestSeller">
					<div class="table_title">BEST SELLER TOP 5 </div>
					<div class="table_wrap">
						<table>
							<colgroup>
								<col style="width: 5%" />
								<col style="width: 30%" />
								<col style="width: 10%" />
								<col style="width: 10%" />
								<col style="width: 15%" />
								<col style="width: 15%" />
								<col style="width: 15%" />
							</colgroup>
							<thead>
								<tr>
									<th>#</th>
									<th>상품명</th>
									<th>브랜드</th>
									<th>판매가</th>
									<th>이번달 판매량</th>
									<th>지난달 판매량</th>
									<th>변화율</th>
								</tr>
							</thead>
							<tbody id="bestPdTable"></tbody>
						</table>
					</div>
				</div>

				<!-- 판매율 높은 브랜드 TOP5 -->
				<div class="bestBrand">
					<div class="table_title">BestBrand TOP 5</div>
					<div class="table_wrap">
						<table>
							<colgroup>
								<col style="width: 5%" />
								<col style="width: 30%" />
								<col style="width: 20%" />
								<col style="width: 20%" />
								<col style="width: 25%" />
							</colgroup>
							<thead>
								<tr>
									<th>#</th>
									<th title="">브랜드명</th>
									<th>셀러코드</th>
									<th>구독여부</th>
									<th>전월 순이익</th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td>1</td>
									<td class="title_cell"></td>
									<td></td>
									<td></td>
									<td></td>
								</tr>
							</tbody>
						</table>
					</div>
				</div>
			</article>
			<!-- 테이블 차트섹션 end -->
		</section>
<!-- 		<section class="part2"> -->
<!-- 			<div> -->
<%-- 				<canvas id="doughnutChart"></canvas> --%>
<!-- 			</div> -->
<!-- 			<div> -->
<%-- 				<canvas id="pieChart"></canvas> --%>
<!-- 			</div> -->
<!-- 			<div> -->
<%-- 				<canvas id="radarChart"></canvas> --%>
<!-- 			</div> -->
<!-- 		</section> -->
	</my:adminLayout>
	<!-- 레이아웃 + 메인컨텐츠 end -->






	<!-- JS부분 -->
	<script src="./js/dashboard.js"></script>
	<!-- JS부분 end -->

</body>
</html>
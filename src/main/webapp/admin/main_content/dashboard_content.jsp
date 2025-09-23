<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>



<section class="part1">
	<!-- 카드섹션 -->
	<article class="card_section">
		<!-- 당일 총 주문 건수 -->
		<div class="stats_card">
			<!-- <div class="stats_compare"><i class="bi bi-three-dots"></i></div> -->
			<div class="card_header">
				<div class="card_title">당일 총 주문건수</div>
				<!-- <div class="card_updouwn">↑UP</div> -->
				<div class="card_updouwn">
					<i class="bi bi-three-dots"></i>
				</div>
			</div>
			<div class="card_value">
				<div class="stats_number">
					<b>7,265 건</b>
				</div>
				<div class="stats_updouwn">+11.01 %</div>
			</div>
		</div>
		<!-- 당일 방문수 -->
		<div class="stats_card">
			<div class="card_header">
				<div class="card_title"></div>
				<div class="card_updouwn"></div>
			</div>
			<div class="card_value">
				<div class="stats_number"></div>
				<div class="stats_updouwn"></div>
			</div>
		</div>
		<!-- 당일 신규가입자수 -->
		<div class="stats_card">
			<div class="card_header">
				<div class="card_title"></div>
				<div class="card_updouwn"></div>
			</div>
			<div class="card_value">
				<div class="stats_number"></div>
				<div class="stats_updouwn"></div>
			</div>
		</div>
		<!-- 당일 신규가입자수 -->
		<div class="stats_card">
			<div class="card_header">
				<div class="card_title"></div>
				<div class="card_updouwn"></div>
			</div>
			<div class="card_value">
				<div class="stats_number"></div>
				<div class="stats_updouwn"></div>
			</div>
		</div>
	</article>
	<!-- 카드섹션 end -->

	<!-- 라인차트섹션 -->
	<article class="chart_section">
		<div>
			<canvas id="lineChart"></canvas>
		</div>
	</article>
	<!-- 라인차트섹션 end -->

	<!-- 테이블 차트섹션 -->
	<article class="table_section">
		<!-- 베스트셀러 TOP5 -->
		<div class="bestSeller">
			<div class="table_title">BEST SELLER TOP 5</div>
			<div class="table_wrap">
				<table>
					<colgroup>
						<col style="width: 5%" />
						<col style="width: 15%" />
						<col style="width: 15%" />
						<col style="width: 15%" />
						<col style="width: 15%" />
					</colgroup>
					<thead>
						<tr>
							<th>#</th>
							<th>상품명</th>
							<th>상품코드</th>
							<th>판매가</th>
							<th>브랜드</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td>1</td>
							<td class="title_cell" title="">바디네이쳐 헤어리무버 바디네이쳐 헤어리무버
								바디네이쳐 헤어리무버 바디네이쳐 헤어리무버</td>
							<td>P123456</td>
							<td>4,490</td>
							<td>바디네이쳐</td>
						</tr>
						<tr>
							<td>2</td>
							<td class="title_cell">바디네이쳐 헤어리무버</td>
							<td>P123456</td>
							<td>4,490</td>
							<td>바디네이쳐</td>
						</tr>
						<tr>
							<td>3</td>
							<td class="title_cell">바디네이쳐 헤어리무버</td>
							<td>P123456</td>
							<td>4,490</td>
							<td>바디네이쳐</td>
						</tr>
						<tr>
							<td>4</td>
							<td class="title_cell">바디네이쳐 헤어리무버</td>
							<td>P123456</td>
							<td>4,490</td>
							<td>바디네이쳐</td>
						</tr>
						<tr>
							<td>5</td>
							<td class="title_cell">바디네이쳐 헤어리무버</td>
							<td>P123456</td>
							<td>4,490</td>
							<td>바디네이쳐</td>
						</tr>
					</tbody>
				</table>
			</div>
		</div>

		<!-- 판매율 높은 브랜드 TOP5 -->
		<div class="bestBrand">
			<div class="table_title">판매율 높은 브랜드 TOP 5</div>
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
							<td class="title_cell">두번째 행 제목 (짧음)</td>
							<td>데이터 2-2</td>
							<td>데이터 2-3</td>
							<td>데이터 2-4</td>
						</tr>
						<tr>
							<td>2</td>
							<td class="title_cell">세번째 행 제목이 길면 말줄임 처리됨</td>
							<td>데이터 3-2</td>
							<td>데이터 3-3</td>
							<td>데이터 3-4</td>
						</tr>
						<tr>
							<td>3</td>
							<td class="title_cell">네번째</td>
							<td>데이터 4-2</td>
							<td>데이터 4-3</td>
							<td>데이터 4-4</td>
						</tr>
						<tr>
							<td>4</td>
							<td class="title_cell">다섯번째</td>
							<td>데이터 5-2</td>
							<td>데이터 5-3</td>
							<td>데이터 5-4</td>
						</tr>
						<tr>
							<td>5</td>
							<td class="title_cell">다섯번째</td>
							<td>데이터 5-2</td>
							<td>데이터 5-3</td>
							<td>데이터 5-4</td>
						</tr>
					</tbody>
				</table>
			</div>
		</div>
	</article>
	<!-- 테이블 차트섹션 end -->
</section>
<section class="part2">
	<!-- <aside> -->
	<div>
		<canvas id="doughnutChart"></canvas>
	</div>
	<div>
		<canvas id="pieChart"></canvas>
	</div>
	<div>
		<canvas id="radarChart"></canvas>
	</div>
	<!-- </aside> -->
</section>
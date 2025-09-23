<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags"%>

<!-- ========== 내용(결제내역) ========== -->
<div id="payment" class="tab_content" style="display: none">
	<div class="search_box">
		<form class="search_form">
			<div class="search_container">
				<div class="filter">
					<div class="period_box">
						<div class="filtering_title">
							<span class="searchbox_title">결제일 : </span>
						</div>
						<div class="period_body">
							<div>
								<input type="date" class="btn start_date" /> <span> - </span> <input
									type="date" class="btn end_date" />
							</div>

							<div class="p_choice">
								<input type="button" class="btn" value="오늘" /> <input
									type="button" class="btn" value="어제" /> <input type="button"
									class="btn" value="최근7일" /> <input type="button" class="btn"
									value="최근30일" />
							</div>
						</div>
					</div>

					<div class="period_box">
						<div class="filtering_title">
							<span class="searchbox_title">사용기간 : </span>
						</div>
						<div class="period_body">
							<div>
								<input type="date" class="btn start_date" /> <span> - </span> <input
									type="date" class="btn end_date" />
							</div>

							<div class="p_choice">
								<input type="button" class="btn" value="오늘" /> <input
									type="button" class="btn" value="어제" /> <input type="button"
									class="btn" value="최근7일" /> <input type="button" class="btn"
									value="최근30일" />
							</div>
						</div>
					</div>

					<div class="answer_box">
						<div class="filtering_title">
							<span class="searchbox_title">구매유형 : </span>
						</div>
						<div class="answer_body">
							<div class="choice ch">
								<input type="button" value="전체" />
							</div>
							<div class="choice ch">
								<input type="button" value="멤버십" />
							</div>
							<div class="choice">
								<input type="button" value="배너구매" />
							</div>
						</div>
					</div>
				</div>

				<div class="btn_box">
					<input type="submit" class="btn first_btn" value="검색" /> <input
						type="reset" class="btn second_btn" value="초기화" />
				</div>
			</div>
		</form>
	</div>
	<!-- 검색박스 end -->
	<!-- 결제내역 테이블 -->
	<div class="whole_table">
		<div class="table_title">
			<span class="list_count">[ 검색 결과 ]&nbsp; 총 100건 중 1 - 10 건 </span>
		</div>
		<div class="table_wrap">
			<table>
				<colgroup>
					<col width="5%" />
					<!-- 번호 -->
					<col width="15%" />
					<!-- 결제일 -->
					<col width="10%" />
					<!-- code -->
					<col width="20%" />
					<!-- 구매내역 -->
					<col width="10%" />
					<!-- 결제금액 -->
					<col width="15%" />
					<!-- 사용여부 -->
					<col width="20%" />
					<!-- 사용기간 -->
					<col width="7%" />
					<!-- 상세보기 -->
				</colgroup>
				<thead>
					<tr>
						<th>#</th>
						<th>결제일</th>
						<th>code</th>
						<th>구매내역</th>
						<th>결제금액</th>
						<th>사용여부</th>
						<th>사용기간</th>
						<th>상세보기</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td>10</td>
						<td>2025-09-01</td>
						<td>P202509-02586</td>
						<td>멤버십 3개월</td>
						<td class="price_cell">500,000</td>
						<td>Y</td>
						<td>2025-09-01 ~ 2025-11-30</td>
						<td><i class="bi bi-three-dots-vertical"></i></td>
					</tr>
					<tr>
						<td>9</td>
						<td>2025-08-23</td>
						<td>P202508-02586</td>
						<td>배너구매</td>
						<td class="price_cell">400,000</td>
						<td>N</td>
						<td>-</td>
						<td><i class="bi bi-three-dots-vertical"></i></td>
					</tr>
					<tr>
						<td>8</td>
						<td>2025-08-01</td>
						<td>P202508-02014</td>
						<td>배너구매</td>
						<td class="price_cell">400,000</td>
						<td>Y</td>
						<td>-</td>
						<td><i class="bi bi-three-dots-vertical"></i></td>
					</tr>
					<tr>
						<td>7</td>
						<td>다섯번째</td>
						<td>데이터 5-2</td>
						<td>데이터 5-3</td>
						<td class="price_cell">데이터 5-4</td>
						<td>데이터 2-3</td>
						<td>데이터 2-4</td>
						<td>데이터 2-4</td>
					</tr>
					<tr>
						<td>6</td>
						<td>다섯번째</td>
						<td>데이터 5-2</td>
						<td>데이터 5-3</td>
						<td class="price_cell">데이터 5-4</td>
						<td>데이터 2-4</td>
						<td>데이터 2-4</td>
						<td>데이터 2-4</td>
					</tr>
					<tr>
						<td>5</td>
						<td>두번째 행 제목 (짧음)</td>
						<td>데이터 2-2</td>
						<td>데이터 2-3</td>
						<td class="price_cell">데이터 2-4</td>
						<td>데이터 2-4</td>
						<td>데이터 2-4</td>
						<td>데이터 2-4</td>
					</tr>
					<tr>
						<td>4</td>
						<td>ss</td>
						<td>데이터 3-2</td>
						<td>데이터 3-3</td>
						<td class="price_cell">데이터 3-4</td>
						<td>데이터 2-3</td>
						<td>데이터 2-4</td>
						<td>데이터 2-4</td>
					</tr>
					<tr>
						<td>3</td>
						<td>네번째</td>
						<td>데이터 4-2</td>
						<td>데이터 4-3</td>
						<td class="price_cell">데이터 4-4</td>
						<td>데이터 2-3</td>
						<td>데이터 2-4</td>
						<td>데이터 2-4</td>
					</tr>
					<tr>
						<td>2</td>
						<td>다섯번째</td>
						<td>데이터 5-2</td>
						<td>데이터 5-3</td>
						<td class="price_cell">데이터 5-4</td>
						<td>데이터 2-3</td>
						<td>데이터 2-4</td>
						<td>데이터 2-4</td>
					</tr>
					<tr>
						<td>1</td>
						<td>다섯번째</td>
						<td>데이터 5-2</td>
						<td>데이터 5-3</td>
						<td class="price_cell">데이터 5-4</td>
						<td>데이터 2-3</td>
						<td>데이터 2-4</td>
						<td>데이터 2-4</td>
					</tr>
				</tbody>
			</table>
		</div>

		<!-- 페이지네이션 -->
		<div class="pagination_wrap" id="paginationWrap">
			<my:adminPagination currentPage="1" totalPages="10" baseUrl="/products?page=" />
		</div>
		<!-- 페이지네이션 end -->
	</div>
</div>
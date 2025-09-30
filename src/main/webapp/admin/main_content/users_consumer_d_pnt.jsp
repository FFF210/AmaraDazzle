<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags"%>


<!-- ========== 내용(포인트) ========== -->
<div id="point" class="tab_content" style="display: none">
	<!-- 검색박스 -->
	<div class="search_box">
		<form class="search_form">
			<div class="search_container">
				<div class="filter">
					<div class="period_box">
						<div class="filtering_title">
							<span class="searchbox_title">날짜 : </span>
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
							<span class="searchbox_title">사용내역 : </span>
						</div>
						<div class="answer_body">
							<div class="choice ch">
								<input type="button" value="전체" />
							</div>
							<div class="choice ch">
								<input type="button" value="사용" />
							</div>
							<div class="choice">
								<input type="button" value="적립" />
							</div>
						</div>
					</div>

					<div class="totalSearch_box">
						<div class="searchType">
							<select>
								<option>내용</option>
								<option>주문번호</option>
							</select>
						</div>
						<div class="searchKeyword">
							<i class="bi bi-search"></i><input type="text" />
						</div>
					</div>
				</div>

				<div class="btn_box">
					<input type="submit" class="btn searchBtn" value="검색" /> <input
						type="reset" class="btn resetBtn" value="초기화" />
				</div>
			</div>
		</form>
	</div>
	<!-- 검색박스 end -->
	<!-- 포인트 테이블 -->
	<div class="whole_table">
		<div class="table_title">
			<span>[ 검색 결과 ]&nbsp; 총 100건 중 1 - 10 건 </span>
		</div>
		<div class="table_wrap">
			<table>
				<colgroup>
					<col style="width: 5%" />
					<!-- 번호 -->
					<col style="width: 10%" />
					<!-- code -->
					<col style="width: 15%" />
					<!-- 날짜 -->
					<col style="width: 15%" />
					<!-- 포인트내역 -->
					<col style="width: 10%" />
					<!-- 금액 -->
					<col style="width: 10%" />
					<!-- 사용내역 -->
					<col style="width: 20%" />
					<!-- 주문번호 -->
					<col style="width: 10%" />
					<!-- 상세보기 -->
				</colgroup>
				<thead>
					<tr>
						<th>#</th>
						<th>code</th>
						<th>날짜</th>
						<th>포인트내역</th>
						<th>금액</th>
						<th>사용내역</th>
						<th>주문번호</th>
						<th>상세보기</th>
					</tr>
				</thead>
				<tbody>
					<tr data-group="1" data-main="true">
						<td>10</td>
						<td>P123456</td>
						<td>2025-09-02 11:12:13</td>
						<td>상품 구매 적립</td>
						<td class="price_cell">2,000</td>
						<td>적립</td>
						<td>20250902-0145874</td>
						<td class="detail_cell"><i class="bi bi-three-dots-vertical"></i></td>
					</tr>
					<tr data-group="1" data-main="true">
						<td>10</td>
						<td>P123456</td>
						<td>2025-09-02 11:12:13</td>
						<td>상품 구매 사용</td>
						<td class="price_cell">1,000</td>
						<td>사용</td>
						<td>20250902-014485</td>
						<td class="detail_cell"><i class="bi bi-three-dots-vertical"></i></td>
					</tr>
					<tr data-group="1" data-main="true">
						<td>10</td>
						<td>P123456</td>
						<td>2025-09-02 11:12:13</td>
						<td>리뷰 적립</td>
						<td class="price_cell">2,000</td>
						<td>적립</td>
						<td>20250902-014485</td>
						<td class="detail_cell"><i class="bi bi-three-dots-vertical"></i></td>
					</tr>
				</tbody>
			</table>
		</div>

		<!-- 페이지네이션 -->
		<div class="pagination_wrap" id="paginationWrap">
<%-- 			<my:adminPagination currentPage="1" totalPages="10" baseUrl="/products?page=" /> --%>
		</div>
		<!-- 페이지네이션 end -->
	</div>
</div>
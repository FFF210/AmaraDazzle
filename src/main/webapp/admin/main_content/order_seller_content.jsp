<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags"%>

<!-- 메인부분 -->
<!-- 탭 -->
<div class="tabs">
	<div class="tab" onclick="">주문건별</div>
	<div class="tab active" onclick="showTab('order_seller')">판매자별</div>
</div>

<!-- ************************* 판매자별 탭 ************************* -->
<div id="order_seller" class="tab_content">
	<!-- 필터 -->
	<form class="search_form">
		<div class="search_container">
			<div class="filter">
				<div class="period_box">
					<div class="filtering_title">
						<span class="searchbox_title">가입일 : </span>
					</div>
					<div class="period_body">
						<div>
							<input type="month" class="btn start_date" /> <span> - </span> <input
								type="month" class="btn end_date" />
						</div>

						<div class="p_choice">
							<input type="button" class="btn" value="이번달" /> <input
								type="button" class="btn" value="지난달" /> <input type="button"
								class="btn" value="최근1년" />
						</div>
					</div>
				</div>

				<div class="totalSearch_box">
					<div class="searchType">
						<select>
							<option>브랜드명</option>
							<option>code</option>
						</select>
					</div>
					<div class="searchKeyword">
						<i class="bi bi-search"></i><input type="text" />
					</div>
				</div>
			</div>

			<div class="btn_box">
				<input type="submit" class="btn first_btn" value="검색" /> <input
					type="reset" class="btn second_btn" value="초기화" />
			</div>
		</div>
	</form>

	<!-- 테이블 -->
	<div class="whole_table">
		<div class="table_title">
			<span class="list_count">[ 검색 결과 ]&nbsp; 총 100건 중 1 - 10 건 </span>
		</div>
		<div class="table_wrap">
			<table>
				<colgroup>
					<col style="width: 10%" />
					<!-- 번호 -->
					<col style="width: 5%" />
					<!-- Image -->
					<col style="width: 15%" />
					<!-- 브랜드명 -->
					<col style="width: 15%" />
					<!-- code -->
					<col style="width: 15%" />
					<!-- 가입일 -->
					<col style="width: 10%" />
					<!-- 당월매출액 -->
					<col style="width: 10%" />
					<!-- 누적매출액 -->
					<col style="width: 10%" />
					<!-- 상세보기 -->
				</colgroup>
				<thead>
					<tr>
						<th>#</th>
						<th>Img</th>
						<th>브랜드명</th>
						<th>code</th>
						<th>가입일</th>
						<th>당월매출액</th>
						<th>누적매출액</th>
						<th>상세보기</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td>112525</td>
						<td class="img_cell"><img src="./image/no-image.svg"
							style="height: 40px" /></td>
						<td>아비브</td>
						<td>S1002582</td>
						<td>2025-12-31</td>
						<td class="price_cell">16,800,000</td>
						<td class="price_cell">16,800,000,000</td>
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
<!-- 메인부분 -->
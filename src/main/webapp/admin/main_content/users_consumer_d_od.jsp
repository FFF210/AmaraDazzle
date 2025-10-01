<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags"%>

<!-- ========== 내용(주문내역) ========== -->
<div id="order" class="tab_content">
	<div class="search_box">
		<form class="search_form">
			<div class="search_container">
				<div class="filter">
					<div class="period_box">
						<div class="filtering_title">
							<span class="searchbox_title">주문일 : </span>
						</div>
						<div class="period_body">
							<div>
								<input type="date" class="btn start_date" /> <span> - </span> <input
									type="date" class="btn end_date" />
							</div>

							<div class="p_choice">
								<input type="button" class="btn" value="오늘" /> <input
									type="button" class="btn" value="최근7일" /> <input type="button"
									class="btn" value="최근30일" />
							</div>
						</div>
					</div>

					<div class="answer_box">
						<div class="filtering_title">
							<span class="searchbox_title">주문상태 : </span>
						</div>
						<div class="answer_body">
							<div class="choice ch">
								<input type="button" value="전체" />
							</div>
							<div class="choice ch">
								<input type="button" value="결제완료" />
							</div>
							<div class="choice ch">
								<input type="button" value="상품준비중" />
							</div>
							<div class="choice ch">
								<input type="button" value="배송중" />
							</div>
							<div class="choice ch">
								<input type="button" value="배송완료" />
							</div>
							<div class="choice ch">
								<input type="button" value="취소" />
							</div>
							<div class="choice ch">
								<input type="button" value="교환" />
							</div>
							<div class="choice">
								<input type="button" value="반품" />
							</div>
						</div>
					</div>

					<div class="totalSearch_box">
						<div class="searchType">
							<select>
								<option>주문번호</option>
								<option>상품명</option>
								<option>브랜드명</option>
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
	</div>
	<!-- 검색박스 end -->
	<!-- 주문내역 테이블 -->
	<div class="whole_table">
		<div class="table_title">
			<span class="list_count">[ 검색 결과 ]&nbsp; 총 100건 중 1 - 10 건 </span>
		</div>
		<div class="table_wrap">
			<table>
				<colgroup>
					<col style="width: 5%" />
					<!--번호-->
					<col style="width: 15%" />
					<!-- 주문번호 -->
					<col style="width: 25%" />
					<!--상품명-->
					<col style="width: 10%" />
					<!--최종결제금액-->
					<col style="width: 12%" />
					<!--브랜드명-->
					<col style="width: 12%" />
					<!--주문일자-->
					<col style="width: 10%" />
					<!--주문상태-->
					<col style="width: 8%" />
					<!--상세보기-->
				</colgroup>
				<thead>
					<tr>
						<th>#</th>
						<th>주문번호</th>
						<th>상품명</th>
						<th>최종결제금액</th>
						<th>브랜드명</th>
						<th>주문일자</th>
						<th>주문상태</th>
						<th>상세보기</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td>10</td>
						<td>20250825-001478</td>
						<td class="title_cell">[수분진정] 아비브 어성초 카... 외 3건</td>
						<td class="price_cell">25.300</td>
						<td>아비브</td>
						<td>2025-08-25 11:20:50</td>
						<td>[배송중]</td>
						<td class="detail_cell"><i class="bi bi-three-dots-vertical"></i></td>
					</tr>
					<tr>
						<td>9</td>
						<td>20250825-001478</td>
						<td class="title_cell">[수분진정] 아비브 어성초 카... 외 3건</td>
						<td class="price_cell">25.300</td>
						<td>아비브</td>
						<td>2025-08-25 11:20:50</td>
						<td>[배송중]</td>
						<td><i class="bi bi-three-dots-vertical"></i></td>
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
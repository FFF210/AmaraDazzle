<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags"%>


<!-- 메인부분 -->
<!-- 탭 -->
<div class="tabs">
	<div class="tab active" onclick="showTab('order_order')">주문건별</div>
	<div class="tab" onclick="">판매자별</div>
</div>

<!-- ************************* 주문건별 탭 ************************* -->
<div id="order_order" class="tab_content">
	<!-- 필터 -->
	<form class="search_form">
		<div class="search_container">
			<div class="filter">
				<div class="period_box">
					<div class="filtering_title">
						<span class="searchbox_title">주문일자 : </span>
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
						<span class="searchbox_title">답변상태 : </span>
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
						<div class="choice ch">
							<input type="button" value="반품" />
						</div>
						<div class="choice">
							<input type="button" value="구매확정" />
						</div>
					</div>
				</div>

				<div class="totalSearch_box">
					<div class="searchType">
						<select>
							<option>주문번호</option>
							<option>회원아이디</option>
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
					<col style="width: 15%" />
					<!-- 주문번호 -->
					<col style="width: 17%" />
					<!-- 구매자아이디 -->
					<col style="width: 10%" />
					<!-- 최종결제금액 -->
					<col style="width: 15%" />
					<!-- 브랜드명 -->
					<col style="width: 15%" />
					<!-- 주문일자 -->
					<col style="width: 10%" />
					<!-- 주문상태 -->
					<col style="width: 8%" />
					<!-- 상세보기-->
				</colgroup>
				<thead>
					<tr>
						<th>#</th>
						<th>주문번호</th>
						<th>구매자아이디</th>
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
						<td>20250909-258963</td>
						<td>abc123@naver.com</td>
						<td class="price_cell">123,400</td>
						<td>qmfosemaud</td>
						<td>2025-09-19 12:33:45</td>
						<td>[배송중]</td>
						<td class="detail_cell"><i class="bi bi-three-dots-vertical"></i></td>
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
<!-- 메인부분 -->
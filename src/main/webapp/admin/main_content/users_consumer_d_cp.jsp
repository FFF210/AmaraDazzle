<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags"%>

<!-- ========== 내용(쿠폰) ========== -->
<div id="coupon" class="tab_content" style="display: none">
	<div class="search_box">
		<form class="search_form">
			<div class="search_container">
				<div class="filter">
					<div class="period_box">
						<div class="filtering_title">
							<span class="searchbox_title">발행일자 : </span>
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
							<span class="searchbox_title">유효기간 : </span>
						</div>
						<div class="period_body">
							<div>
								<input type="date" class="btn start_date" /> <span> - </span> <input
									type="date" class="btn end_date" />
							</div>
						</div>
					</div>

					<div class="answer_box">
						<div class="filtering_title">
							<span class="searchbox_title">사용여부 : </span>
						</div>
						<div class="answer_body">
							<div class="choice ch">
								<input type="button" value="전체" />
							</div>
							<div class="choice ch">
								<input type="button" value="미사용" />
							</div>
							<div class="choice">
								<input type="button" value="사용" />
							</div>
						</div>
					</div>

					<div class="answer_box">
						<div class="filtering_title">
							<span class="searchbox_title">사용여부 : </span>
						</div>
						<div class="answer_body">
							<div class="choice ch">
								<input type="button" value="전체" />
							</div>
							<div class="choice ch">
								<input type="button" value="미사용" />
							</div>
							<div class="choice">
								<input type="button" value="사용" />
							</div>
						</div>
					</div>

					<div class="totalSearch_box">
						<div class="searchType">
							<select>
								<option>쿠폰명</option>
								<option>쿠폰코드</option>
								<option>회원아이디</option>
								<option>회원명</option>
								<option>조건</option>
								<option>주문번호</option>
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
	<!-- 쿠폰 테이블 -->
	<div class="whole_table">
		<div class="table_title">
			<span>[ 검색 결과 ]&nbsp; 총 100건 중 1 - 10 건 </span>
		</div>
		<div class="table_wrap">
			<table>
				<colgroup>
					<col style="width: 5%" />
					<!--번호-->
					<col style="width: 13%" />
					<!-- 쿠폰코드 -->
					<col style="width: 15%" />
					<!--쿠폰명-->
					<col style="width: 8%" />
					<!--발행일자-->
					<col style="width: 15%" />
					<!--유효기간-->
					<col style="width: 8%" />
					<!--할인액-->
					<col style="width: 10%" />
					<!--조건-->
					<col style="width: 7%" />
					<!--사용여부-->
					<col style="width: 7%" />
					<!--쿠폰상태-->
					<col style="width: 11%" />
					<!--주문번호-->
					<col style="width: 6%" />
					<!--상세보기-->
				</colgroup>
				<thead>
					<tr>
						<th>#</th>
						<th>쿠폰코드</th>
						<th>쿠폰명</th>
						<th>발행일자</th>
						<th>유효기간</th>
						<th>할인액</th>
						<th>조건</th>
						<th>사용여부</th>
						<th>쿠폰상태</th>
						<th>주문번호</th>
						<th>상세보기</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td>10</td>
						<td>lINzCaiPwuLDIGPcdNdB</td>
						<td>리쇼라 30만원 할일</td>
						<td>2025-09-07</td>
						<td>2025-09-07 ~ 2025-09-17</td>
						<td class="price_cell">3,000,000</td>
						<td>3만원 이상 구매시</td>
						<td>미사용</td>
						<td>사용가능</td>
						<td>20250907-12589</td>
						<td><i class="bi bi-three-dots-vertical"></i></td>
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
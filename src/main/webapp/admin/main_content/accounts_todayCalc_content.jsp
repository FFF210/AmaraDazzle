<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags"%>

<!-- 메인부분 -->
<!-- 탭 -->
<div class="tabs title_font">
	<div class="tab active" onclick="">오늘 정산할 건</div>
	<div class="tab" onclick="">정산 내역</div>
</div>

<!-- ************************* 오늘 정산할 건 탭 ************************* -->
<div id="todayCalc" class="tab_content">
	<section class="tab_content">
		<!-- 요약 -->
		<div class="summary">
			<table>
				<tr>
					<td><i class="bi bi-dot"></i><span>정산 기간 : </span> <span>
							2025-08-01 </span> ~ <span> 2025-08-31</span></td>
					<td colspan="2"><i class="bi bi-dot"></i><span>총 미정산 건수
							: </span> <span> 1,000</span> 건</td>
				</tr>
				<tr>
					<td><i class="bi bi-dot"></i><span>8월 총 매출 : </span> <span>
							1,000,000,000</span> 원</td>
					<td><i class="bi bi-dot"></i><span>총 수수료 : </span><span>
							70,000,000</span> 원</td>
					<td>&nbsp;&nbsp;<i class="bi bi-dot"></i><span>총 정산 금액
							: </span><span> 930,000,000</span> 원
					</td>
				</tr>
			</table>
		</div>

		<!-- 필터 -->
		<form class="search_form">
			<div class="search_container">
				<div class="filter">
					<div class="answer_box">
						<div class="filtering_title">
							<span class="searchbox_title">정산상태 : </span>
						</div>
						<div class="answer_body">
							<div class="choice ch">
								<input type="button" value="전체" />
							</div>
							<div class="choice ch">
								<input type="button" value="완료" />
							</div>
							<div class="choice ch">
								<input type="button" value="진행중" />
							</div>
							<div class="choice ch">
								<input type="button" value="대기중" />
							</div>
							<div class="choice">
								<input type="button" value="오류발생" />
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

		<div class="button_wrap">
			<button type="button" class="btn second_btn action_btn">일괄정산</button>
		</div>

		<!-- 테이블 -->
		<div class="whole_table">
			<div class="table_title">
				<span>[ 검색 결과 ]&nbsp; 총 100건 중 1 - 10 건 </span>
			</div>
			<div class="table_wrap">
				<table>
					<colgroup>
						<col style="width: 5%" />
						<!-- 체크박스 -->
						<col style="width: 5%" />
						<!-- 번호 -->
						<col style="width: 5%" />
						<!-- IMG -->
						<col style="width: 13%" />
						<!-- 브랜드명 -->
						<col style="width: 8%" />
						<!-- 상점코드 -->
						<col style="width: 12%" />
						<!-- 당월 총 매출액 -->
						<col style="width: 12%" />
						<!-- 순이익 -->
						<col style="width: 12%" />
						<!-- 수수료 -->
						<col style="width: 12%" />
						<!-- 정산금액 -->
						<col style="width: 8%" />
						<!-- 정산상태 -->
						<col style="width: 8%" />
						<!-- 상세보기 -->
					</colgroup>
					<thead>
						<tr>
							<th><input type="checkbox" /></th>
							<th>#</th>
							<th>IMG</th>
							<th>브랜드명</th>
							<th>상점코드</th>
							<th>당월 총 매출액</th>
							<th>순 이익</th>
							<th>수수료</th>
							<th>정산 금액</th>
							<th>정산 상태</th>
							<th>상세보기</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td><input type="checkbox" /></td>
							<td>10</td>
							<td>아비브</td>
							<td>아비브</td>
							<td>S123456</td>
							<td class="price_cell">122,345,600</td>
							<td class="price_cell">122,345,600</td>
							<td class="price_cell">122,345,600</td>
							<td class="price_cell">122,345,600</td>
							<td>[정산상태]</td>
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
	</section>
</div>
<!-- 메인부분 -->
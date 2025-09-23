<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>


<!-- 메인부분 -->
<!-- 탭 -->
<div class="tabs">
	<div class="tab active" onclick="">발행 쿠폰 목록</div>
	<div class="tab" onclick="">개별 지급 목록</div>
</div>

<!-- ************************* 발행 쿠폰 목록 탭 ************************* -->
<div id="" class="tab_content">
	<!-- 필터 -->
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

						<div class="p_choice">
							<input type="button" class="btn" value="오늘" /> <input
								type="button" class="btn" value="어제" /> <input type="button"
								class="btn" value="최근7일" /> <input type="button" class="btn"
								value="최근30일" />
						</div>
					</div>
				</div>

				<div class="totalSearch_box">
					<div class="searchType">
						<select>
							<option>쿠폰명</option>
							<option>쿠폰코드</option>
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
			<!-- 버튼 -->
			<div>
				<button type="button" class="btn first_btn action_btn">쿠폰발행</button>
				<button type="button" class="btn second_btn action_btn">노출중지</button>
			</div>
			<!-- 버튼 end -->
		</div>
		<div class="table_wrap">
			<table>
				<colgroup>
					<col style="width: 4%" />
					<!-- 체크박스 -->
					<col style="width: 5%" />
					<!-- 번호 -->
					<col style="width: 15%" />
					<!-- 쿠폰코드 -->
					<col style="width: 15%" />
					<!-- 쿠폰명 -->
					<col style="width: 8%" />
					<!-- 금액 -->
					<col style="width: 10%" />
					<!-- 지급일 -->
					<col style="width: 15%" />
					<!-- 유효기간 -->
					<col style="width: 7%" />
					<!-- 잔여량 -->
					<col style="width: 7%" />
					<!-- 발행수량 -->
					<col style="width: 7%" />
					<!-- 노출여부 -->
					<col style="width: 7%" />
					<!-- 상세보기 -->
				</colgroup>
				<thead>
					<tr>
						<th><input type="checkbox" /></th>
						<th>#</th>
						<th>쿠폰코드</th>
						<th>쿠폰명</th>
						<th>할인금액</th>
						<th>발행일</th>
						<th>유효기간</th>
						<th>잔여량</th>
						<th>발행수량</th>
						<th>노출여부</th>
						<th>상세보기</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td><input type="checkbox" /></td>
						<td>10</td>
						<td>lINzCaiPwuLDIGPcdNdB</td>
						<td>리쇼라 30만원 할일</td>
						<td class="price_cell">300,000</td>
						<td>2025-09-01 11:12:11</td>
						<td>지급일로부터 10일</td>
						<td>10</td>
						<td>500</td>
						<td>[게시중]</td>
						<td class="detail_cell"><i class="bi bi-three-dots-vertical"></i></td>
					</tr>
				</tbody>
			</table>
		</div>

		<!-- 페이지네이션 -->
		<div class="pagination_wrap" id="paginationWrap">
			<!-- Prev button -->
			<button class="pg_nav" id="btnPrev">
				<i class="bi bi-chevron-left"></i>&nbsp;Prev&nbsp;
			</button>

			<!-- Pages container -->
			<div class="pages" id="pages">
				<button type="button" class="page_item active">1</button>
				<button type="button" class="page_item">2</button>
				<button type="button" class="page_item">12</button>
				<button type="button" class="page_item">13</button>
				<button type="button" class="page_item">111</button>
				<button type="button" class="page_item">158</button>
				<button type="button" class="page_item">1589</button>
			</div>

			<!-- Next button -->
			<button class="pg_nav" id="btnNext">
				&nbsp;Next&nbsp;<i class="bi bi-chevron-right"></i>
			</button>
		</div>
		<!-- 페이지네이션 end -->
	</div>
</div>
<!-- 메인부분 -->
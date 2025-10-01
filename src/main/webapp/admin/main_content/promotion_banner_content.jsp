<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags"%>


<!-- 메인부분 -->
<!-- 필터 -->
<form class="search_form">
	<div class="search_container">
		<div class="filter">
			<div class="period_box">
				<div class="filtering_title">
					<span class="searchbox_title">등록일 : </span>
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
					<span class="searchbox_title">전시 기간 : </span>
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
					<span class="searchbox_title">노출상태 : </span>
				</div>
				<div class="answer_body">
					<div class="choice ch">
						<input type="button" value="전체" />
					</div>
					<div class="choice ch">
						<input type="button" value="미노출" />
					</div>
					<div class="choice">
						<input type="button" value="게시중" />
					</div>
				</div>
			</div>

			<div class="totalSearch_box">
				<div class="searchType">
					<select>
						<option>브랜드명</option>
						<option>제목</option>
						<option>code</option>
						<option>검색유형</option>
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

<!-- 버튼 -->
<div class="button_wrap">
	<div>
		<button type="button" class="btn second_btn action_btn">글쓰기</button>
	</div>
	<div>
		<button type="button" class="btn first_btn action_btn">게시</button>
	</div>
</div>
<!-- 버튼 end -->
<!-- 테이블 -->
<div class="whole_table">
	<div class="table_title">
		<span class="list_count">[ 검색 결과 ]&nbsp; 총 100건 중 1 - 10 건 </span>
	</div>
	<div class="table_wrap">
		<table>
			<colgroup>
				<col style="width: 4%" />
				<!-- 체크박스 -->
				<col style="width: 5%" />
				<!-- 번호 -->
				<col style="width: 5%" />
				<!-- 썸네일 -->
				<col style="width: 15%" />
				<!-- 제목 -->
				<col style="width: 10%" />
				<!-- 브랜드명 -->
				<col style="width: 15%" />
				<!-- 전시기간 -->
				<col style="width: 10%" />
				<!-- 결제금액 -->
				<col style="width: 10%" />
				<!-- 등록일 -->
				<col style="width: 8%" />
				<!-- 노출여부 -->
				<col style="width: 10%" />
				<!-- 게시일 -->
				<col style="width: 8%" />
				<!-- 상세보기 -->
			</colgroup>
			<thead>
				<tr>
					<th><input type="checkbox" /></th>
					<th>#</th>
					<th>IMG</th>
					<th>제목</th>
					<th>브랜드명</th>
					<th>전시기간</th>
					<th>결제금액</th>
					<th>등록일</th>
					<th>노출여부</th>
					<th>게시일</th>
					<th>상세보기</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td><input type="checkbox" /></td>
					<td>10</td>
					<td class="img_cell"><img src="./image/no-image.svg" /></td>
					<td class="title_cell">발라보고 올영에서 결-정하자</td>
					<td>클리오</td>
					<td>2025-09-01 ~ 2025-09-21</td>
					<td class="price_cell">1,234,500</td>
					<td>2025-09-01 11:12:11</td>
					<td>[게시중]</td>
					<td>2025-09-01 12:25:00</td>
					<td class="detail_cell"><i class="bi bi-three-dots-vertical"></i></td>
				</tr>
			</tbody>
		</table>
	</div>

	<!-- 페이지네이션 -->
	<div class="pagination_wrap" id="paginationWrap">
<%-- 		<my:adminPagination currentPage="1" totalPages="10" baseUrl="/products?page=" /> --%>
	</div>
	<!-- 페이지네이션 end -->
</div>
<!-- 메인부분 -->
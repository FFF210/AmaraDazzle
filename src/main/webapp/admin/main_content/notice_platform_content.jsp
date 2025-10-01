<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags"%>

<!-- 메인부분 -->
<!-- 탭 -->
<div class="tabs">
	<div class="tab" onclick="showTab('seller')">판매자 공지</div>
	<div class="tab active" onclick="showTab('platform')">플랫폼 공지</div>
</div>

<!-- ************************* 판매자 탭 ************************* -->
<div id="platform" class="tab_content">
	<!-- 필터 -->
	<form class="search_form">
		<div class="search_container">
			<div class="filter">
				<div class="period_box">
					<div class="filtering_title">
						<span class="searchbox_title">작성일 : </span>
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

				<div class="questionType_box">
					<div class="filtering_title">
						<span class="searchbox_title">카테고리 : </span>
					</div>
					<div>
						<select class="">
							<option>공지카테1</option>
							<option>공지카테2</option>
							<option>공지카테3</option>
							<option>공지카테4</option>
						</select>
					</div>
				</div>

				<div class="totalSearch_box">
					<div class="searchType">
						<select>
							<option>내용</option>
							<option>제목</option>
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
		<div>
			<button type="button" class="btn first_btn action_btn">글쓰기</button>
		</div>
		<div>
			<button type="button" class="btn second_btn action_btn">삭제</button>
		</div>
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
					<col style="width: 10%" />
					<!-- 카테고리 -->
					<col style="width: 4%" />
					<!-- 첨부 -->
					<col style="width: 33%" />
					<!-- 제목 -->
					<col style="width: 10%" />
					<!-- 작성자 -->
					<col style="width: 15%" />
					<!-- 작성일 -->
					<col style="width: 10%" />
					<!-- 노출여부 -->
					<col style="width: 8%" />
					<!-- 상세보기-->
				</colgroup>
				<thead>
					<tr>
						<th><input type="checkbox" /></th>
						<th>#</th>
						<th>카테고리</th>
						<th>첨부</th>
						<th>제목</th>
						<th>작성자</th>
						<th>작성일</th>
						<th>노출여부</th>
						<th>상세보기</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td><input type="checkbox" /></td>
						<td>10</td>
						<td>[공지카테]</td>
						<td><i class="bi bi-paperclip"></i></td>
						<td class="title_cell">공지 공지 공지 공지</td>
						<td>Amara Dazzle</td>
						<td>2025-09-19 12:33:45</td>
						<td>[게시중]</td>
						<td class="detail_cell reply_view"><i
							class="bi bi-three-dots-vertical"></i></td>
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
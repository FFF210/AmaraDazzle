<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>


<!-- 메인부분 -->
<div class="tabs">
	<div class="tab active" onclick="showTab('seller')">판매자 회원
		(1,000)</div>
	<div class="tab" onclick="showTab('consumer')">일반회원 회원 (1,000)</div>
</div>

<!-- ************************* 판매자 탭 ************************* -->
<div id="seller" class="tab_content">
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
						<span class="searchbox_title">승인상태 : </span>
					</div>
					<div class="answer_body">
						<div class="choice ch">
							<input type="button" value="전체" />
						</div>
						<div class="choice ch">
							<input type="button" value="승인" />
						</div>
						<div class="choice ch">
							<input type="button" value="미승인" />
						</div>
						<div class="choice">
							<input type="button" value="승인거부" />
						</div>
					</div>
				</div>

				<div class="totalSearch_box">
					<div class="searchType">
						<select>
							<option>브랜드명</option>
							<option>code</option>
							<option>담당자명</option>
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

	<!-- 사업자회원 테이블 -->
	<div class="whole_table">
		<div class="table_title">
			<span>[ 검색 결과 ]&nbsp; 총 100건 중 1 - 10 건 </span>
		</div>
		<div class="table_wrap">
			<table>
				<colgroup>
					<col width="5%" />
					<col width="10%" />
					<col width="10%" />
					<col width="25%" />
					<col width="10%" />
					<col width="16%" />
					<col width="8%" />
					<col width="8%" />
					<col width="8%" />
				</colgroup>
				<thead>
					<tr>
						<th>#</th>
						<th>code</th>
						<th>Image</th>
						<th>브랜드명</th>
						<th>담당자명</th>
						<th>가입일</th>
						<th>구독여부</th>
						<th>승인여부</th>
						<th>상세보기</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td>10</td>
						<td>S124567</td>
						<td>데이터 2-2</td>
						<td class="title_cell">데이터 2-3</td>
						<td>데이터 2-4</td>
						<td>데이터 2-3</td>
						<td>데이터 2-4</td>
						<td>데이터 2-4</td>
						<td><i class="bi bi-three-dots-vertical"></i></td>
					</tr>
					<tr>
						<td>9</td>
						<td>S124567</td>
						<td>데이터 3-2</td>
						<td class="title_cell">데이터 3-3</td>
						<td>데이터 3-4</td>
						<td>데이터 2-3</td>
						<td>데이터 2-4</td>
						<td>데이터 2-4</td>
						<td><i class="bi bi-three-dots-vertical"></i></td>
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
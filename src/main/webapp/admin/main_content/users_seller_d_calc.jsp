<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags"%>

<!-- ========== 내용(정산내역) ========== -->
<div id="calculate" class="tab_content">
	<div class="search_box">
		<form class="search_form">
			<div class="search_container">
				<div class="filter">
					<div class="period_box">
						<div class="filtering_title">
							<span class="searchbox_title">정산기간 : </span>
						</div>
						<div class="period_body">
							<div>
								<input type="month" class="btn start_date" /> <span> - </span>
								<input type="month" class="btn end_date" />
							</div>

							<div class="p_choice">
								<input type="button" class="btn" value="이번달" /> <input
									type="button" class="btn" value="지난달" /> <input type="button"
									class="btn" value="최근1년" />
							</div>
						</div>
					</div>

					<div class="answer_box">
						<div class="filtering_title">
							<span class="searchbox_title">정산 진행상태 : </span>
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
								<option>검색유형</option>
								<option>검색유형</option>
								<option>검색유형</option>
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
	</div>
	<!-- 검색박스 end -->
	<div>
		<!-- 정산 테이블 -->
		<div class="whole_table">
			<div class="table_title">
				<span class="list_count">[ 검색 결과 ]&nbsp; 총 100건 중 1 - 10 건 </span>
			</div>
			<div class="table_wrap">
				<table>
					<colgroup>
						<col width="5%" />
						<col width="10%" />
						<col width="10%" />
						<col width="10%" />
						<col width="10%" />
						<col width="10%" />
						<col width="10%" />
						<col width="15%" />
						<col width="8%" />
					</colgroup>
					<thead>
						<tr>
							<th>#</th>
							<th>정산월</th>
							<th>code</th>
							<th>총매출액</th>
							<th>순수매출액</th>
							<th>정산금액</th>
							<th>진행상태</th>
							<th>입금완료일</th>
							<th>상세보기</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td>10</td>
							<td>2025-08</td>
							<td>C202508-02586</td>
							<td class="price_cell">10,000,000,000</td>
							<td class="price_cell">10,000,000,000</td>
							<td class="price_cell">10,000,000,000</td>
							<td>[completed]</td>
							<td>2025-09-10 12:25:30</td>
							<td><i class="bi bi-three-dots-vertical"></i></td>
						</tr>
						<tr>
							<td>9</td>
							<td>2025-08</td>
							<td>C202508-02586</td>
							<td class="price_cell">10,000,000,000</td>
							<td class="price_cell">10,000,000,000</td>
							<td class="price_cell">10,000,000,000</td>
							<td>[in progress]</td>
							<td>-</td>
							<td><i class="bi bi-three-dots-vertical"></i></td>
						</tr>
						<tr>
							<td>8</td>
							<td>2025-08</td>
							<td>C202508-02586</td>
							<td class="price_cell">10,000,000,000</td>
							<td class="price_cell">10,000,000,000</td>
							<td class="price_cell">10,000,000,000</td>
							<td>[waiting]</td>
							<td>-</td>
							<td><i class="bi bi-three-dots-vertical"></i></td>
						</tr>
						<tr>
							<td>7</td>
							<td>2025-08</td>
							<td>C202508-02586</td>
							<td class="price_cell">10,000,000,000</td>
							<td class="price_cell">10,000,000,000</td>
							<td class="price_cell">10,000,000,000</td>
							<td>[error]</td>
							<td>-</td>
							<td><i class="bi bi-three-dots-vertical"></i></td>
						</tr>
						<tr>
							<td>6</td>
							<td>2025-08</td>
							<td>C202508-02586</td>
							<td class="price_cell">10,000,000,000</td>
							<td class="price_cell">10,000,000,000</td>
							<td class="price_cell">10,000,000,000</td>
							<td>[completed]</td>
							<td>2025-09-10 12:25:30</td>
							<td><i class="bi bi-three-dots-vertical"></i></td>
						</tr>
						<tr>
							<td>5</td>
							<td>2025-08</td>
							<td>C202508-02586</td>
							<td class="price_cell">10,000,000,000</td>
							<td class="price_cell">10,000,000,000</td>
							<td class="price_cell">10,000,000,000</td>
							<td>[completed]</td>
							<td>2025-09-10 12:25:30</td>
							<td><i class="bi bi-three-dots-vertical"></i></td>
						</tr>
						<tr>
							<td>4</td>
							<td>2025-08</td>
							<td>C202508-02586</td>
							<td class="price_cell">10,000,000,000</td>
							<td class="price_cell">10,000,000,000</td>
							<td class="price_cell">10,000,000,000</td>
							<td>[completed]</td>
							<td>2025-09-10 12:25:30</td>
							<td><i class="bi bi-three-dots-vertical"></i></td>
						</tr>
						<tr>
							<td>3</td>
							<td>2025-08</td>
							<td>C202508-02586</td>
							<td class="price_cell">10,000,000,000</td>
							<td class="price_cell">10,000,000,000</td>
							<td class="price_cell">10,000,000,000</td>
							<td>[completed]</td>
							<td>2025-09-10 12:25:30</td>
							<td><i class="bi bi-three-dots-vertical"></i></td>
						</tr>
						<tr>
							<td>2</td>
							<td>2025-08</td>
							<td>C202508-02586</td>
							<td class="price_cell">10,000,000,000</td>
							<td class="price_cell">10,000,000,000</td>
							<td class="price_cell">10,000,000,000</td>
							<td>[completed]</td>
							<td>2025-09-10 12:25:30</td>
							<td><i class="bi bi-three-dots-vertical"></i></td>
						</tr>
						<tr>
							<td>1</td>
							<td>2025-08</td>
							<td>C202508-02586</td>
							<td class="price_cell">10,000,000,000</td>
							<td class="price_cell">10,000,000,000</td>
							<td class="price_cell">10,000,000,000</td>
							<td>[completed]</td>
							<td>2025-09-10 12:25:30</td>
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
</div>
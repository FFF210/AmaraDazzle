<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags"%>

<!-- 메인부분 -->
<!-- 탭 -->
<div class="tabs">
	<div class="tab" onclick="">판매자 회원 (1,000)</div>
	<div class="tab active" onclick="">일반회원 회원 (1,000)</div>
</div>

<!-- ************************* 일반회원 탭 ************************* -->
<div id="consumer" class="tab_content">
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
						<span class="searchbox_title">등급 : </span>
					</div>
					<div class="answer_body">
						<div class="choice ch">
							<input type="button" value="전체" />
						</div>
						<div class="choice ch" style="text-align: center">
							<input type="button" value="VIP" />
							<!-- style="display: inline-block; line-height: 1.5" -->
						</div>
						<div class="choice ch">
							<input type="button" value="GOLD" />
						</div>
						<div class="choice ch">
							<input type="button" value="SILVER" />
						</div>
						<div class="choice">
							<input type="button" value="일반" />
						</div>
					</div>
				</div>

				<div class="totalSearch_box">
					<div class="searchType">
						<select>
							<option>아이디</option>
							<option>회원명</option>
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

	<!-- 테이블 -->
	<div class="whole_table">
		<div class="table_title">
			<span class="list_count">[ 검색 결과 ]&nbsp; 총 100건 중 1 - 10 건 </span>
		</div>
		<div class="table_wrap">
			<table>
				<colgroup>
					<col width="5%" />
					<!-- 번호 -->
					<col width="10%" />
					<!-- code -->
					<col width="25%" />
					<!-- 회원아이디 -->
					<col width="14%" />
					<!-- 회원명 -->
					<col width="10%" />
					<!-- 등급 -->
					<col width="14%" />
					<!-- 누적금액 -->
					<col width="14%" />
					<!-- 가입일 -->
					<col width="8%" />
					<!-- 상세보기 -->
				</colgroup>
				<thead>
					<tr>
						<th>#</th>
						<th>code</th>
						<th>회원아이디</th>
						<th>회원명</th>
						<th>등급</th>
						<th>총 구매 누적금액</th>
						<th>가입일</th>
						<th>상세보기</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td>10</td>
						<td>C250829801</td>
						<td>abc123@naver.com</td>
						<td>정이헌</td>
						<td>[VIP]</td>
						<td class="price_cell">122,345,600</td>
						<td>2025-09-01 12:58:97</td>
						<td><i class="bi bi-three-dots-vertical"></i></td>
					</tr>
					<tr>
						<td>9</td>
						<td>C123456</td>
						<td>abc123@naver.com</td>
						<td>정이헌</td>
						<td>[VIP]</td>
						<td class="price_cell">122,345,600</td>
						<td>2025-09-01 12:58:97</td>
						<td><i class="bi bi-three-dots-vertical"></i></td>
					</tr>
					<tr>
						<td>8</td>
						<td>C123456</td>
						<td>abc123@naver.com</td>
						<td>정이헌</td>
						<td>[VIP]</td>
						<td class="price_cell">122,345,600</td>
						<td>2025-09-01 12:58:97</td>
						<td><i class="bi bi-three-dots-vertical"></i></td>
					</tr>
					<tr>
						<td>7</td>
						<td>C123456</td>
						<td>abc123@naver.com</td>
						<td>정이헌</td>
						<td>[VIP]</td>
						<td class="price_cell">122,345,600</td>
						<td>2025-09-01 12:58:97</td>
						<td><i class="bi bi-three-dots-vertical"></i></td>
					</tr>
					<tr>
						<td>6</td>
						<td>C123456</td>
						<td>abc123@naver.com</td>
						<td>정이헌</td>
						<td>[VIP]</td>
						<td class="price_cell">122,345,600</td>
						<td>2025-09-01 12:58:97</td>
						<td><i class="bi bi-three-dots-vertical"></i></td>
					</tr>
					<tr>
						<td>5</td>
						<td>C123456</td>
						<td>abc123@naver.com</td>
						<td>정이헌</td>
						<td>[VIP]</td>
						<td class="price_cell">122,345,600</td>
						<td>2025-09-01 12:58:97</td>
						<td><i class="bi bi-three-dots-vertical"></i></td>
					</tr>
					<tr>
						<td>4</td>
						<td>C123456</td>
						<td>abc123@naver.com</td>
						<td>정이헌</td>
						<td>[VIP]</td>
						<td class="price_cell">122,345,600</td>
						<td>2025-09-01 12:58:97</td>
						<td><i class="bi bi-three-dots-vertical"></i></td>
					</tr>
					<tr>
						<td>3</td>
						<td>C123456</td>
						<td>abc123@naver.com</td>
						<td>정이헌</td>
						<td>[VIP]</td>
						<td class="price_cell">122,345,600</td>
						<td>2025-09-01 12:58:97</td>
						<td><i class="bi bi-three-dots-vertical"></i></td>
					</tr>
					<tr>
						<td>2</td>
						<td>C123456</td>
						<td>abc123@naver.com</td>
						<td>정이헌</td>
						<td>[VIP]</td>
						<td class="price_cell">122,345,600</td>
						<td>2025-09-01 12:58:97</td>
						<td><i class="bi bi-three-dots-vertical"></i></td>
					</tr>
					<tr>
						<td>1</td>
						<td>C123456</td>
						<td>abc123@naver.com</td>
						<td>정이헌</td>
						<td>[VIP]</td>
						<td class="price_cell">122,345,600</td>
						<td>2025-09-01 12:58:97</td>
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
<!-- 메인부분 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags"%>

<!-- ========== 내용(상품) ========== -->
<div id="product" class="tab_content" style="display: none">
	<div class="search_box">
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

					<div class="answer_box">
						<div class="filtering_title">
							<span class="searchbox_title">판매상태 : </span>
						</div>
						<div class="answer_body">
							<div class="choice ch">
								<input type="button" value="전체" />
							</div>
							<div class="choice ch">
								<input type="button" value="판매중" />
							</div>
							<div class="choice">
								<input type="button" value="판매중단" />
							</div>
						</div>
					</div>

					<div class="category_box">
						<div class="filtering_title">
							<span class="searchbox_title">카테고리 : </span>
						</div>
						<div>
							<select class="">
								<option>대분류</option>
								<option>대분류</option>
								<option>대분류</option>
								<option>대분류</option>
							</select> <select class="">
								<option>중분류</option>
								<option>중분류</option>
								<option>중분류</option>
								<option>중분류</option>
							</select> <select class="">
								<option>소분류</option>
								<option>소분류</option>
								<option>소분류</option>
								<option>소분류</option>
							</select>
						</div>
					</div>

					<div class="totalSearch_box">
						<div class="searchType">
							<select>
								<option>상품명</option>
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
	</div>
	<!-- 검색박스 end -->
	<!-- 상품목록 테이블 -->
	<div class="whole_table">
		<div class="table_title">
			<span class="list_count">[ 검색 결과 ]&nbsp; 총 100건 중 1 - 10 건 </span>
		</div>
		<div class="table_wrap">
			<table>
				<colgroup>
					<col width="5%" />
					<!-- 번호 -->
					<col width="5%" />
					<!-- Image -->
					<col width="25%" />
					<!-- 상품명 -->
					<col width="7%" />
					<!-- code -->
					<col width="17%" />
					<!-- 카테고리 -->
					<col width="6%" />
					<!-- 판매가격 -->
					<col width="6%" />
					<!-- 판매분류 -->
					<col width="6%" />
					<!-- 판매상태 -->
					<col width="10%" />
					<!-- 등록일 -->
					<col width="8%" />
					<!-- 누적판매수 -->
					<col width="7%" />
					<!-- 상세보기 -->
				</colgroup>
				<thead>
					<tr>
						<th>#</th>
						<th style="padding: auto 0">Img</th>
						<th>상품명</th>
						<th>code</th>
						<th>카테고리</th>
						<th>판매가격</th>
						<th>판매분류</th>
						<th>판매상태</th>
						<th>등록일</th>
						<th>누적판매수</th>
						<th>상세보기</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td>112525</td>
						<td class="img_cell"><img src="./image/no-image.svg"
							style="height: 40px" /></td>
						<td class="title_cell">쏘내추럴 올 데이 메이크업 픽서 120ml (안개분사 캔타입)</td>
						<td>P1002582</td>
						<td>뷰티소품 > 네일/바디소품 > 바디용품</td>
						<td class="price_cell">16,800</td>
						<td>[일반]</td>
						<td>[판매중]</td>
						<td>2025-12-31</td>
						<td>123,456,789</td>
						<td><i class="bi bi-three-dots-vertical"></i></td>
					</tr>
					<tr>
						<td>9</td>
						<td class="img_cell"><img src="./image/no-image.svg"
							style="height: 40px" /></td>
						<td class="title_cell">[유혜주PICK/리뷰이벤트] 메디큐브 PDRN 젤리 미스트 세럼
							100ml 기획</td>
						<td>P1002589</td>
						<td>스킨케어 > 미스트/오일 > 미스트/픽서</td>
						<td class="price_cell">896,500</td>
						<td>[기획]</td>
						<td>[판매중단]</td>
						<td>2025-09-08</td>
						<td>24,852</td>
						<td><i class="bi bi-three-dots-vertical"></i></td>
					</tr>
					<tr>
						<td>8</td>
						<td>S124567</td>
						<td class="title_cell">데이터 4-2</td>
						<td>데이터 4-3</td>
						<td>데이터 4-4</td>
						<td>데이터 2-3</td>
						<td>데이터 2-4</td>
						<td>데이터 2-4</td>
						<td>데이터 2-4</td>
						<td>데이터 2-4</td>
						<td>데이터 2-4</td>
					</tr>
					<tr>
						<td>7</td>
						<td>다섯번째</td>
						<td class="title_cell">데이터 5-2</td>
						<td>데이터 5-3</td>
						<td>데이터 5-4</td>
						<td>데이터 2-3</td>
						<td>데이터 2-4</td>
						<td>데이터 2-4</td>
						<td>데이터 2-4</td>
						<td>데이터 2-4</td>
						<td>데이터 2-4</td>
					</tr>
					<tr>
						<td>6</td>
						<td>다섯번째</td>
						<td class="title_cell">데이터 5-2</td>
						<td>데이터 5-3</td>
						<td>데이터 5-4</td>
						<td>데이터 2-3</td>
						<td>데이터 2-4</td>
						<td>데이터 2-4</td>
						<td>데이터 2-4</td>
						<td>데이터 2-4</td>
						<td>데이터 2-4</td>
					</tr>
					<tr>
						<td>5</td>
						<td>두번째 행 제목 (짧음)</td>
						<td class="title_cell">데이터 2-2</td>
						<td>데이터 2-3</td>
						<td>데이터 2-4</td>
						<td>데이터 2-3</td>
						<td>데이터 2-4</td>
						<td>데이터 2-4</td>
						<td>데이터 2-4</td>
						<td>데이터 2-4</td>
						<td>데이터 2-4</td>
					</tr>
					<tr>
						<td>4</td>
						<td>ss</td>
						<td class="title_cell">데이터 3-2</td>
						<td>데이터 3-3</td>
						<td>데이터 3-4</td>
						<td>데이터 2-3</td>
						<td>데이터 2-4</td>
						<td>데이터 2-4</td>
						<td>데이터 2-4</td>
						<td>데이터 2-4</td>
						<td>데이터 2-4</td>
					</tr>
					<tr>
						<td>3</td>
						<td>네번째</td>
						<td class="title_cell">데이터 4-2</td>
						<td>데이터 4-3</td>
						<td>데이터 4-4</td>
						<td>데이터 2-3</td>
						<td>데이터 2-4</td>
						<td>데이터 2-4</td>
						<td>데이터 2-4</td>
						<td>데이터 2-4</td>
						<td>데이터 2-4</td>
					</tr>
					<tr>
						<td>2</td>
						<td>다섯번째</td>
						<td class="title_cell">데이터 5-2</td>
						<td>데이터 5-3</td>
						<td>데이터 5-4</td>
						<td>데이터 2-3</td>
						<td>데이터 2-4</td>
						<td>데이터 2-4</td>
						<td>데이터 2-4</td>
						<td>데이터 2-4</td>
						<td>데이터 2-4</td>
					</tr>
					<tr>
						<td>1</td>
						<td>다섯번째</td>
						<td class="title_cell">데이터 5-2</td>
						<td>데이터 5-3</td>
						<td>데이터 5-4</td>
						<td>데이터 2-3</td>
						<td>데이터 2-4</td>
						<td>데이터 2-4</td>
						<td>데이터 2-4</td>
						<td>데이터 2-4</td>
						<td>데이터 2-4</td>
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
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags"%>

<!DOCTYPE html>
<html>
<!-- 헤드부분 -->
<%@ include file="./common/config.jsp"%>

<title>정산하기_정산내역</title>

<link rel="stylesheet" href="./css/accounts.css" />
<!-- 헤드부분 -->

<body>

	<!-- 레이아웃 + 메인컨텐츠 -->
	<my:adminLayout>
		<!-- 메인부분 -->
		<!-- 탭 -->
		<div class="listTabs title_font">
			<div class="listTab" onclick="">오늘 정산할 건</div>
			<div class="listTab active">정산 내역</div>
		</div>

		<!-- ************************* 정산 내역 탭 ************************* -->
		<div id="todayCalc" class="tab_content">
			<!-- 필터 -->
			<form class="search_form">
				<div class="search_container">
					<div class="filter">
						<div class="period_box">
							<div class="filtering_title">
								<span class="searchbox_title">기간 : </span>
							</div>
							<div class="period_body">
								<div>
									<input type="month" class="btn start_month" /> <span> -
									</span> <input type="month" class="btn end_month" />
								</div>

								<div class="p_choice">
									<input type="button" class="btn" value="이번달" /> <input
										type="button" class="btn" value="지난달" />
								</div>
							</div>
						</div>

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

			<!-- <div class="calc_target">
                            <div class="brand_search">
                                <div class="searchKeyword"><i class="bi bi-search"></i><input type="text" /></div>
                            </div>
                            <div>
                                <div class="year_search">
                                    <select>
                                        <option></option>
                                    </select>
                                </div>
                                <div class="month_search">
                                    <select>
                                        <option></option>
                                    </select>
                                </div>
                            </div>
                        </div> -->

			<!-- 정산내역 테이블 -->
			<div class="whole_table">
				<div class="table_title">
					<span>[ 검색 결과 ]&nbsp; 총 100건 중 1 - 10 건 </span>
				</div>
				<div class="table_wrap">
					<table>
						<colgroup>
							<col style="width: 5%" />
							<!-- 번호 -->
							<col style="width: 5%" />
							<!-- IMG -->
							<col style="width: 13%" />
							<!-- 브랜드명 -->
							<col style="width: 13%" />
							<!-- code -->
							<col style="width: 8%" />
							<!-- 정산월 -->
							<col style="width: 15%" />
							<!-- 당월 총 매출액 -->
							<col style="width: 15%" />
							<!-- 순수 매출액 -->
							<col style="width: 15%" />
							<!-- 수수료 -->
							<col style="width: 15%" />
							<!-- 정산금액 -->
							<col style="width: 10%" />
							<!-- 정산상태 -->
							<col style="width: 8%" />
							<!-- 상세보기 -->
						</colgroup>
						<thead>
							<tr>
								<th>#</th>
								<th>IMG</th>
								<th>브랜드명</th>
								<th>code</th>
								<th>정산월</th>
								<th>당월 총 매출액</th>
								<th>순수 매출액</th>
								<th>수수료</th>
								<th>정산 금액</th>
								<th>정산 상태</th>
								<th>상세보기</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td>10</td>
								<td class="img_cell"><img src="./image/no-image.svg" /></td>
								<td>아비브</td>
								<td>S123456</td>
								<td>2025-08</td>
								<td class="price_cell">122,345,600</td>
								<td class="price_cell">122,345,600</td>
								<td class="price_cell">122,345,600</td>
								<td class="price_cell">122,345,600</td>
								<td>[정산상태]</td>
								<td class="detail_cell"><i
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
	</my:adminLayout>
	<!-- 레이아웃 + 메인컨텐츠 end -->


	<!-- JS부분 -->
	<!-- JS부분 end -->

</body>
</html>
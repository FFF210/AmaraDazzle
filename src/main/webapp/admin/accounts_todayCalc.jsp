<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags"%>

<!DOCTYPE html>
<html>
<!-- 헤드부분 -->
<%@ include file="./common/config.jsp"%>

<title>정산하기_오늘 정산할 리스트</title>
<link rel="stylesheet" href="./css/accounts.css" />
<!-- 헤드부분 -->

<body>

	<!-- 레이아웃 + 메인컨텐츠 -->
	<my:adminLayout>
		<!-- 메인부분 -->
		<!-- 탭 -->
		<div class="listTabs">
			<div class="listTab active">오늘 정산할 건</div>
			<div class="listTab" onclick="">정산 내역</div>
		</div>

		<!-- ************************* 오늘 정산할 건 탭 ************************* -->
		<section class="main_content">
			<!-- 요약 -->
			<div class="summary">
				<table>
					<tr>
						<td>
							<i class="bi bi-dot"></i>
							<span>정산 기간 : </span> 
							<span> 2025-08-01 </span> ~ <span> 2025-08-31</span>
						</td>
						<td colspan="2">
							<i class="bi bi-dot"></i>
							<span>미정산 건수 : </span> 
							<span> 1,000</span> 건
						</td>
					</tr>
					<tr>
						<td>
							<i class="bi bi-dot"></i>
							<span>8월 총 매출 : </span> 
							<span> 1,000,000,000</span> 원
						</td>
						<td>
							<i class="bi bi-dot"></i>
							<span>총 수수료 : </span>
							<span>70,000,000</span> 원
						</td>
						<td>&nbsp;&nbsp;
							<i class="bi bi-dot"></i>
							<span>총 정산 금액 : </span>
							<span> 930,000,000</span> 원
						</td>
					</tr>
				</table>
			</div>

			<div>
				<!-- 필터 -->
				<form id="" class="search_form">
					<my:adminTableFilter>
						<my:adminFilterMiddle
							filters="게시 상태:ALL=전체|WAITING=미정산|InProgress=진행중|Completed=정산완료|ERROR=오류발생"
							name="middleFilter" />
						<my:adminFilterTotal searchItems="브랜드명" initial="브랜드명"/>
					</my:adminTableFilter>
				</form>
				<!-- 필터 end -->
	
				<!-- 테이블 -->
				<div class="whole_table">
					<div class="table_title">
						<span class="list_count"> 
						<c:if test="${not empty searchContent}"> [ 검색 결과 ] </c:if> 
						&nbsp; 총 ${pCouponCnt}건 중 
						<c:choose>
							<c:when test="${pCouponCnt == 0}">
	       						0 건
	    					</c:when>
							<c:otherwise>
	      						${postNo + 1}
	   							<c:choose>
									<c:when test="${paging.pageno == paging.end_pg && paging.final_post_ea < 10 && paging.final_post_ea != 0}">
	             						- ${postNo + paging.final_post_ea}
	        						</c:when>
									<c:otherwise>
	             						- ${postNo + 10}
	        						</c:otherwise>
								</c:choose>
	   							건
	  						</c:otherwise>
							</c:choose>
						</span>
						<!-- 버튼 -->
						<div>
							<button type="button" class="btn first_btn action_btn">일괄정산</button>
						</div>
						<!-- 버튼 end -->
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
									<th><input type="checkbox" id="all_ck"
										onclick="ck_all(this.checked);" /></th>
									<th>#</th>
									<th>IMG</th>
									<th class="sortable">브랜드명 <i class="bi bi-dash-lg sort-icon"></i></th>
									<th class="sortable">당월 총 매출액 <i class="bi bi-dash-lg sort-icon"></i></th>
									<th class="sortable">순 이익 <i class="bi bi-dash-lg sort-icon"></i></th>
									<th class="sortable">수수료 <i class="bi bi-dash-lg sort-icon"></i></th>
									<th class="sortable">정산 금액 <i class="bi bi-dash-lg sort-icon"></i></th>
									<th class="sortable">정산 상태 <i class="bi bi-dash-lg sort-icon"></i></th>
									<th>상세보기</th>
								</tr>
							</thead>
							<tbody>
								<!-- 게시물 개수가 0일 경우 -->
								<c:if test="${empty pCouponList}">
									<tr>
										<td colspan="10">등록된 게시물이 없습니다.</td>
									</tr>
								</c:if>
								
								
								<tr>
									<td><input type="checkbox" class="ch_box" value=""
										onclick="choice_ck();" /></td>
									<td>10</td>
									<td>아비브</td>
									<td>아비브</td>
									<td class="price_cell">122,345,600</td>
									<td class="price_cell">122,345,600</td>
									<td class="price_cell">122,345,600</td>
									<td class="price_cell">122,345,600</td>
									<td>[정산상태]</td>
									<td class="detail_cell" onclick="goDetail();"><i class="bi bi-three-dots-vertical"></i></td>
								</tr>
							</tbody>
						</table>
					</div>
	
					<!-- 페이지네이션 -->
					<c:set var="queryString">
						<c:if test="${param.startDate != null and param.startDate ne ''}">
	  						startDate=${param.startDate}&
						</c:if>
						<c:if test="${param.endDate != null and param.endDate ne ''}">
						    endDate=${param.endDate}&
						</c:if>
						<c:if test="${param.startDate2 != null and param.startDate2 ne ''}">
			  					startDate2=${param.startDate2}&
						</c:if>
						<c:if test="${param.endDate2 != null and param.endDate2 ne ''}">
						    endDate2=${param.endDate2}&
						</c:if>
						<c:if test="${param.totalSearch != null and param.totalSearch ne ''}">
						    totalSearch=${param.totalSearch}&
						</c:if>
						<c:if test="${param.keyword != null and param.keyword ne ''}">
						    keyword=${param.keyword}&
						</c:if>
							page=
					</c:set>
	
					<div class="pagination_wrap page-pagination">
						<my:adminPagination currentPage="${paging.pageno}" allPage="${paging.end_pg}"
							baseUrl="/admin/accountTodayList?${queryString}" />
					</div>
					<!-- 페이지네이션 end -->
				</div>
			</div>
		</section>
		<!-- 메인부분 -->
	</my:adminLayout>
	<!-- 레이아웃 + 메인컨텐츠 end -->


	<!-- JS부분 -->
	<script src="../tagjs/selectbox.js"></script>
	<script src="./js/common/table.js"></script>
	<!-- JS부분 end -->

</body>
</html>
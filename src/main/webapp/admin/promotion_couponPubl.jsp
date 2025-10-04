<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags"%>

<!DOCTYPE html>
<html>
<!-- 헤드부분 -->
<%@ include file="./common/config.jsp"%>

<title>정산내역 상세보기</title>

<link rel="stylesheet" href="./css/myApplications.css" />
<link rel="stylesheet" href="./css/accounts.css" />

<!-- 헤드부분 -->

<body>

	<!-- 레이아웃 + 메인컨텐츠 -->
	<my:adminLayout>
		<!-- 메인부분 -->
		<div class="alert_section" id="toast"></div>
		
		<!-- 탭 -->
		<div class="tabs">
			<div class="tab active">발행 쿠폰 목록</div>
			<div class="tab" onclick="">개별 지급 목록</div>
		</div>

		<!-- ************************* 발행 쿠폰 목록 탭 ************************* -->
		<div id="" class="tab_content">
			<!-- 필터 -->
			<form id="searchForm" class="search_form">
				<my:adminTableFilter>
					<my:adminFilterPeriod title="발행일자" />
					<my:adminFilterPeriod title="유효기간" dateCate="exp_" />
					<my:adminFilterTotal searchItems="쿠폰명,사용조건" />
				</my:adminTableFilter>
			</form>
			<!-- 필터 end -->

			<!-- 테이블 -->
			<div class="whole_table">
				<div class="table_title">
					<span class="list_count"> <c:if
							test="${not empty searchContent}">
				[ 검색 결과 ]
				</c:if> &nbsp; 총 ${pCouponCnt}건 중 <c:choose>
							<c:when test="${pCouponCnt == 0}">
       					0 건
    				</c:when>
							<c:otherwise>
      					${postNo + 1}
     							<c:choose>
									<c:when
										test="${paging.pageno == paging.end_pg && paging.final_post_ea < 10 && paging.final_post_ea != 0}">
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
						<button type="button" class="btn first_btn action_btn" onclick="cpPublBtn()">쿠폰발행</button>
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
							<!-- 상세보기 -->
						</colgroup>
						<thead>
							<tr>
								<th><input type="checkbox" id="all_ck"
									onclick="ck_all(this.checked);" /></th>
								<th>#</th>
								<th class="sortable">쿠폰명 <i class="bi bi-dash-lg sort-icon"></i></th>
								<th class="sortable">할인금액 <i
									class="bi bi-dash-lg sort-icon"></i></th>
								<th class="sortable">발행일 <i class="bi bi-dash-lg sort-icon"></i></th>
								<th>유효기간</th>
								<th class="sortable">잔여량 <i class="bi bi-dash-lg sort-icon"></i></th>
								<th>발행수량</th>
								<th>상세보기</th>
							</tr>
						</thead>
						<tbody>
							<!-- 게시물 개수가 0일 경우 -->
							<c:if test="${empty pCouponList}">
								<tr>
									<td colspan="9">등록된 게시물이 없습니다.</td>
								</tr>
							</c:if>

							<c:set var="no" value="${pCouponCnt-postNo}" />
							<c:forEach items="${pCouponList}" var="pCouponList"
								varStatus="idx">
								<tr>
									<td><input type="checkbox" class="ch_box"
										value="${pCouponList.couponId}" onclick="choice_ck();" /></td>
									<td>${no-idx.index}</td>
									<td>${pCouponList.cname}</td>
									<td class="price_cell">${pCouponList.amount}</td>
									<td>${pCouponList.createdAt}</td>
									<td>${pCouponList.startDate} ~ ${pCouponList.endDate}</td>
									<td></td>
									<td>${pCouponList.couponLimit}</td>
									<td class="detail_cell"><i
										class="bi bi-three-dots-vertical"></i></td>
								</tr>
							</c:forEach>
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
					<c:if
						test="${param.totalSearch != null and param.totalSearch ne ''}">
			    totalSearch=${param.totalSearch}&
			</c:if>
					<c:if test="${param.keyword != null and param.keyword ne ''}">
			    keyword=${param.keyword}&
			</c:if>
			page=
		</c:set>

				<div class="pagination_wrap page-pagination">
					<my:adminPagination currentPage="${paging.pageno}"
						allPage="${paging.end_pg}"
						baseUrl="/admin/pCouponList?${queryString}" />
				</div>
				<!-- 페이지네이션 end -->
			</div>
		</div>
		<!-- 메인부분 -->

	</my:adminLayout>
	<!-- 레이아웃 + 메인컨텐츠 end -->

	<script src="../tagjs/selectbox.js"></script>
	<script src="../tagjs/dateInput.js"></script>
	<script src="./js/componant/table.js"></script>
	<script src="./js/couponP.js"></script>
	


</body>
</html>
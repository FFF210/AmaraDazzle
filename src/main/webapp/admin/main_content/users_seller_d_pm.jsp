<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags"%>


<!-- ========== 내용(결제내역) ========== -->
<div id="payment" class="tab_content" style="display: none">
	<!-- 필터 -->
	<form id="sellerPchForm" class="search_form">
		<my:adminTableFilter>
			<my:adminFilterPeriod title="결제일" />
			<my:adminFilterPeriod title="사용기간" />
			<my:adminFilterMiddle filters="구매유형:ALL=전체|SALE=멤버십|SOLD_OUT=배너구매" name="pchType" />
			<my:adminFilterCate />
			<my:adminFilterTotal searchItems="내용,제목" />
		</my:adminTableFilter>
	</form>
	<!-- 필터 end -->

	<!-- 결제내역 테이블 -->
	<div class="whole_table">
		<div class="table_title">
			<span class="list_count"> 
			<c:if test="${not empty searchContent}">
				[ 검색 결과 ]
			</c:if> &nbsp; 총 ${sellerCnt}건 중 
			<c:choose>
				<c:when test="${sellerCnt == 0}">
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
		</div>
		<div class="table_wrap">
			<table>
				<colgroup>
					<col style="width: 5%" />
					<!-- 번호 -->
					<col style="width: 15%" />
					<!-- 결제일 -->
					<col style="width: 20%" />
					<!-- 구매내역 -->
					<col style="width: 10%" />
					<!-- 결제금액 -->
					<col style="width: 15%" />
					<!-- 사용여부 -->
					<col style="width: 20%" />
					<!-- 사용기간 -->
					<col style="width: 7%" />
					<!-- 상세보기 -->
				</colgroup>
				<thead>
					<tr>
						<th>#</th>
						<th>결제일</th>
						<th>구매내역</th>
						<th>결제금액</th>
						<th>사용여부</th>
						<th>사용기간</th>
						<th>상세보기</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td>10</td>
						<td>2025-09-01</td>
						<td>P202509-02586</td>
						<td>멤버십 3개월</td>
						<td class="price_cell">500,000</td>
						<td>Y</td>
						<td>2025-09-01 ~ 2025-11-30</td>
						<td><i class="bi bi-three-dots-vertical"></i></td>
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
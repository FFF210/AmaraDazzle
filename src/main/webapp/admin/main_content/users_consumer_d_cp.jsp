<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags"%>

<!-- ========== 내용(쿠폰) ========== -->
<div id="coupon" class="tab_content" style="display: none">
	<!-- 필터 -->
	<form id="sellerSettleForm" class="search_form">
		<my:adminTableFilter>
			<my:adminFilterPeriod title="발행일자" />
			<my:adminFilterPeriod title="유효기간" dateCate="exp_"/>
			<my:adminFilterMiddle filters="답변상태:ALL=전체|SHIPPING=미사용|DELIVERED=사용|ddd=기간만료" name="settleStatus" />
			<my:adminFilterCate />
			<my:adminFilterTotal searchItems="쿠폰명,쿠폰코드,회원아이디,회원명,조건,주문번호" />
		</my:adminTableFilter>
	</form>
	<!-- 필터 end -->
	<!-- 쿠폰 테이블 -->
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
					<!--번호-->
					<col style="width: 13%" />
					<!-- 쿠폰코드 -->
					<col style="width: 15%" />
					<!--쿠폰명-->
					<col style="width: 8%" />
					<!--발행일자-->
					<col style="width: 15%" />
					<!--유효기간-->
					<col style="width: 8%" />
					<!--할인액-->
					<col style="width: 10%" />
					<!--조건-->
					<col style="width: 7%" />
					<!--사용여부-->
					<col style="width: 7%" />
					<!--쿠폰상태-->
					<col style="width: 11%" />
					<!--주문번호-->
					<col style="width: 6%" />
					<!--상세보기-->
				</colgroup>
				<thead>
					<tr>
						<th>#</th>
						<th>쿠폰코드</th>
						<th>쿠폰명</th>
						<th>발행일자</th>
						<th>유효기간</th>
						<th>할인액</th>
						<th>조건</th>
						<th>사용여부</th>
						<th>쿠폰상태</th>
						<th>주문번호</th>
						<th>상세보기</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td>10</td>
						<td>lINzCaiPwuLDIGPcdNdB</td>
						<td>리쇼라 30만원 할일</td>
						<td>2025-09-07</td>
						<td>2025-09-07 ~ 2025-09-17</td>
						<td class="price_cell">3,000,000</td>
						<td>3만원 이상 구매시</td>
						<td>미사용</td>
						<td>사용가능</td>
						<td>20250907-12589</td>
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
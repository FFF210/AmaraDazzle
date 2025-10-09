<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags"%>


<!-- ========== 내용(포인트) ========== -->
<div id="point" class="tab_content" style="display: none">
	<!-- 필터 -->
	<form id="sellerSettleForm" class="search_form">
		<my:adminTableFilter>
			<my:adminFilterPeriod title="날짜" />
			<my:adminFilterMiddle filters="사용내역:ALL=전체|SHIPPING=사용|DELIVERED=적립" name="settleStatus" />
			<my:adminFilterTotal searchItems="주문번호,상품명,브랜드명" />
		</my:adminTableFilter>
	</form>
	<!-- 필터 end -->
	<!-- 포인트 테이블 -->
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
					<!-- 날짜 -->
					<col style="width: 15%" />
					<!-- 포인트내역 -->
					<col style="width: 10%" />
					<!-- 금액 -->
					<col style="width: 10%" />
					<!-- 사용내역 -->
					<col style="width: 20%" />
					<!-- 주문번호 -->
					<col style="width: 10%" />
					<!-- 상세보기 -->
				</colgroup>
				<thead>
					<tr>
						<th>#</th>
						<th>날짜</th>
						<th>포인트내역</th>
						<th>금액</th>
						<th>사용내역</th>
						<th>주문번호</th>
						<th>상세보기</th>
					</tr>
				</thead>
				<tbody>
					<tr data-group="1" data-main="true">
						<td>10</td>
						<td>2025-09-02 11:12:13</td>
						<td>상품 구매 적립</td>
						<td class="price_cell">2,000</td>
						<td>적립</td>
						<td>20250902-0145874</td>
						<td class="detail_cell"><i class="bi bi-three-dots-vertical"></i></td>
					</tr>
					<tr data-group="1" data-main="true">
						<td>10</td>
						<td>2025-09-02 11:12:13</td>
						<td>상품 구매 사용</td>
						<td class="price_cell">1,000</td>
						<td>사용</td>
						<td>20250902-014485</td>
						<td class="detail_cell"><i class="bi bi-three-dots-vertical"></i></td>
					</tr>
					<tr data-group="1" data-main="true">
						<td>10</td>
						<td>2025-09-02 11:12:13</td>
						<td>리뷰 적립</td>
						<td class="price_cell">2,000</td>
						<td>적립</td>
						<td>20250902-014485</td>
						<td class="detail_cell"><i class="bi bi-three-dots-vertical"></i></td>
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
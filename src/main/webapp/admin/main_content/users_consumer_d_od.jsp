<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags"%>

<!-- ========== 내용(주문내역) ========== -->
<div id="order" class="tab_content">
	<!-- 필터 -->
	<form id="sellerSettleForm" class="search_form">
		<my:adminTableFilter>
			<my:adminFilterPeriod title="주문일" />
			<my:adminFilterMiddle filters="주문상태:ALL=전체|SHIPPING=결제완료|DELIVERED=상품준비중|COLLECTING=배송중|EXCHANGE SHIPPING=배송완료|SHIPPING=취소|DELIVERED=교환|COLLECTING=반품" name="settleStatus" />
			<my:adminFilterTotal searchItems="주문번호,상품명,브랜드명" />
		</my:adminTableFilter>
	</form>
	<!-- 필터 end -->
	
	<!-- 주문내역 테이블 -->
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
					<col style="width: 15%" />
					<!-- 주문번호 -->
					<col style="width: 25%" />
					<!--상품명-->
					<col style="width: 10%" />
					<!--최종결제금액-->
					<col style="width: 12%" />
					<!--브랜드명-->
					<col style="width: 12%" />
					<!--주문일자-->
					<col style="width: 10%" />
					<!--주문상태-->
					<col style="width: 8%" />
					<!--상세보기-->
				</colgroup>
				<thead>
					<tr>
						<th>#</th>
						<th>주문번호</th>
						<th>상품명</th>
						<th>최종결제금액</th>
						<th>브랜드명</th>
						<th>주문일자</th>
						<th>주문상태</th>
						<th>상세보기</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td>10</td>
						<td>20250825-001478</td>
						<td class="title_cell">[수분진정] 아비브 어성초 카... 외 3건</td>
						<td class="price_cell">25.300</td>
						<td>아비브</td>
						<td>2025-08-25 11:20:50</td>
						<td>[배송중]</td>
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
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags"%>

<!-- ========== 내용(정산내역) ========== -->
<div id="calculate" class="tab_content">
	<!-- 필터 -->
	<form id="sellerSettleForm" class="search_form">
		<my:adminTableFilter>
			<my:adminFilterPeriod title="정산월" presets="이번달,지난달,최근1년" />
			<my:adminFilterMiddle filters="정산 진행상태:ALL=전체|COMPLETED=완료|IN_PROGRESS=진행중|WAITING=대기중|ERROR=오류발생" name="settleStatus" />
		</my:adminTableFilter>
	</form>
	<!-- 필터 end -->

	<!-- 정산 테이블 -->
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
					<col style="width: 10%" />
					<col style="width: 10%" />
					<col style="width: 10%" />
					<col style="width: 10%" />
					<col style="width: 10%" />
					<col style="width: 15%" />
					<col style="width: 8%" />
				</colgroup>
				<thead>
					<tr>
						<th>#</th>
						<th>정산월</th>
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
		<div class="pagination_wrap page-pagination">
			<my:adminPagination currentPage="${paging.pageno}" allPage="${paging.end_pg}"
					baseUrl="/admin/sellerList?${queryString}" />
		</div>
		<!-- 페이지네이션 end -->
	</div>
</div>
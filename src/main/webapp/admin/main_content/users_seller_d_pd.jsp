<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>	
<%@ taglib prefix="my" tagdir="/WEB-INF/tags"%>



<!-- ========== 내용(상품) ========== -->
<div id="product" class="tab_content" style="display: none">
	<!-- 필터 -->
	<form id="sellerPdForm" class="search_form">
		<my:adminTableFilter>
			<my:adminFilterPeriod title="등록일" />
			<my:adminFilterMiddle filters="판매상태:ALL=전체|SALE=판매중|SOLD_OUT=품절|STOP_SALE=판매중지" name="pdStatus" />
			<my:adminFilterCate />
			<my:adminFilterTotal searchItems="내용,제목" />
		</my:adminTableFilter>
	</form>
	<!-- 필터 end -->

	<!-- 상품목록 테이블 -->
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
					<col style="width: 5%" />
					<!-- Image -->
					<col style="width: 25%" />
					<!-- 상품명 -->
					<col style="width: 7%" />
					<!-- code -->
					<col style="width: 17%" />
					<!-- 카테고리 -->
					<col style="width: 6%" />
					<!-- 판매가격 -->
					<col style="width: 6%" />
					<!-- 판매분류 -->
					<col style="width: 6%" />
					<!-- 판매상태 -->
					<col style="width: 10%" />
					<!-- 등록일 -->
					<col style="width: 8%" />
					<!-- 누적판매수 -->
					<col style="width: 7%" />
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
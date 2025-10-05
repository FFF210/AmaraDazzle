<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags"%>


<!-- 메인부분 -->
<!-- 필터 -->
<form id="searchForm" class="search_form">
	<my:adminTableFilter>
		<my:adminFilterPeriod title="등록일" />
		<my:adminFilterPeriod title="전시 기간" dateCate="post_" />
		<my:adminFilterMiddle filters="게시 상태:ALL=전체|OFF=게시종료|POSTING=게시중"
			name="middleFilter" />
		<my:adminFilterTotal searchItems="브랜드명,제목" />
	</my:adminTableFilter>
</form>
<!-- 필터 end -->

<!-- 버튼 -->
<div class="button_wrap">
	<div>
		<button type="button" class="btn second_btn action_btn">글쓰기</button>
	</div>
	<div>
		<button type="button" class="btn first_btn action_btn">게시</button>
	</div>
</div>
<!-- 버튼 end -->
<!-- 테이블 -->
<div class="whole_table">
	<div class="table_title">
		<span class="list_count"> <c:if
				test="${not empty searchContent}">
						[ 검색 결과 ]
						</c:if> &nbsp; 총 ${bannerCnt}건 중 <c:choose>
				<c:when test="${bannerCnt == 0}">
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
	</div>
	${bannerList.startDate}
	<div class="table_wrap">
		<table>
			<colgroup>
				<col style="width: 5%" />
				<!-- 체크박스 -->
				<col style="width: 5%" />
				<!-- 번호 -->
				<col style="width: 5%" />
				<!-- 썸네일 -->
				<col style="width: 20%" />
				<!-- 제목 -->
				<col style="width: 10%" />
				<!-- 브랜드명 -->
				<col style="width: 15%" />
				<!-- 전시기간 -->
				<col style="width: 10%" />
				<!-- 등록일 -->
				<col style="width: 10%" />
				<!-- 노출여부 -->
				<col style="width: 15%" />
				<!-- 게시일 -->
				<col style="width: 8%" />
				<!-- 상세보기 -->
			</colgroup>
			<thead>
				<tr>
					<th><input type="checkbox" id="all_ck" onclick="ck_all(this.checked);" /></th>
					<th>#</th>
					<th>IMG</th>
					<th class="sortable">제목 <i class="bi bi-dash-lg sort-icon"></i></th>
					<th class="sortable">브랜드명 <i class="bi bi-dash-lg sort-icon"></i></th>
					<th>전시기간</th>
					<th class="sortable">등록일 <i class="bi bi-dash-lg sort-icon"></i></th>
					<th class="sortable">게시여부 <i class="bi bi-dash-lg sort-icon"></i></th>
					<th class="sortable">게시일 <i class="bi bi-dash-lg sort-icon"></i></th>
					<th>상세보기</th>
				</tr>
			</thead>
			<tbody>
				<!-- 게시물 개수가 0일 경우 -->
				<c:if test="${empty bannerList}">
					<tr>
						<td colspan="10">등록된 게시물이 없습니다.</td>
					</tr>
				</c:if>

				<c:set var="no" value="${bannerCnt-postNo}" />
<%-- 				<c:set var="start" value="${bannerList.startDate}" />  --%>
<%-- 				<c:set var="end" value="${bannerList.endDate}" />  --%>
<%-- 				<c:set var="createDate" value="${bannerList.createdAt}" />  --%>
<%-- 				<c:set var="updatedAt" value="${bannerList.updatedAt}" />  --%>
									
				<c:forEach items="${bannerList}" var="bannerList" varStatus="idx">
					<tr>
						<td><input type="checkbox" class="ch_box"
							value="${bannerList.bannerId}" onclick="choice_ck();" /></td>
						<td>${no-idx.index}</td>
						<td class="img_cell"><img src="/image/no-image.svg" /></td>
						<td class="title_cell">${bannerList.bannerName}</td>
						<td>${bannerList.brandName}</td>
<%-- 						<td>${fn:substring(start,0,10)} ~ ${fn:substring(end,0,10)}</td> --%>
<%-- 						<td>${fn:substring(createDate,0,19)}</td> --%>
						<td><span onclick="changeState()"> <c:choose>
									<c:when test="${bannerList.stateChange == 'POSTING' }">
										<!-- 게시여부 : 게시중 -->
										<my:tag color="yellow" size="md" text="게시중" />
									</c:when>
									<c:when test="${bannerList.stateChange == 'OFF'}">
										<!-- 게시여부 : 노게시 -->
										<my:tag color="gray" size="md" text="비공개" />
									</c:when>
								</c:choose>
						</span></td>
<%-- 						<td>${fn:substring(updatedAt,0,19)}</td> --%>
						<td class="detail_cell"><i class="bi bi-three-dots-vertical"></i></td>
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
		<c:if test="${param.middleFilter != null and param.middleFilter ne ''}">
					    middleFilter=${param.middleFilter}&
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
		<my:adminPagination currentPage="${paging.pageno}"
			allPage="${paging.end_pg}"
			baseUrl="/admin/promoBannerList?${queryString}" />
	</div>
	<!-- 페이지네이션 end -->

</div>
<!-- 메인부분 -->



<script src="../tagjs/selectbox.js"></script>
<script src="../tagjs/dateInput.js"></script>
<script src="./js/componant/table.js"></script>



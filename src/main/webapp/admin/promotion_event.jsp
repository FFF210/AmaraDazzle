<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags"%>

<!DOCTYPE html>
<html>
<!-- 헤드부분 -->
<%@ include file="./common/config.jsp"%>

<title>Promotions 이벤트 리스트</title>
<link rel="stylesheet" href="./css/event.css" />
<!-- 헤드부분 -->

<body>

	<!-- 레이아웃 + 메인컨텐츠 -->
	<my:adminLayout>
		<!-- 메인부분 -->
		<div class="tabs">
			<div class="tab active" onclick="showTab('eventList')">이벤트</div>
			<div class="tab" onclick="showTab('ended_promo')">종료된 프로모션</div>
		</div>

		<!-- ************************* 판매자 탭 ************************* -->
		<div id="event_ing" class="tab_content">
			<!-- 필터 -->
			<form id="searchForm" class="search_form">
				<my:adminTableFilter>
					<my:adminFilterPeriod title="등록일" />
					<my:adminFilterPeriod title="이벤트 기간" dateCate="event_" />
					<my:adminFilterTotal searchItems="이벤트명,브랜드명" />
				</my:adminTableFilter>
			</form>
			<!-- 필터 end -->

			<!-- 버튼 -->
			<div class="button_wrap">
				<div>
					<button type="button" class="btn first_btn action_btn" onclick="goWriteEvet()">글쓰기</button>
				</div>
				<div>
					<button type="button" class="btn second_btn action_btn">삭제</button>
				</div>
			</div>
			<!-- 버튼 end -->
			<!-- 테이블 -->
			<div class="whole_table">
				<div class="table_title">
					<span class="list_count"> 
						<c:if test="${not empty searchContent}">
						[ 검색 결과 ]
						</c:if> 
						&nbsp; 총 ${eventCount}건 중 
						<c:choose>
							<c:when test="${eventCount == 0}">
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
							<!-- 체크박스 -->
							<col style="width: 5%" />
							<!-- 번호 -->
							<col style="width: 20%" />
							<!-- 이벤트명 -->
							<col style="width: 15%" />
							<!-- 브랜드명 -->
							<col style="width: 9%" />
							<!-- 이벤트종류 -->
							<col style="width: 15%" />
							<!-- 이벤트기간 -->
							<col style="width: 10%" />
							<!-- 등록일 -->
							<col style="width: 5%" />
							<!-- 조회수 -->
							<col style="width: 8%" />
							<!-- 노출여부 -->
							<col style="width: 8%" />
							<!-- 상세보기 -->
						</colgroup>
						<thead>
							<tr>
								<th><input type="checkbox" id="all_ck" onclick="ck_all(this.checked);" /></th>
								<th>#</th>
								<th class="sortable">이벤트명 <i class="bi bi-dash-lg sort-icon"></i></th>
								<th>브랜드명</th>
								<th class="sortable">이벤트종류 <i class="bi bi-dash-lg sort-icon"></i></th>
								<th>이벤트기간</th>
								<th>등록일</th>
								<th>조회수</th>
								<th class="sortable">노출여부 <i class="bi bi-dash-lg sort-icon"></i></th>
								<th>상세보기</th>
							</tr>
						</thead>
						<tbody>
							<!-- 게시물 개수가 0일 경우 -->
							<c:if test="${empty eventList}">
								<tr>
									<td colspan="10">등록된 게시물이 없습니다.</td>
								</tr>
							</c:if>

							<c:set var="no" value="${eventCount-postNo}" />
							<c:forEach items="${eventList}" var="eventList" varStatus="idx">
							<c:set var="startDate" value="${eventList.startDate}" />
							<c:set var="endDate" value="${eventList.endDate}" />
							<c:set var="createDate" value="${eventList.createdAt}" />
								<tr>
									<td><input type="checkbox" class="ch_box"
										value="${eventList.eventId}" onclick="choice_ck();" /></td>
									<td>${no-idx.index}</td>
									<td class="title_cell">${eventList.eventName}</td>
									<td>${eventList.brandName}</td>
									<td>
										<c:choose>
											<c:when test="${eventList.eventType == 'COUPON'}">
												<my:tag color="pink" size="md" text="쿠폰" />
											</c:when>
											<c:when test="${eventList.eventType == 'DISCOUNT'}">
												<my:tag color="green" size="md" text="할인" />
											</c:when>
											<c:when test="${eventList.eventType == 'EXPERIENCE'}">
												<my:tag color="blue" size="md" text="체험단" />
											</c:when>
											<c:when test="${eventList.eventType == 'PICK'}">
												<my:tag color="blue" size="md" text="AD's PICK" />
											</c:when>
											<c:when test="${eventList.eventType == 'ETC'}">
												<my:tag color="blue" size="md" text="기타" />
											</c:when>
										</c:choose>
									</td>
									<td>${fn:substring(startDate,0,10)} ~ ${fn:substring(endDate,0,10)}</td>
									<td>${fn:substring(createDate,0,19)}</td>
									<td>${eventList.eventViewCnt}</td>
									<td><c:choose>
											<c:when test="${eventList.isExposed == '1'}">
												<!-- 게시중 -->
												<my:tag color="pink" size="md" text="게시중" />
											</c:when>
											<c:otherwise>
												<!-- 노게시 -->
												<my:tag color="green" size="md" text="비공개" />
											</c:otherwise>
										</c:choose></td>
									<td class="detail_cell" onclick="goEventDetail()">
										<i class="bi bi-three-dots-vertical"></i>
									</td>
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
						baseUrl="/admin/promoEventList?${queryString}" />
				</div>
				<!-- 페이지네이션 end -->
			</div>
		</div>
		<!-- 메인부분 -->
	</my:adminLayout>
	<!-- 레이아웃 + 메인컨텐츠 end -->



	<!-- JS부분 -->
	<script src="../tagjs/selectbox.js"></script>
	<script src="../tagjs/dateInput.js"></script>
	<script src="./js/common/table.js"></script>
	<script src="./js/event.js"></script>s
	<!-- JS부분 end -->

</body>
</html>
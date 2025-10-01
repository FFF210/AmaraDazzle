<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags"%>

<!-- 메인부분 -->
<!-- 탭 -->
<div class="tabs">
	<div class="tab active" onclick="showTab('seller')">판매자</div>
	<div class="tab" onclick="showTab('platform')">플랫폼</div>
</div>

<!-- ************************* 판매자 탭 ************************* -->
<div id="seller" class="tab_content">

	<!-- 필터 -->
	<form id="searchForm" class="search_form">
		<my:adminTableFilter >
			<my:adminFilterPeriod title="작성일" />
			<my:adminFilterType optList="시스템,이벤트,기타" initial="문의 유형" name="q_select"/>
			<my:adminFilterTotal searchItems="내용,제목" />
		</my:adminTableFilter>
	</form>
	<!-- 필터 end -->

	<!-- 버튼 -->
	<div class="button_wrap">
		<div>
			<button type="button" class="btn first_btn action_btn"
				onclick="goWriteNoticeSeller()">글쓰기</button>
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
				&nbsp; 총 ${noticeCnt}건 중 
				<c:choose>
					<c:when test="${noticeCnt == 0}">
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
					<col style="width: 6%" />
					<!-- 체크박스 -->
					<col style="width: 7%" />
					<!-- 번호 -->
					<col style="width: 10%" />
					<!-- 카테고리 -->
					<col style="width: 30%" />
					<!-- 제목 -->
					<col style="width: 9%" />
					<!-- 작성자 -->
					<col style="width: 15%" />
					<!-- 작성일 -->
					<col style="width: 7%" />
					<!-- 조회수 -->
					<col style="width: 8%" />
					<!-- 노출여부 -->
					<col style="width: 8%" />
					<!-- 상세보기-->
				</colgroup>
				<thead>
					<tr>
						<th><input type="checkbox" id="all_ck" onclick="ck_all(this.checked);"/></th>
						<th>#</th>
						<th class="sortable">카테고리 <i class="bi bi-dash-lg sort-icon"></i></th>
						<th class="sortable">제목 <i class="bi bi-dash-lg sort-icon"></i></th>
						<th>작성자</th>
						<th>작성일</th>
						<th class="sortable">조회수 <i class="bi bi-dash-lg sort-icon"></i></th>
						<th class="sortable">노출여부 <i class="bi bi-dash-lg sort-icon"></i></th>
						<th>상세보기</th>
					</tr>
				</thead>
				<tbody>
					<!-- 게시물 개수가 0일 경우 -->
					<c:if test="${empty noticeList}">
						<tr>
							<td colspan="9">등록된 게시물이 없습니다.</td>
						</tr>
					</c:if>

					<c:set var="no" value="${noticeCnt-postNo}" />
					<c:forEach items="${noticeList}" var="noticeList" varStatus="idx">
						<tr>
							<td><input type="checkbox" class="n_ch" value="${noticeList.noticeId}" onclick="choice_ck();"/></td>
							<td>${no-idx.index}</td>
							<td><c:choose>
									<c:when test="${noticeList.typeId == '25' || noticeList.typeId == '29'}">
										<!-- 카테고리 : 이벤트 -->
										<my:tag color="pink" size="md" text="${noticeList.name}" />
									</c:when>
									<c:when test="${noticeList.typeId == '26' || noticeList.typeId == '28'}">
										<!-- 카테고리 : 점검 / 시스템 -->
										<my:tag color="green" size="md" text="${noticeList.name}" />
									</c:when>
									<c:when test="${noticeList.typeId == '27' || noticeList.typeId == '30'}">
										<!-- 카테고리 : 기타 -->
										<my:tag color="blue" size="md" text="${noticeList.name}" />
									</c:when>
								</c:choose></td>
							<td class="title_cell"
								onclick="goNoticeDetail('${noticeList.noticeId}','${noticeList.targetTypeId}');">
								<c:if test="${fn:length(noticeList.imageFileIds)!=0}">
									<i class="bi bi-paperclip"></i>&nbsp;&nbsp;
								</c:if> 
								${noticeList.title}
							</td>
							<td>Amara Dazzle</td>
							<td><c:set var="createDate" value="${noticeList.createdAt}" />
								&nbsp; ${fn:substring(createDate,0,19)}</td>
							<td>${noticeList.viewCnt}</td>
							<td>
								<span onclick="changeState()">
								<c:choose>
									<c:when test="${noticeList.isExposed == '1' }">
										<!-- 게시여부 : 게시중 -->
										<my:tag color="yellow" size="md" text="게시중" />
									</c:when>
									<c:when test="${noticeList.isExposed == '0'}">
										<!-- 게시여부 : 노게시 -->
										<my:tag color="gray" size="md" text="비공개" />
									</c:when>
								</c:choose>
								</span>
							</td>
							<td class="detail_cell"
								onclick="goNoticeDetail('${noticeList.noticeId}','${noticeList.targetTypeId}');"><i
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
			<c:if test="${param.q_select != null and param.q_select ne ''}">
			    q_select=${param.q_select}&
			</c:if>
			<c:if test="${param.totalSearch != null and param.totalSearch ne ''}">
			    totalSearch=${param.totalSearch}&
			</c:if>
			<c:if test="${param.keyword != null and param.keyword ne ''}">
			    keyword=${param.keyword}&
			</c:if>
			page=
		</c:set>

		<div class="pagination_wrap page-pagination" >
			<my:adminPagination currentPage="${paging.pageno}"
				allPage="${paging.end_pg}" baseUrl="/admin/noticeSellerList?${queryString}" />
		</div>
		<!-- 페이지네이션 end -->
	</div>
</div>
<!-- 메인부분 -->

<script src="../tagjs/selectbox.js"></script>
<script src="../tagjs/dateInput.js"></script>
<script src="./js/boardNotice.js"></script>
<script src="./js/componant/table.js"></script>

<script>
/* ****************************************
	tableFilter 이벤트
***************************************** */
document.addEventListener("filterChanged", (e) => {
	console.log("필터 상태:", e.detail);

	if (e.detail.submit) {
		const { filters, totalSearch, keyword } = e.detail;
		const params = new URLSearchParams();

		for (const [key, value] of Object.entries(filters)) {
			params.append("status", value);
		}

		if (totalSearch) params.append("totalSearch", totalSearch);
		if (keyword) params.append("keyword", keyword);

		// 페이지는 1부터 시작
		params.append("page", 1);

		// 최종 URL로 이동 (GET 요청)
		window.location.href = "/admin/noticeSellerList?" + params.toString();
	}
});
</script>

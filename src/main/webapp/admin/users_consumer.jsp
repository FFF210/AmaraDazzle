<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags"%>

<!DOCTYPE html>
<html>
<!-- 헤드부분 -->
<%@ include file="./common/config.jsp"%>

<title>Users 일반회원</title>
<link rel="stylesheet" href="./css/user_consumer.css" />
<!-- 헤드부분 end -->

<body>
	<!-- 레이아웃 + 메인컨텐츠 -->
	<my:adminLayout>
		<!-- 메인부분 -->
		<!-- 탭 -->
		<div class="listTabs">
			<div class="listTab" onclick="goSellerList()">판매자 회원 (${sellerAllCnt})</div>
			<div class="listTab active">일반회원 회원 (${memberAllCnt})</div>
		</div>

		<!-- ************************* 일반회원 탭 ************************* -->
		<div class="main_content">
			<!-- 필터 -->
			<form id="sellerSearchForm" class="search_form">
				<my:adminTableFilter>
					<my:adminFilterPeriod title="가입일" />
					<my:adminFilterMiddle filters="등급:ALL=전체|VIP=VIP|GOLD=GOLD|SILVER=SILVER|NORMAL=일반" name="memberGrade" />
					<my:adminFilterTotal searchItems="아이디,회원명" />
				</my:adminTableFilter>
			</form>
			<!-- 필터 end -->
			
			<!-- 일반회원 테이블 -->
			<div class="whole_table" style="display: ${searched eq 'searched' ? 'block' : 'none'};">
				<div class="table_title">
					<span class="list_count"> 
					<c:if test="${not empty searchContent}"> [ 검색 결과 ] </c:if> 
					&nbsp; 총 ${memberCnt}건 중 
					<c:choose>
						<c:when test="${memberCnt == 0}">
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
							<col style="width: 25%" />
							<!-- 회원아이디 -->
							<col style="width: 17%" />
							<!-- 회원명 -->
							<col style="width: 10%" />
							<!-- 등급 -->
							<col style="width: 15%" />
							<!-- 누적금액 -->
							<col style="width: 15%" />
							<!-- 가입일 -->
							<col style="width: 8%" />
							<!-- 상세보기 -->
						</colgroup>
						<thead>
							<tr>
								<th><input type="checkbox" id="all_ck" onclick="ck_all(this.checked);" /></th>
								<th>#</th>
								<th class="sortable">회원아이디 <i class="bi bi-dash-lg sort-icon"></i></th>
								<th class="sortable">회원명 <i class="bi bi-dash-lg sort-icon"></i></th>
								<th class="sortable">등급 <i class="bi bi-dash-lg sort-icon"></i></th>
								<th class="sortable">총 구매 누적금액 <i class="bi bi-dash-lg sort-icon"></i></th>
								<th class="sortable">가입일 <i class="bi bi-dash-lg sort-icon"></i></th>
								<th>상세보기</th>
							</tr>
						</thead>
						<tbody>
							<!-- 게시물 개수가 0일 경우 -->
							<c:if test="${empty memberList}">
								<tr>
									<td colspan="7">${message}</td>
								</tr>
							</c:if>
							
							<c:set var="no" value="${memberCnt-postNo}" />
							<c:forEach items="${memberList}" var="memberList" varStatus="idx">
								<c:set var="createDate" value="${memberList.createdAt}" />
								<tr>
									<td><input type="checkbox" class="ch_box" value="${memberList.memberId}" onclick="choice_ck();" /></td>
									<td>${no-idx.index}</td>
									<td onclick="goMemberDetail('${memberList.memberId}');">${memberList.email}</td>
									<td>${memberList.name}</td>
									<td>${memberList.grade}</td>
									<td></td>
									<td>${fn:substring(createDate,0,19)}</td>
									<td class="detail_cell" onclick="goMemberDetail('${memberList.memberId}');">
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
					<c:if test="${param.memberGrade != null and param.memberGrade ne ''}">
					    memberGrade=${param.memberGrade}&
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
					<my:adminPagination currentPage="${paging.pageno}" allPage="${paging.end_pg}"
							baseUrl="/admin/userConsumerList?${queryString}" />
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
	<script src="./js/users.js"></script>
	<!-- JS부분 end -->

</body>
</html>
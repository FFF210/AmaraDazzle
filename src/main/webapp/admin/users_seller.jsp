<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html>
<!-- 헤드부분 -->
<%@ include file="./common/config.jsp"%>

<title>Users 사업자회원</title>
<link rel="stylesheet" href="./css/user_seller.css" />
<!-- 헤드부분 -->

<body>

	<!-- 레이아웃 + 메인컨텐츠 -->
	<my:adminLayout>
		<!-- 메인부분 -->
		<div class="listTabs">
			<div class="listTab active">판매자 회원 (${sellerAllCnt})</div>
			<div class="listTab" onclick="goConsumerList()">일반회원 회원 (${memberAllCnt})</div>
		</div>

		<!-- ************************* 판매자 탭 ************************* -->
		<div class="main_content">
			<!-- 필터 -->
			<form id="sellerSearchForm" class="search_form">
				<my:adminTableFilter>
					<my:adminFilterPeriod title="가입일" />
					<my:adminFilterMiddle filters="게시 상태:ALL=전체|APPLY_SUBMITTED=승인대기|APPROVED=승인완료|SIGNUP_COMPLETED=가입완료" name="sellerStatus" />
					<my:adminFilterTotal searchItems="브랜드명,담당자명,아이디,사업자번호" />
				</my:adminTableFilter>
			</form>
			<!-- 필터 end -->
			
			<!-- 사업자회원 테이블 -->
			<div class="whole_table" style="display: ${searched eq 'searched' ? 'block' : 'none'};">
				<div class="table_title">
					<span class="list_count">
					<c:if test="${not empty searchContent}"> [ 검색 결과 ] </c:if> 
					&nbsp; 총 ${sellerCnt}건 중 
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
							<col style="width: 5%" />
							<col style="width: 5%" />
							<col style="width: 35%" />
							<col style="width: 10%" />
							<col style="width: 16%" />
							<col style="width: 8%" />
							<col style="width: 8%" />
							<col style="width: 8%" />
						</colgroup>
						<thead>
							<tr>
								<th><input type="checkbox" id="all_ck" onclick="ck_all(this.checked);" /></th>
								<th>#</th>
								<th>logo</th>
								<th class="sortable">브랜드명 <i class="bi bi-dash-lg sort-icon"></i></th>
								<th class="sortable">담당자명 <i class="bi bi-dash-lg sort-icon"></i></th>
								<th class="sortable">가입일 <i class="bi bi-dash-lg sort-icon"></i></th>
								<th class="sortable">구독여부 <i class="bi bi-dash-lg sort-icon"></i></th>
								<th class="sortable">승인여부 <i class="bi bi-dash-lg sort-icon"></i></th>
								<th>상세보기</th>
							</tr>
						</thead>
						<tbody>
							<!-- 게시물 개수가 0일 경우 -->
							<c:if test="${empty sellerList}">
								<tr>
									<td colspan="9">${message}</td>
								</tr>
							</c:if>

							<c:set var="no" value="${sellerCnt-postNo}" />
							<c:forEach items="${sellerList}" var="sellerList" varStatus="idx">
								<c:set var="createDate" value="${sellerList.createdAt}" />
								<tr>
									<td><input type="checkbox" class="ch_box" value="${sellerList.brandId}" onclick="choice_ck();" /></td>
									<td>${no-idx.index}</td>
									<td class="img_cell">
										<c:if test="${sellerList.logoFileId eq null}">
											<img src="../image/no-image.svg">
										</c:if> 
										<c:if test="${sellerList.logoFileId ne null}">
											<img src="${contextPath}/upload_file/${sellerList.fileRename}">
										</c:if>
									</td>
									<td class="title_cell"
										onclick="goSellerDetail('${sellerList.brandId}');">${sellerList.brandName}</td>
									<td>${sellerList.managerName}</td>
									<td>${fn:substring(createDate,0,19)}</td>
									<td></td>
									<td>
										<span onclick="changeState()"> 
										<c:choose>
											<c:when test="${sellerList.brandStatus == 'APPLY_SUBMITTED' }">
												<my:tag color="gray" size="md" text="승인대기" />
											</c:when>
											<c:when test="${sellerList.brandStatus == 'APPROVED'}">
												<my:tag color="blue" size="md" text="승인완료" />
											</c:when>
											<c:when test="${sellerList.brandStatus == 'SIGNUP_COMPLETED'}">
												<my:tag color="yellow" size="md" text="가입완료" />
											</c:when>
										</c:choose>
										</span>
									</td>
									<td class="detail_cell" onclick="goSellerDetail('${sellerList.brandId}');">
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
					<c:if test="${param.sellerStatus != null and param.sellerStatus ne ''}">
					    sellerStatus=${param.sellerStatus}&
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
							baseUrl="/admin/userSellerList?${queryString}" />
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
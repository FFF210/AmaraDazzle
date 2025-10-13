<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags"%>

<!DOCTYPE html>
<html>
<!-- 헤드부분 -->
<%@ include file="./common/config.jsp"%>

<title>발행쿠폰 리스트</title>
<style>
.part_content {
	display: flex;
	align-items: center;
}

.cp_info {
	margin-right: 5px;
}

#userSearchBtn {
	border: 1px solid var(--mainColor);
	border-radius: 3px;
	background: var(--mainColor);
	color: var(--base);
	margin-left: 3px;
	padding: 0 4px;
}

#userSearchBtn:active {
	border: 1px solid var(--clicked);
	background: var(--clicked);
}

#userList {
	border: 1px solid var(--outerbox);
	border-radius: 5px;
	width: 100%;
	height: auto;
	cursor: default;
}

#modalSearchBtn {
	border: 1px solid var(--mainColor);
	border-radius: 3px;
	background: transparent;
	color: var(--mainColor);
	margin-left: 3px;
	padding: 0 4px;
	width: 65px;
	aspect-ratio: 1/1;
}
</style>
<!-- 헤드부분 -->

<body>

	<!-- 레이아웃 + 메인컨텐츠 -->
	<my:adminLayout>
		<!-- 메인부분 -->
		<!-- 탭 -->
		<div class="listTabs">
			<div class="listTab active">발행 쿠폰 목록</div>
			<div class="listTab" onclick="goIndiCpList()">개별 지급 목록</div>
		</div>

		<!-- ************************* 발행 쿠폰 목록 탭 ************************* -->
		<section class="main_content">
			<!-- 필터 -->
			<form id="couponSearchForm" class="search_form">
				<my:adminTableFilter>
					<my:adminFilterPeriod title="발행일자" />
					<my:adminFilterPeriod title="유효기간" dateCate="exp_"
						presets="1주일,10일,1개월" />
					<my:adminFilterTotal searchItems="쿠폰명,사용조건" />
				</my:adminTableFilter>
			</form>
			<!-- 필터 end -->

			<!-- 테이블 -->
			<div class="whole_table">
				<div class="table_title">
					<span class="list_count"> <c:if
							test="${not empty searchContent}"> [ 검색 결과 ] </c:if> &nbsp; 총
						${pCouponCnt}건 중 <c:choose>
							<c:when test="${pCouponCnt == 0}">
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
					<!-- 버튼 -->
					<div>
						<button type="button" class="btn first_btn action_btn" onclick="cpPublBtn()">쿠폰발행</button>
						<button type="button" class="btn second_btn action_btn" id="openIndiBtn">개별지급</button>
					</div>
					<!-- 버튼 end -->
				</div>
				<div class="table_wrap">
					<table>
						<colgroup>
							<col style="width: 4%" />
							<!-- 체크박스 -->
							<col style="width: 5%" />
							<!-- 번호 -->
							<col style="width: 34%" />
							<!-- 쿠폰명 -->
							<col style="width: 8%" />
							<!-- 금액 -->
							<col style="width: 10%" />
							<!-- 지급대상 -->
							<col style="width: 10%" />
							<!-- 발행일 -->
							<col style="width: 15%" />
							<!-- 유효기간 -->
							<col style="width: 7%" />
							<!-- 발행주체 -->
							<col style="width: 7%" />
							<!-- 상세보기 -->
						</colgroup>
						<thead>
							<tr>
								<th><input type="radio" disabled /></th>
								<th>#</th>
								<th class="sortable">쿠폰명 <i class="bi bi-dash-lg sort-icon"></i></th>
								<th class="sortable">할인금액 <i class="bi bi-dash-lg sort-icon"></i></th>
								<th class="sortable">지급대상 <i class="bi bi-dash-lg sort-icon"></i></th>
								<th class="sortable">발행일 <i class="bi bi-dash-lg sort-icon"></i></th>
								<th>유효기간</th>
								<th class="sortable">발행주체 <i class="bi bi-dash-lg sort-icon"></i></th>
								<th>상세보기</th>
							</tr>
						</thead>
						<tbody>
							<!-- 게시물 개수가 0일 경우 -->
							<c:if test="${empty pCouponList}">
								<tr>
									<td colspan="8">등록된 게시물이 없습니다.</td>
								</tr>
							</c:if>

							<c:set var="no" value="${pCouponCnt-postNo}" />
							<c:forEach items="${pCouponList}" var="pCouponList" varStatus="idx">
								<c:set var="createDate" value="${pCouponList.createdAt}" />
								<c:set var="startDate" value="${pCouponList.startDate}" />
								<c:set var="endDate" value="${pCouponList.endDate}" />
								<tr>
									<td>
										<input type="radio" class="ch_radio" name="pCouponRdo" value="${pCouponList.couponId}"
											data-cname="${pCouponList.cname}" data-amount="${pCouponList.amount}" data-provision="${pCouponList.provision}"
											data-start="${fn:substring(startDate,0,10)}" data-end="${fn:substring(endDate,0,10)}" data-reason="${pCouponList.reason}"/>
									</td>
									<td>${no-idx.index}</td>
									<td onclick="goPcpDetail('${pCouponList.couponId}')">${pCouponList.cname}</td>
									<td class="price_cell"><fmt:formatNumber value="${pCouponList.amount}" pattern="#,###,###" /></td>
									<td>
									<c:choose>
										<c:when test="${pCouponList.provision eq 'ALL'}"><my:tag color="green" size="md" text="모든회원" /></c:when>
										<c:when test="${pCouponList.provision eq 'VIP'}"><my:tag color="red" size="md" text="VIP" /></c:when>
										<c:when test="${pCouponList.provision eq 'GOLD'}"><my:tag color="blue" size="md" text="GOLD" /></c:when>
										<c:when test="${pCouponList.provision eq 'SILVER'}"><my:tag color="yellow" size="md" text="SILVER" /></c:when>
										<c:when test="${pCouponList.provision eq 'NORMAL'}"><my:tag color="pink" size="md" text="일반" /></c:when>
										<c:otherwise><my:tag color="gray" size="md" text="개별회원" /></c:otherwise>
									</c:choose>
									
									</td>
									<td>${fn:substring(createDate,0,19)}</td>
									<td>${fn:substring(startDate,0,10)} ~ ${fn:substring(endDate,0,10)}</td>
									<td>${pCouponList.writerType eq 'ADMIN' ? 'Amara Dazzle' : 'BRAND_ADMIN' } </td>
									<td class="detail_cell" onclick="goPcpDetail('${pCouponList.couponId}');">
										<i class="bi bi-three-dots-vertical"></i>
									</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>

				<!-- 페이지네이션 -->
				<c:set var="queryString">
					<c:if test="${not empty param.startDate}">startDate=${param.startDate}&</c:if>
					<c:if test="${not empty param.endDate}">endDate=${param.endDate}&</c:if>
					<c:if test="${not empty param.startDate2}">startDate2=${param.startDate2}&</c:if>
					<c:if test="${not empty param.endDate2}">endDate2=${param.endDate2}&</c:if>
					<c:if test="${not empty param.totalSearch}">totalSearch=${param.totalSearch}&</c:if>
					<c:if test="${not empty param.keyword}">keyword=${param.keyword}&</c:if>
					page=
				</c:set>

				<div class="pagination_wrap page-pagination">
					<my:adminPagination currentPage="${paging.pageno}" allPage="${paging.end_pg}"
						baseUrl="/admin/couponPublList?${queryString}" />
				</div>
				<!-- 페이지네이션 end -->
			</div>
		</section>
		<my:submitDialog title="이대로 지급하시겠습니까?" msg="지급 처리 후 회수 불가합니다." />
		<!-- 메인부분 -->

	</my:adminLayout>
	<!-- ************ 레이아웃 + 메인컨텐츠 end ************ -->

	<!-- ************ 개별지급 모달 ************ -->
	<div id="indiCpModal" class="modal searchModal">
		<div class="modal-overlay"></div>
		<div class="modal-content">
			<h3 class="modal-title">쿠폰 지급</h3>
			<p class="modal-subTitle">
				기존 발행된 쿠폰을 지급합니다.<br>
			</p>
			<div class="modal-body">
				<!-- 폼 내용 -->
				<div class="form-row">
					<label class="form-row-label">지급할 쿠폰</label>
					<div class="part_content">
						<input type="text" class="text_readonly cp_info" id="modalCouponName" style="width: 100%;" readonly> 
						<input type="text" class="text_readonly cp_info" id="modalCouponAmount" style="width: 30%;" readonly> 원
						<input type="hidden" id="modalCouponId">
						<input type="hidden" id="modalCouponReason">
					</div>
				</div>
				<div class="form-row">
					<label class="form-row-label">유효기간 &nbsp;&nbsp;</label>
					<div class="filtering_content" style="width : 100%">
						<input type="text" id="modalCouponStart" name="cpStartDate" readonly />
						<span> - </span>
						<input type="text" id="modalCouponEnd" name="cpEndDate" readonly />
					</div>
				</div>
				
				<div class="form-row">
					<label class="form-row-label">지급대상 등급 &nbsp;&nbsp;</label>
					<div class="filtering_content" style="width : 100%">
						<input type="text" id="modalCouponProvision" readonly />
					</div>
				</div>
				
				<div class="form-row individual-only" style="display:none;">
					<label class="form-row-label">지급대상 <button type="button" id="userSearchBtn"><i class="bi bi-search"></i></button> </label>
					<div class="part_content"  style="width : 100%">
						<textarea id="userList" readonly></textarea>
					</div>
				</div>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn second_btn btn-md" data-action="취소">취소</button>
				<button type="button" class="btn first_btn btn-md" id="cpSubmitBtn" data-action="전송">지급</button>
			</div>
		</div>
	</div>

	<!-- ************ 개별지급 회원검색 모달 ************ -->
	<div id="userSearchModal" class="modal searchModal">
		<div class="modal-overlay"></div>
		<div class="modal-content">
			<h3 class="modal-title">회원 검색</h3>
			<p class="modal-subTitle">
				쿠폰을 지급받을 회원을 검색합니다.<br>
			</p>
			<div class="modal-body">
				<!-- 폼 내용 -->
				<div class="form-row">
					<div class="part_content">
						<my:selectbox size="md" items="회원명,아이디,생년월일" initial="검색 조건" id="modalSearchCondition" />
						<input type="hidden" name="modalSearchCondition" id="hiddenSearchCondition">
						<input type="text" class="text_readonly cp_info" id="modalSearchKeyword" style="width: 100%;">
						<button id="modalSearchBtn"> <i class="bi bi-search"></i> </button>
					</div>
					<div class="modal_table hidden">
						<div class="table_title">
							<span class="list_count">[ 검색 결과 ]</span>
						</div>
					
						<div class="table_wrap">
							<table>
								<thead>
									<tr>
										<th><input type="checkbox" /></th>
										<th>#</th>
										<th>아이디</th>
										<th>회원명</th>
										<th>등급</th>
										<th>생년월일</th>
									</tr>
								</thead>
								<tbody>
								</tbody>
							</table>
						</div>
					</div>
				</div>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn second_btn btn-md" data-action="취소">취소</button>
				<button type="button" class="btn first_btn btn-md" data-action="저장">저장</button>
			</div>
		</div>
	</div>

	<!-- JS부분 -->
	<script src="../tagjs/selectbox.js"></script>
	<script src="../tagjs/dateInput.js"></script>
	<script src="./js/common/modal.js"></script>
	<script src="./js/common/table.js"></script>
	<script src="./js/couponPList.js"></script>

	<script>
/*********************************************************************************************************
	* 프리셋 버튼 이벤트
*********************************************************************************************************/
	document.querySelectorAll(".date-input .preset-btn").forEach(btn => {
		btn.addEventListener("click", () => {
			const parent = btn.closest(".date-input");

			parent.querySelectorAll(".preset-btn").forEach(b => b.classList.remove("active"));
			btn.classList.add("active");

			// 오늘 날짜 기준 계산
			const toDateStr = d => d.toISOString().split("T")[0];

			const filterBox = btn.closest(".filter_box");
			if (!filterBox) return;

			const startInput = filterBox.querySelector(".start_date");
			const endInput = filterBox.querySelector(".end_date");
			if (!startInput || !endInput) return;

			switch (btn.textContent.trim()) {
				case "1주일":
					const oneWeek = new Date(local.getTime() + 6 * 24 * 60 * 60 * 1000);
					startInput.value = toDateStr(local);
					endInput.value = toDateStr(oneWeek);
					break;
				case "10일":
					const tenDays = new Date(local.getTime() + 9 * 24 * 60 * 60 * 1000);
					startInput.value = toDateStr(local);
					endInput.value = toDateStr(tenDays);
					break;
				case "1개월":
					const oneMonth = new Date(local.getTime() + 30 * 24 * 60 * 60 * 1000);
					startInput.value = toDateStr(local);
					endInput.value = toDateStr(oneMonth);
					break;
			}

			// 부모 페이지로 이벤트 전달
			const event = new CustomEvent("datePresetSelected", {
				detail: { value: btn.textContent.trim(), date: toDateStr(local) }
			});
			document.dispatchEvent(event);
		});
	});
	</script>
</body>
</html>
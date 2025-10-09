<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags"%>

<!DOCTYPE html>
<html>
<!-- 헤드부분 -->
<%@ include file="./common/config.jsp"%>

<title>쿠폰 지급</title>
<link rel="stylesheet" href="./css/boards_write.css" />
<link rel="stylesheet" href="./css/coupon.css" />

<!-- 헤드부분 -->

<body>
	<!-- 레이아웃 + 메인컨텐츠 -->
	<my:adminLayout>
	<form id="iCouponForm">
		<!-- *********************************메인부분********************************* -->
		<section class="board_write">
			<div class="part_section name_part">
				<div class="part_title">쿠폰명 <span class="reqired_write">*</span></div>
				<div class="part_content">
					<div class="content_btn">
						<button type="button" class="btn action_btn second_btn search_btn"
							id="cName_searchBtn">검색</button>
					</div>
					<input type="text" name="couponName" placeholder="쿠폰명을 입력하세요" style="width: 100%;"/> 
					<input type="text" name="couponAmount" placeholder="쿠폰금액" class="price_input"> &nbsp;&nbsp;원
				</div>
			</div>

			<div class="part_section period_part">
				<div class="part_title">유효기간 <span class="reqired_write">*</span></div>
				<div class="part_content couponExp">
					<div class="filter_box"> 
						<my:dateInput type="input" name="startDate" />
						<span> - </span>
						<my:dateInput type="input" name="endDate" inputDay="end"/>
						<my:dateInput type="preset" presets="1주일,10일,1개월" />
					</div>
					<span class="no_condition">
						<label><input type="checkbox" id="exp_noRestr" name="exp_noRestr"/> 제한 없음</label>
					</span>
				</div>
			</div>

			<div class="part_section">
				<div class="part_title">카테고리 <span class="reqired_write">*</span></div>
				<div class="part_content select_cate">
					<my:selectbox size="sm" items="대분류" initial="대분류" name="largeCate" id="largeSelect"/>
					<input type="hidden" name="category1Id" id="category1Id" />
					<my:selectbox size="sm" items="중분류" initial="중분류" name="middleCate" id="middleSelect"/>
					<input type="hidden" name="category2Id" id="category2Id" />
					<my:selectbox size="sm" items="소분류" initial="소분류" name="smallCate" id="smallSelect" />
					<input type="hidden" name="category3Id" id="category3Id" />
					<span>&nbsp;&nbsp;구매시 사용가능&nbsp;&nbsp;</span>
					<span class="no_condition">
						<label><input type="checkbox" id="cate_noRestr" name="cate_noRestr"/> 제한 없음</label>
					</span>
				</div>
			</div>

			<div class="part_section condition_part">
				<div class="part_title">사용조건 <span class="reqired_write">*</span></div>
				<div class="part_content">
					<input type="text" name="couponCondition" id="couponCondition" placeholder="사용조건" class="price_input" /> 
					<span>&nbsp;&nbsp;원 이상 구매시 사용가능&nbsp;&nbsp;&nbsp;&nbsp;</span>
					<span class="no_condition">
						<label><input type="checkbox" id="pch_noRestr" name="pch_noRestr"/> 제한 없음</label>
					</span>
				</div>
			</div>
			
			<div class="part_section target_part name_part">
				<div class="part_title"> 지급대상 <span class="reqired_write">*</span></div>
				<div class="part_content">
					<input type="text" name="memberId" placeholder="회원아이디" style="width: 70%;"/> 
					<button type="button" class="btn action_btn second_btn search_btn" id="user_searchBtn">검색</button>
				</div>
			</div>

			<div class="part_section reason_part">
				<div class="part_title">지급사유 <span class="reqired_write">*</span></div>
				<div class="part_content">
					<input type="text" name="couponReason" placeholder="쿠폰 발행 사유를 입력하세요" style="width: 100%;" />
				</div>
			</div>


			<div class="part_section bottom_part">
				<div class="part_title">작성자 <span class="reqired_write">*</span></div>
				<div class="part_content">
					<div class="writer_part">
						<input type="text" class="text_readonly" value="${aname}" readonly />
						<input type="hidden" name="cpWriter" value="${sessionScope.aidx}">
					</div>
					<div class="btn_part">
						<button type="button" class="btn first_btn action_btn" id="iCouponBtn">등록</button>
					</div>
				</div>
			</div>
		</section>
		</form>
		<my:submitDialog title="모든 입력 내용을 확인하였습니까?" msg="입력한 내용대로 반영됩니다." />
		
		<!-- *********************************메인부분 end********************************* -->
	</my:adminLayout>
	<!-- 레이아웃 + 메인컨텐츠 end -->

	<!-- ************ 쿠폰명 검색 모달 ************ -->
	<div id="cpNameModal" class="modal searchModal">
		<div class="modal-overlay"></div>
		<div class="modal-content">
			<h3 class="modal-title">쿠폰 검색</h3>
			<p class="modal-subTitle">
				기존 발행된 쿠폰을 검색합니다.<br>또는 직접 입력합니다.
			</p>
			<div class="modal-body">
				<!-- 폼 내용 -->
				<div class="form-row">
					<label class="form-row-label">쿠폰 선택</label>
					<my:selectbox size="lg" id="cpList" items="${currentCpList}"
						initial="발행 쿠폰 목록" />
				</div>
				<div class="form-row no_condition">
					<label><input type="checkbox" id="" name=""/> 직접 입력</label>
				</div>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn second_btn btn-md" data-action="취소">취소</button>
				<button type="button" class="btn first_btn btn-md" data-action="저장">저장</button>
			</div>
		</div>
	</div>
	
	<!-- ************ 회원 검색 모달 ************ -->
	<div id="userModal" class="modal searchModal">
		<div class="modal-overlay"></div>
		<div class="modal-content">
			<h3 class="modal-title">쿠폰 발급 대상 선택</h3>
			<p class="modal-subTitle">
				쿠폰을 발행할 회원 그룹을 선택하세요.<br>또는 직접 입력 합니다.
			</p>
			<div class="modal-body">
				<!-- 폼 내용 -->
				<div class="form-row">
					<label><input type="checkbox" /> 모든 회원</label>
					<my:adminFilterMiddle name="cp_target"
						filters="지급 대상 :ALL=전체|VIP=VIP|GOLD=GOLD|SILVER=SILVER|일반=일반" />
				</div>
				<div class="form-row">
					<label class="form-row-label">직접 검색</label>
					<div class="searchKeyword">
						&nbsp;<i class="bi bi-search"></i> <input type="text"
							placeholder="키워드 입력 후 엔터" value="${searchContent.keyword}"
							name="keyword" class="search-input" />
					</div>
					<div class="searchTable modalTable">
						<div class="table_title">
							<span class="list_count"> <c:if
									test="${not empty searchContent}">
						[ 검색 결과 ]
						</c:if> &nbsp; 총 ${noticeCnt}건 중 <c:choose>
									<c:when test="${noticeCnt == 0}">
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
						<div class="">
							<table>
								<colgroup>
									<col style="width: 6%" />
									<!-- 체크박스 -->
									<col style="width: 7%" />
									<!-- 번호 -->
									<col style="width: 10%" />
									<!-- 회원명 -->
									<col style="width: 30%" />
									<!-- 회원아이디 -->
									<col style="width: 9%" />
									<!-- 등급 -->
								</colgroup>
								<thead>
									<tr>
										<th><input type="checkbox" id="all_ck"
											onclick="ck_all(this.checked);" /></th>
										<th>#</th>
										<th>회원명</th>
										<th>회원아이디</th>
										<th>등급</th>
									</tr>
								</thead>
								<tbody>
									<!-- 게시물 개수가 0일 경우 -->
									<c:if test="${empty noticeList}">
										<tr>
											<td colspan="5">등록된 게시물이 없습니다.</td>
										</tr>
									</c:if>

									<c:set var="no" value="${noticeCnt-postNo}" />
									<c:forEach items="${noticeList}" var="noticeList"
										varStatus="idx">
										<tr>
											<td><input type="checkbox" class="ch_box"
												value="${noticeList.noticeId}" onclick="choice_ck();" /></td>
											<td>${no-idx.index}</td>
											<td></td>
											<td></td>
											<td></td>
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
								baseUrl="/admin/noticeSellerList?${queryString}" />
						</div>
						<!-- 페이지네이션 end -->

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
	<script src="./js/common/toast.js"></script>
	<script src="./js/common/table.js"></script>
	<script src="./js/common/category.js"></script>
	<script src="./js/couponI.js"></script>

	<script>
/*********************************************************************************************************
	* 모달 Ajax
*********************************************************************************************************/
	const sendAjax = (data) => {
		return fetch("/brand/productList", {
			method: "POST",
			headers: { "Content-Type": "application/x-www-form-urlencoded" },
			body: new URLSearchParams(data)
		}).then(res => res.json());
	};

	const dialogHandlers = {
		cpNameModal: {
			저장: async () => {
				const dialog = document.getElementById("cpNameModal");
				const discountType = dialog.querySelector("input[name='discountType']:checked")?.value;
				const discountValue = dialog.querySelector("input[name='discountValue']").value;
				const startDate = dialog.querySelector("input[name='startDate']").value;
				const endDate = dialog.querySelector("input[name='endDate']").value;


				const result = await sendAjax({
					action: "sale",
					discountType, discountValue, startDate, endDate,
					productIds: selectedProducts
				});

				if (result.result === "success") {
					localStorage.setItem("toast", JSON.stringify({
						type: "success",
						message: "세일이 등록되었습니다."
					}));
					location.reload();
				} else {
					showToast("error", result.message || "세일 등록 실패");
				}
			}
		},
		userModal: {
			저장: async () => {
				const dialog = document.getElementById("userModal");
				const productId = dialog.dataset.productId;
				const newStock = dialog.querySelector("input[name='newStock']").value;

				const result = await sendAjax({ action: "stock", productId, newStock });

				if (result.result === "success") {
					localStorage.setItem("toast", JSON.stringify({
						type: "success",
						message: "재고가 변경되었습니다."
					}));
					location.reload();
				} else {
					showToast("error", result.message || "재고 변경 실패", "실패");
				}
			}
		}
	};

/*********************************************************************************************************
	* 모달 오픈
*********************************************************************************************************/
	//공통 이벤트 연결
	document.addEventListener("dialogAction", (e) => {
		const { id, action } = e.detail;
		dialogHandlers[id]?.[action]?.();
	});

	// 버튼 이벤트: 모달 열기
	// 쿠폰명 검색 버튼 
	document.getElementById("cName_searchBtn").addEventListener("click", () => openDialog("cpNameModal"));
	
	//회원 검색 버튼 
	document.getElementById("user_searchBtn").addEventListener("click", () => openDialog("userModal"));

/*********************************************************************************************************
	* 날짜 자동세팅
*********************************************************************************************************/	
	document.addEventListener("DOMContentLoaded", () => {
		// --- 프리셋 버튼 이벤트 ---
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
						const oneWeek = new Date(local.getTime() + 7 * 24 * 60 * 60 * 1000);
						startInput.value = toDateStr(local);
						endInput.value = toDateStr(oneWeek);
						break;
					case "1개월":
						const oneMonth = new Date(local.getTime() + 30 * 24 * 60 * 60 * 1000);
						startInput.value = toDateStr(local);
						endInput.value = toDateStr(oneMonth);
						break;
					case "1년":
						const oneYear = new Date(local.getTime() + 365 * 24 * 60 * 60 * 1000);
						startInput.value = toDateStr(local);
						endInput.value = toDateStr(oneYear);
						break;
				}

				// 부모 페이지로 이벤트 전달
				const event = new CustomEvent("datePresetSelected", {
					detail: { value: btn.textContent.trim(), date: toDateStr(local) }
				});
				document.dispatchEvent(event);
			});
		});
	});
	</script>
	<!-- JS부분 end -->

</body>
</html>
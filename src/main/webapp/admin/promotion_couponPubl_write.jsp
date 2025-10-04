<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags"%>

<!DOCTYPE html>
<html>
<!-- 헤드부분 -->
<%@ include file="./common/config.jsp"%>

<title>쿠폰 생성</title>
<link rel="stylesheet" href="./css/boards_write.css" />
<link rel="stylesheet" href="./css/myApplications.css" />
<link rel="stylesheet" href="./css/coupon.css" />
<!-- 헤드부분 -->

<body>

	<!-- 레이아웃 + 메인컨텐츠 -->
	<my:adminLayout>
		<!-- *********************************메인부분********************************* -->
		<form id="pCouponForm">
			<section class="board_write">
				<div class="part_section name_part">
					<div class="part_title">
						쿠폰명 <span class="reqired_write">*</span>
					</div>
					<div class="part_content ">
						<input type="text" name="couponName" placeholder="쿠폰명을 입력하세요" style="width: 100%;"/> 
						<input type="text" name="couponAmount" placeholder="쿠폰금액" class="price_input"> &nbsp;&nbsp;원
					</div>
				</div>

<!-- 				<div class="part_section period_part"> -->
<!-- 					<div class="part_title">유효기간 <span class="reqired_write">*</span></div> -->
<!-- 					<div class="part_content couponExp"> -->
<!-- 						<label for="couponExp">발급일로부터</label>&nbsp;&nbsp;&nbsp;  -->
<!-- 						<input type="text" name="couponExp" class="price_input" /> -->
<%-- 						<my:selectbox size="md" items="일,개월,년" name="expUnit"/> --%>
<!-- 						<input type="hidden" name="expUnit" value="일"> -->
<!-- 					</div> -->
<!-- 				</div> -->
				
				<div class="part_section period_part">
					<div class="part_title">유효기간 <span class="reqired_write">*</span></div>
					<div class="part_content couponExp">
						<div class="filter_box"> 
							<my:dateInput type="input" name="startDate" />
							<span> - </span>
							<my:dateInput type="input" name="endDate" inputDay="end"/>
							<my:dateInput type="preset" presets="1주일,10일,1개월" />
						</div>
					</div>
				</div>

				<div class="part_section">
					<div class="part_title">카테고리 <span class="reqired_write"></span></div>
					<div class="part_content select_cate">
						<my:selectbox size="sm" items="대분류" initial="대분류" name="largeCate" id="largeSelect"/>
						<my:selectbox size="sm" items="중분류" initial="중분류" name="middleCate" id="middleSelect"/>
						<my:selectbox size="sm" items="소분류" initial="소분류" name="smallCate" id="smallSelect" />
						<input type="hidden" name="category1Id" id="category1Id" />
						<input type="hidden" name="category2Id" id="category2Id" />
						<input type="hidden" name="category3Id" id="category3Id" />
						<span>&nbsp;&nbsp;구매시 사용가능&nbsp;&nbsp;&nbsp;&nbsp;</span>
					</div>
				</div>

				<div class="part_section condition_part">
					<div class="part_title">사용조건 <span class="reqired_write">*</span></div>
					<div class="part_content">
						<input type="text" name="couponCondition" id="couponCondition" placeholder="사용조건" class="price_input" /> 
						<span>&nbsp;&nbsp;원 이상 구매시 사용가능&nbsp;&nbsp;&nbsp;&nbsp;</span>
						<div class="no_condition">
							<label><input type="checkbox" id="pch_noRestr" /> 제한 없음</label>
						</div>
					</div>
				</div>

				<div class="part_section target_part">
					<div class="part_title">지급대상 <span class="reqired_write">*</span></div>
					<div class="part_content">
						<div class="answer_body filter-btn-group">
							<input type="button" class="filter-btn" value="ALL"> 
							<input type="button" class="filter-btn" value="VIP"> 
							<input type="button" class="filter-btn" value="GOLD"> 
							<input type="button" class="filter-btn" value="SILVER"> 
							<input type="button" class="filter-btn" value="REGULAR ">
							<input type="hidden" id="cpTarget" name="cpTarget" >
						</div>
					</div>
				</div>

				<div class="part_section reason_part">
					<div class="part_title">지급사유 <span class="reqired_write">*</span></div>
					<div class="part_content">
						<input type="text" name="couponReason" placeholder="쿠폰 발행 사유를 입력하세요" style="width: 100%;" />
					</div>
				</div>

				<div class="part_section amount_part">
					<div class="part_title">발급 수량 <span class="reqired_write">*</span></div>
					<div class="part_content">
						<input type="text" name="couponQuantity" id="couponQuantity" placeholder="쿠폰 최대 발급 수량 입력" /> 
						<span>&nbsp;매 한정&nbsp;&nbsp;&nbsp;&nbsp;</span>
						<div class="no_condition">
							<label><input type="checkbox" id="qnt_noRestr" name="qnt_noRestr"/> 제한 없음</label>
						</div>
					</div>
				</div>

<!-- 				<div class="part_section dupl_part"> -->
<!-- 					<div class="part_title">중복 지급 여부 <span class="reqired_write">*</span></div> -->
<!-- 					<div class="part_content"> -->
<!-- 						<label><input type="checkbox" name="noDupl" /> 중복 지급 불가</label>&nbsp;&nbsp;&nbsp;   -->
<!-- 						<span style="color : gray"><small><i class="bi bi-exclamation-octagon"></i> 체크시 한 ID당 중복 발급 불가합니다.</small></span> -->
<!-- 					</div> -->
<!-- 				</div> -->

				<div class="part_section bottom_part">
					<div class="part_title">작성자 <span class="reqired_write">*</span></div>
					<div class="part_content">
						<div class="writer_part">
							<input type="text" class="text_readonly" value="${aname}" readonly />
							<input type="hidden" name="cpWriter" value="${sessionScope.aidx}">
						</div>
						<div class="btn_part">
							<button type="button" class="btn first_btn action_btn" id="pCouponBtn">등록</button>
						</div>
					</div>
				</div>
			</section>
		</form>
		<my:submitDialog title="모든 입력 내용을 확인하였습니까?" msg="입력한 내용대로 반영됩니다." />

		<!-- *********************************메인부분 end********************************* -->
	</my:adminLayout>
	<!-- 레이아웃 + 메인컨텐츠 end -->
	
	
	<!--  JS script 부분  -->
	<script src="../tagjs/selectbox.js"></script>
	<script src="../tagjs/dateInput.js"></script>
	<script src="./js/common/modal.js"></script>
	<script src="./js/common/category.js"></script>
	<script src="./js/couponP.js"></script>

	<script>
	//커스텀select 선택시 hidden Input에 값 넣기 
	document.querySelectorAll(".custom-select").forEach(select => {
		const label = select.querySelector(".select-label");
		const items = select.querySelectorAll(".select-item");
		const hidden = select.parentElement.querySelector("input[type='hidden'][name]");

		// 페이지 로드 시 hidden 값 반영
		if (hidden && hidden.value) {
			const matched = Array.from(items).find(li => li.dataset.value === hidden.value);
			if (matched) {
				label.textContent = matched.dataset.value;
				items.forEach(li => li.classList.remove("active"));
				matched.classList.add("active");
			}
		}

		// 클릭 이벤트 시 hidden 갱신
		items.forEach(item => {
			item.addEventListener("click", () => {
				const value = item.dataset.value;
				label.textContent = value;
				items.forEach(li => li.classList.remove("active"));
				item.classList.add("active");
				if (hidden) hidden.value = value;
			});
		});
	});
	
	
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
	<!--  JS script 부분 end  -->

</body>
</html>
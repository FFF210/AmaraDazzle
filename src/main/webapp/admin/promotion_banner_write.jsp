<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags"%>

<!DOCTYPE html>
<html>
<!-- 헤드부분 -->
<%@ include file="./common/config.jsp"%>

<title>ADMIN - 메인배너 등록</title>
<link rel="stylesheet" href="../tagcss/uploader.css" />
<link rel="stylesheet" href="./css/boards_write.css" />
<link rel="stylesheet" href="./css/banner.css" />
<style>
	.uploader {padding: 5px;}
	.uploader-md { width: 98%; }
</style>
<!-- 헤드부분 -->

<body>

	<!-- 레이아웃 + 메인컨텐츠 -->
	<my:adminLayout>
		<!-- *********************************메인부분********************************* -->
		<form id="bannerWriteForm" enctype="multipart/form-data">
		<section class="board_write">
			<div class="part_section title_part">
				<div class="part_title">제목 <span class="reqired_write">*</span></div>
				<div class="part_content">
					<input type="text" name="bannerName" placeholder="배너명을 입력하세요" style="width: 100%;" />
				</div>
			</div>

			<div class="part_section period_part">
				<div class="part_title">진행기간 <span class="reqired_write">*</span></div>
				<div class="part_content">
					<div class="filter_box"> 
						<my:dateInput type="input" name="startDate" />
						<span> - </span>
						<my:dateInput type="input" name="endDate" inputDay="end"/>
						<my:dateInput type="preset" presets="1주일,1개월,3개월" />
					</div>
				</div>
			</div>

<!-- 			<div class="part_section pCate_part"> -->
<!-- 				<div class="part_title">상품 카테고리</div> -->
<!-- 				<div class="part_content select_cate"> -->
<%-- 					<my:selectbox size="md" items="대분류" initial="대분류" name="largeCate" id="largeSelect"/> --%>
<%-- 					<my:selectbox size="md" items="중분류" initial="중분류" name="middleCate" id="middleSelect"/> --%>
<%-- 					<my:selectbox size="md" items="소분류" initial="소분류" name="smallCate" id="smallSelect" /> --%>
<!-- 					<input type="hidden" name="category1Id" id="category1Id" /> -->
<!-- 					<input type="hidden" name="category2Id" id="category2Id" /> -->
<!-- 					<input type="hidden" name="category3Id" id="category3Id" /> -->
<!-- 				</div> -->
<!-- 			</div> -->

			<div class="part_section thumb_part">
				<div class="part_title">배너이미지 <span class="reqired_write">*</span></div>
				<div class="part_content">
					<my:uploader size="md" name="bannerThumb" label="Click to upload" desc="또는 파일을 이 영역으로 드래그하세요" />
				</div>
			</div>

			<div class="part_section content_part">
				<div class="part_title">LINK <span class="reqired_write">*</span></div>
				<div class="part_content">
					<input type="text" name="bannerLink" placeholder="연결할 페이지의 URL을 입력하세요" style="width: 100%;" />
				</div>
			</div>

			<div class="part_section bottom_part">
				<div class="part_title">작성자 <span class="reqired_write">*</span></div>
				<div class="part_content">
					<div class="writer_part">
						<input type="text" class="text_readonly" value="${aname}" readonly />
						<input type="hidden" name="bnWriter" value="${aidx}">
					</div>
					<div class="btn_part">
						<!-- <button type="button" class="btn second_btn action_btn">미리보기</button> -->
						<button type="button" class="btn first_btn action_btn" id="bannerWriteBtn">등록</button>
					</div>
				</div>
			</div>
		</section>
		</form>
		<my:submitDialog title="모든 입력 내용을 확인하였습니까?" msg="입력한 내용대로 반영됩니다." />
		<!-- *********************************메인부분 end********************************* -->
	</my:adminLayout>
	<!-- 레이아웃 + 메인컨텐츠 end -->




	<!-- JS부분 -->
	<script src="../tagjs/selectbox.js"></script>
	<script src="../tagjs/dateInput.js"></script>
	<script src="./js/common/modal.js"></script>
	<script src="./js/banner.js"></script>
	<script>
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
				case "1개월":
					const oneMonth = new Date(local.getTime() + 30 * 24 * 60 * 60 * 1000);
					startInput.value = toDateStr(local);
					endInput.value = toDateStr(oneMonth);
					break;
				case "3개월":
					const threeMonth = new Date(local.getTime() + 90 * 24 * 60 * 60 * 1000);
					startInput.value = toDateStr(local);
					endInput.value = toDateStr(threeMonth);
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
	<!-- JS부분 end -->

</body>
</html>
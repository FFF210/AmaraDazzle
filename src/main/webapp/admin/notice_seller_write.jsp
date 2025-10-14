<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags"%>

<!DOCTYPE html>
<html>
<!-- 헤드부분 -->
<%@ include file="./common/config.jsp"%>
<title>공지 작성</title>

<link rel="stylesheet" href="../tagcss/uploader.css" />
<link rel="stylesheet" href="./css/boards_write.css" />

<!-- toast editor CDN -->
<link rel="stylesheet" href="https://uicdn.toast.com/editor/latest/toastui-editor.min.css" />
<script src="https://uicdn.toast.com/editor/latest/toastui-editor-all.min.js"></script>

<style>
	.uploader {padding: 5px;}
	.uploader-md { width: 98%; }
</style>
<!-- 헤드부분 -->

<body>

	<!-- 레이아웃 + 메인컨텐츠 -->
	<my:adminLayout>
		<!-- *********************************메인부분********************************* -->
		<form id="noticeForm" enctype="multipart/form-data">
			<section class="board_write">

				<input type="hidden" id="noticeTargetType" name="noticeTargetType" value="5" />

				<div class="part_section cate_part">
					<div class="part_title"> 카테고리 <span class="reqired_write">*</span> </div>
					<div class="part_content">
						<my:selectbox size="md" items="시스템,이벤트,기타" initial="공지 카테고리를 선택하세요" id="noticeCate" />
						<input type="hidden" name="noticeCate" />
					</div>
				</div>

				<div class="part_section title_part">
					<div class="part_title">제목 <span class="reqired_write">*</span></div>
					<div class="part_content">
						<input type="text" id="noticeTitle" name="noticeTitle" placeholder="제목을 입력하세요 (최대 150자까지 입력가능)" maxlength="150" style="width: 100%;" />
					</div>
				</div>

				<div class="part_section">
					<div class="part_title">첨부파일</div>
					<div class="part_content">
						<my:uploader size="md" name="noticeFile" multiple="multiple" />
					</div>
				</div>

				<div class="part_section content_part">
					<div class="part_title">내용 <span class="reqired_write">*</span></div>
					<div class="part_content">
						<!-- toast editor 삽입 -->
						<div id="editContent"></div>
					</div>
				</div>

				<div class="part_section bottom_part">
					<div class="part_title">
						작성자 <span class="reqired_write">*</span>
					</div>
					<div class="part_content">
						<div class="writer_part">
							<input type="text" class="text_readonly" value="${aname}"  readonly />
							<input type="hidden" id="noticeWriter" name="noticeWriter" value="${aidx}">
						</div>
						<div class="btn_part">
							<button type="button" class="btn second_btn action_btn" id="previewBtn">미리보기</button>
							<button type="button" class="btn first_btn action_btn" id="writeBtn">등록</button>
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
	<script src="./js/common/modal.js"></script>
	<script src="./js/notice.js"></script>
	
	<script>
	//select 공지카테고리 선택 후 hidden input 에 value 매핑
	document.querySelectorAll(".custom-select").forEach(select => {
		const items = select.querySelectorAll(".select-item");
		const hidden = select.parentElement.querySelector("input[type='hidden'][name]");
		console.log(items)
		console.log(hidden)
		// 클릭 이벤트 시 hidden 갱신
		items.forEach(item => {
			item.addEventListener("click", () => {
				const value = item.dataset.value;
				if (hidden) hidden.value = value;
			});
		});
	});
	
	</script>
	<!-- JS부분 end -->

</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags"%>
<style>
	.uploader {padding: 5px;}
	.uploader-md { width: 95%; }
</style>



<!-- *********************************메인부분********************************* -->
<section class="board_write">
	<div class="part_section cate_part">
		<div class="part_title">
			카테고리 <span class="reqired_write">*</span>
		</div>
		<div class="part_content">
			<select class="cate_sb" id="noticeCate">
				<option value="">공지 카테고리를 선택하세요</option>
				<option value="SYSTEM">시스템</option>
				<option value="EVENT">이벤트</option>
				<option value="ETC">기타</option>
			</select>
		</div>
	</div>

	<div class="part_section title_part">
		<div class="part_title">
			제목 <span class="reqired_write">*</span>
		</div>
		<div class="part_content">
			<input type="text" id="noticeTitle" placeholder="제목을 입력하세요"/>
		</div>
	</div>

	<div class="part_section">
		<div class="part_title">첨부파일</div>
		<div class="part_content">
			<my:uploader size="md" id="fileAttach" 
					label="Click to upload" desc="또는 파일을 이 영역으로 드래그하세요" />
		</div>
	</div>

	<div class="part_section content_part">
		<div class="part_title">
			내용 <span class="reqired_write">*</span>
		</div>
		<div class="part_content">
			<div id="editContent"></div>
		</div>
	</div>

	<div class="part_section bottom_part">
		<div class="part_title">
			작성자 <span class="reqired_write">*</span>
		</div>
		<div class="part_content">
			<div class="writer_part">
				<input type="text" class="text_readonly" id="noticeWriter" readonly />
			</div>
			<div class="btn_part">
				<button type="button" class="btn second_btn action_btn" id="previewBtn">미리보기</button>
				<button type="button" class="btn first_btn action_btn" id="writeBtn">등록</button>
			</div>
		</div>
	</div>
</section>
<!-- *********************************메인부분 end********************************* -->


<!-- JS부분 -->
<script>
const editor = new toastui.Editor({
	el : document.querySelector('#editContent'), 
	height : '500px', 
	initialEditType : 'wysiwyg', 
});
</script>

<script src="./js/boardNotice.js"></script>


<!-- JS부분 end -->

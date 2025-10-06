<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags"%>

<!-- *********************************메인부분********************************* -->
<section class="board_write">
	<div class="part_section cate_part">
		<div class="part_title">
			카테고리 <span class="reqired_write">*</span>
		</div>
		<div class="part_content">
			<select class="cate_sb">
				<option>공지 카테고리를 선택하세요</option>
				<option>카테1</option>
				<option>카테2</option>
				<option>카테3</option>
			</select>
		</div>
	</div>

	<div class="part_section title_part">
		<div class="part_title">
			제목 <span class="reqired_write">*</span>
		</div>
		<div class="part_content">
			<input type="text" />
		</div>
	</div>

	<div class="part_section">
		<div class="part_title">첨부파일</div>
		<div class="part_content">컴포넌트 있으면 삽입</div>
	</div>

	<div class="part_section content_part">
		<div class="part_title">
			내용 <span class="reqired_write">*</span>
		</div>
		<div class="part_content">
			<textarea>토스트에디터삽입</textarea>
		</div>
	</div>

	<div class="part_section bottom_part">
		<div class="part_title">
			작성자 <span class="reqired_write">*</span>
		</div>
		<div class="part_content">
			<div class="writer_part">
				<input type="text" class="text_readonly" value="로그인된 관리자 이름"
					readonly />
			</div>
			<div class="btn_part">
				<button type="button" class="btn second_btn action_btn">미리보기</button>
				<button type="button" class="btn first_btn action_btn">등록</button>
			</div>
		</div>
	</div>
</section>
<!-- *********************************메인부분 end********************************* -->
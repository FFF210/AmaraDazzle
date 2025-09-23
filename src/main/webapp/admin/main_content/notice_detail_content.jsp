<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags"%>

<!-- *********************************메인부분********************************* -->
<section class="board_detailview">
	<div class="part_section">
		<div class="part_title">글번호</div>
		<div class="part_content">45</div>
	</div>

	<div class="part_section cate_part">
		<div class="part_title">카테고리</div>
		<div class="part_content">[zkxprhfl]</div>
	</div>

	<div class="part_section title_part">
		<div class="part_title">제목</div>
		<div class="part_content">
			<input type="text" class="text_readonly" value="글제목" readonly />
		</div>
	</div>

	<div class="part_section">
		<div class="part_title">첨부파일</div>
		<div class="part_content">첨부파일명</div>
	</div>

	<div class="part_section">
		<div class="part_title">내용</div>
		<div class="part_content">
			<div class="content_part">
				공지 내용 <br /> 공지 내용 <br />
			</div>
		</div>
	</div>

	<div class="part_section bottom_part">
		<div class="part_title">작성자</div>
		<div class="part_content">
			<div class="writer_part">
				<input type="text" class="text_readonly" value="로그인된 관리자 이름"
					readonly />
			</div>
			<div class="btn_part">
				<button type="button" class="btn first_btn action_btn">수정</button>
				<button type="button" class="btn second_btn action_btn">삭제</button>
			</div>
		</div>
	</div>
</section>
<!-- *********************************메인부분 end********************************* -->
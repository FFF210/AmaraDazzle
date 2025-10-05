<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags"%>

<!-- *********************************메인부분********************************* -->
<section class="board_write">
	<div class="part_section cate_part">
		<div class="part_title">
			이벤트 종류 <span class="reqired_write">*</span>
		</div>
		<div class="part_content">
			<select class="cate_sb">
				<option>이벤트 카테고리를 선택하세요</option>
				<option>쿠폰</option>
				<option>할인</option>
				<option>체험단</option>
				<option>AD's Pick</option>
				<option>그 외</option>
			</select>
		</div>
	</div>

	<div class="part_section period_part">
		<div class="part_title">
			진행기간 <span class="reqired_write">*</span>
		</div>
		<div class="part_content">
			<div class="period_box">
				<div class="period_body">
					<div>
						<input type="date" class="btn start_date" /> <span> - </span> <input
							type="date" class="btn end_date" />
					</div>

					<div class="p_choice">
						<input type="button" class="btn" value="일주일" /> <input
							type="button" class="btn" value="1개월" /> <input type="button"
							class="btn" value="1년" />
					</div>
				</div>
			</div>
		</div>
	</div>

	<div class="part_section pCate_part">
		<div class="part_title">
			상품 카테고리 <span class="reqired_write">*</span>
		</div>
		<div class="part_content">
			<select class="cate_sb">
				<option>대분류</option>
				<option>쿠폰</option>
				<option>할인</option>
				<option>체험단</option>
				<option>AD's Pick</option>
				<option>그 외</option>
			</select> <select class="cate_sb">
				<option>중분류</option>
				<option>쿠폰</option>
				<option>할인</option>
				<option>체험단</option>
				<option>AD's Pick</option>
				<option>그 외</option>
			</select> <select class="cate_sb">
				<option>소분류</option>
				<option>쿠폰</option>
				<option>할인</option>
				<option>체험단</option>
				<option>AD's Pick</option>
				<option>그 외</option>
			</select>
		</div>
	</div>

	<div class="part_section mainhead_part">
		<div class="part_title">
			이벤트명 <span class="reqired_write">*</span>
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






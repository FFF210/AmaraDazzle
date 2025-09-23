<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!-- *********************************메인부분********************************* -->
<section class="board_write">
	<div class="part_section title_part">
		<div class="part_title">
			제목 <span class="reqired_write">*</span>
		</div>
		<div class="part_content">
			<input type="text" />
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
						<input type="button" class="btn" value="1주일" /> <input
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

	<div class="part_section thumb_part">
		<div class="part_title">
			배너이미지 <span class="reqired_write">*</span>
		</div>
		<div class="part_content">
			<div>c컴포넌트</div>
		</div>
	</div>

	<div class="part_section content_part">
		<div class="part_title">
			LINK <span class="reqired_write">*</span>
		</div>
		<div class="part_content">
			<input type="text" />
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
				<!-- <button type="button" class="btn second_btn action_btn">미리보기</button> -->
				<button type="button" class="btn first_btn action_btn">등록</button>
			</div>
		</div>
	</div>
</section>
<!-- *********************************메인부분 end********************************* -->
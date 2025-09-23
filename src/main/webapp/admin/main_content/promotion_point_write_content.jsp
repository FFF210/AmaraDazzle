<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>


<!-- *********************************메인부분********************************* -->
<section class="board_write">
	<div class="part_section reason_part">
		<div class="part_title">
			지급사유 <span class="reqired_write">*</span>
		</div>
		<div class="part_content">
			<input type="text" name="point_reason" placeholder="포인트 지급 사유를 입력하세요" />
		</div>
	</div>

	<div class="part_section amount_part">
		<div class="part_title">
			포인트 금액 <span class="reqired_write">*</span>
		</div>
		<div class="part_content">
			<input type="text" name="point_amount"
				placeholder="지급할 포인트 금액를 입력하세요" style="width: 50%" /> &nbsp;원
		</div>
	</div>

	<div class="part_section target_part name_part">
		<div class="part_title">
			지급대상 <span class="reqired_write">*</span>
		</div>
		<div class="part_content">
			<button type="buton" class="btn action_btn first_btn search_btn">검색</button>
			<input type="text" name="coupon_user" placeholder="회원아이디 or 모든회원"
				style="cursor: default" readonly /> <input type="text"
				name="coupon_user2" placeholder="회원명 or 등급" style="cursor: default"
				readonly />
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
				<button type="button" class="btn first_btn action_btn">등록</button>
			</div>
		</div>
	</div>
</section>
<!-- *********************************메인부분 end********************************* -->